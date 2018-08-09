from django.shortcuts import render, HttpResponse, redirect
from blog.utils.validCode import get_validCode_img  # 导入验证码函数
from django.contrib import auth  # 用户认证组件
from blog.myForms import UserForm  # froms组件
from django.db import transaction  # 事务操作
from django.contrib.auth.decorators import login_required  # 用户登录证装饰器
from django.db.models import Count, F
from django.core.mail import send_mail  # 发送邮件
from django.http import JsonResponse  # Json数据返回到前端

import json
import threading
import os

from blog import models
from blog.models import UserInfo
from cnblog import settings
from blog.utils.pagination import MyPaginator  # 分页器
from blog.utils import logging  # log日志

login_logger = logging.log_handle('login')
handle_logger = logging.log_handle('handle')


def login(request):
    """登录"""
    if request.method == "POST":
        response = {'user': None, "msg": None}
        user = request.POST.get("user")
        pwd = request.POST.get("pwd")
        valid_code_str = request.POST.get("valid_code_str")
        _valid_code_str = request.session.get("valid_code_str")

        # 验证码验证
        if valid_code_str.upper() == _valid_code_str.upper():
            # 用户认证
            user = auth.authenticate(username=user, password=pwd)
            if user:
                auth.login(request, user)  # request.user == 当前登录对象
                response["user"] = user.username
                login_logger.info("【%s】登录成功！" % user)
            else:
                response["msg"] = "用户名或者密码错误"
                login_logger.error("【%s】登录失败！" % user)
        else:
            response['msg'] = "验证码错误"

        return JsonResponse(response)

    return render(request, 'blog/login.html')


def get_validCode(request):
    """
    基于PIL模块动态生成响应状态码图片
    """
    data = get_validCode_img(request)
    return HttpResponse(data)


def register(request):
    """
    注册页面
    """
    if request.is_ajax():
        response = {'user': None, "msg": None}

        form = UserForm(request.POST)
        if form.is_valid():
            response['user'] = form.cleaned_data.get("user")

            # 生成一条数据
            user = request.POST.get("user")
            pwd = request.POST.get("pwd")
            email = request.POST.get("email")
            avatar_obj = request.FILES.get("avatar")

            extra_fields = {}
            if avatar_obj:
                extra_fields["avatar"] = avatar_obj

            # 生成用户，blog，tag，category
            with transaction.atomic():
                blog_obj = models.Blog.objects.create(title="%s的博客" % user, site_name=user, theme="%s的css" % user)
                UserInfo.objects.create_user(username=user, password=pwd, email=email, blog=blog_obj, **extra_fields)
                models.Tag.objects.create(title="%s的生活" % user, blog=blog_obj)
                models.Category.objects.create(title="%s的IT" % user, blog=blog_obj)

            login_logger.info("【%s】注册成功！" % user)

        else:
            response['msg'] = form.errors

        return JsonResponse(response)

    form = UserForm
    return render(request, "blog/register.html", {'form': form})


def logout(request):
    """注销"""
    auth.logout(request)  # request.session.flush()
    login_logger.info("【%s】退出！" % request.user.username)
    return redirect('/login/')


def index(request):
    """博客主页index"""
    article_list = models.Article.objects.all()

    user_list = models.UserInfo.objects.filter(is_superuser=0).all()

    current_page_num = request.GET.get('page', 1)
    page_obj = MyPaginator(article_list, current_page_num)
    current_path = {'path': request.path}

    ret_dic = page_obj.show_page  # 页码返回的是字典
    ret_dic.update(current_path)  # 两个字典拼接
    ret_dic['user_list'] = user_list

    return render(request, "blog/index.html", ret_dic)


def home_site(request, username, **kwargs):
    handle_logger.info("[%s] 进入 [%s]的homesite" % (request.user.username, username))
    user_obj = models.UserInfo.objects.filter(username=username).first()

    if not user_obj:
        return render(request, "blog/not_found.html")

    blog = user_obj.blog  # 查询当前站点对象

    # 当前用户或者当前站点对应的所有文章
    article_list = models.Article.objects.filter(user=user_obj)

    # 判断是否跳转到其他地方
    if kwargs:
        condition = kwargs.get("condition")  # 标签\分类\归档
        param = kwargs.get("param")  # 具体的哪一个
        if condition == "category":
            article_list = models.Article.objects.filter(user=user_obj).filter(category__title=param)
        elif condition == "tag":
            article_list = models.Article.objects.filter(user=user_obj).filter(tags__title=param)
        else:
            year, month = param.split('-')
            article_list = models.Article.objects.filter(user=user_obj).filter(create_time__year=year,
                                                                               create_time__month=month)

    # 查询当前站点的每一个分类名称以及对应的文章数
    cate_list = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values_list(
        "title", 'c')

    # 查询当前站点的每一个标签名称以及对应的文章数
    tag_list = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article')).values_list('title', 'c')

    # 统计年月日
    date_list = models.Article.objects.filter(user=user_obj).extra(
        select={'y_m_date': "date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(
        c=Count('nid')).values_list('y_m_date', 'c')

    current_page_num = request.GET.get('page', 1)
    page_obj = MyPaginator(article_list, current_page_num)
    current_path = {'path': request.path}

    ret_dic = page_obj.show_page  # 页码返回的是字典
    ret_dic.update(current_path)  # 两个字典拼接

    ret_dic['username'] = username
    ret_dic['blog'] = blog
    ret_dic['tag_list'] = tag_list
    ret_dic['date_list'] = date_list
    ret_dic['cate_list'] = cate_list

    return render(request, 'blog/home_site.html', ret_dic)


def article_detail(request, username, article_id):
    """文章详情页"""

    user_obj = models.UserInfo.objects.filter(username=username).first()
    blog = user_obj.blog

    # article_id对应的文章
    article_obj = models.Article.objects.filter(pk=article_id).first()

    # 评论显示
    comment_list = models.Comment.objects.filter(article_id=article_id)

    handle_logger.info("[%s]正在查看[%s]的[%s]文章" % (request.user.username, username, article_obj.title))
    return render(request, 'blog/article_detail.html',
                  {"blog": blog, "article_obj": article_obj, "username": username, "comment_list": comment_list})


def digg(request):
    """点赞视图"""
    response = {"user": True, "state": True, "msg": None, "handled": None}

    user_id = request.user.pk  # 点赞人即为登录人
    if not user_id:
        response["user"] = False
        return JsonResponse(response)

    # 点赞记录以及存在
    article_id = request.POST.get("article_id")
    is_up = json.loads(request.POST.get("is_up"))  # True

    article_obj = models.Article.objects.filter(pk=article_id).first()
    obj = models.ArticleUpDown.objects.filter(user_id=user_id, article_id=article_id).first()
    if not obj:
        # 创建一条点赞记录
        models.ArticleUpDown.objects.create(user_id=user_id, is_up=is_up, article_id=article_id)
        # 点赞数的保存
        queryset = models.Article.objects.filter(pk=article_id)
        if is_up:
            handle_logger.info("[%s]推荐了[%s]文章" % (request.user.username, article_obj.title))
            queryset.update(up_count=F("up_count") + 1)
        else:
            handle_logger.info("[%s]踩了下[%s]文章" % (request.user.username, article_obj.title))
            queryset.update(down_count=F("down_count") + 1)
    else:
        response['state'] = False
        response['handled'] = obj.is_up

    return JsonResponse(response)


def comment(request):
    """评论视图"""
    response = {"username": True}

    user_id = request.user.pk  # 点赞人即为登录人
    if not user_id:
        response["username"] = False
        return JsonResponse(response)

    content = request.POST.get("content")
    if len(content) == 0:
        response["content"] = None
        return JsonResponse(response)
    else:
        article_id = request.POST.get("article_id")

        parent_id = request.POST.get("parent_id")

        article_obj = models.Article.objects.filter(pk=article_id).first()

        # 事务操作
        with transaction.atomic():
            comment_obj = models.Comment.objects.create(user_id=user_id, article_id=article_id,
                                                        content=content, parent_comment_id=parent_id)
            models.Article.objects.filter(pk=article_id).update(comment_count=F("comment_count") + 1)

        handle_logger.info("[%s]评论了[%s]文章，评论内容是%s" % (request.user.username, article_obj.title, content))

        # 多进程发送邮件
        t = threading.Thread(target=send_mail, args=("你的文章【%s】新增了一条评论内容" % article_obj.title,
                                                     content,
                                                     settings.EMAIL_HOST_USER,
                                                     [request.user.email],
                                                     ))
        t.start()

        response = {}
        response["create_time"] = comment_obj.create_time.strftime("%Y-%m-%d %X")
        response["username"] = request.user.username
        response["content"] = content

        return JsonResponse(response)


def get_comment_tree(request):
    """评论树"""
    article_id = request.GET.get("article_id")
    ret = list(models.Comment.objects.filter(article_id=article_id).order_by("pk").values("pk", "content",
                                                                                          "parent_comment_id"))
    return JsonResponse(ret, safe=False)


@login_required
def cn_backend(request):
    """后台管理页面"""
    login_logger.info("【%s】进入管理后台" % request.user.username)
    article_list = models.Article.objects.filter(user__username=request.user.username)

    return render(request, "backend/backend.html", {"article_list": article_list})


@login_required
def add_article(request):
    """添加文章"""
    if request.method == "POST":
        title = request.POST.get('title')
        content = request.POST.get('content')

        # 过滤
        from bs4 import BeautifulSoup
        soup = BeautifulSoup(content, "html.parser")
        for tag in soup.find_all():
            if tag.name == "script":
                tag.decompose()

        # 获取文本，进行截取，赋值给desc
        desc = soup.text[0:150]

        models.Article.objects.create(title=title, content=str(soup), desc=desc, user=request.user)
        login_logger.info("【%s】进入添加了一篇文章%s" % (request.user.username, title))
        return redirect("/cn_backend/")

    return render(request, "backend/add_article.html")


def upload(request):
    """上传文件"""
    img = request.FILES.get("upload_img")
    img_path = os.path.join(settings.MEDIA_ROOT, "add_article_img", img.name)

    # 图片读取，写入到服务端
    with open(img_path, "wb") as f:
        for line in img:
            f.write(line)

    # 文件预览功能
    response = {
        "error": 0,
        "url": "/media/add_article_img/%s" % img.name
    }

    return HttpResponse(json.dumps(response))


def delete(request):
    """文章删除"""
    response = {"status": None, }
    article_id = request.POST.get("article_id")
    article_obj = models.Article.objects.filter(pk=article_id).first()
    models.Article.objects.filter(nid=article_id).delete()
    response['status'] = 1

    login_logger.info("【%s】进入删除了一篇文章%s" % (request.user.username, article_obj.title))
    return JsonResponse(response)


@login_required
def edit_article(request, article_id):
    """编辑文章"""
    article_obj = models.Article.objects.filter(pk=article_id).first()
    if request.method == "POST":
        title = request.POST.get('title')
        content = request.POST.get('content')

        # 过滤
        from bs4 import BeautifulSoup
        soup = BeautifulSoup(content, "html.parser")
        for tag in soup.find_all():
            if tag.name == "script":
                tag.decompose()

        # 获取文本，进行截取，赋值给desc
        desc = soup.text[0:150]

        models.Article.objects.filter(nid=article_id).update(title=title, content=str(soup), desc=desc,
                                                             user=request.user)
        login_logger.info("【%s】编辑了文章%s" % (request.user.username, article_obj.title))
        return redirect("/cn_backend/")

    return render(request, "backend/edit_article.html", {'article_obj': article_obj})
