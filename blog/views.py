from django.shortcuts import render, HttpResponse, redirect
from blog.utils.validCode import get_validCode_img  # 导入验证码函数
from django.http import JsonResponse  # Json数据返回到前端
from django.contrib import auth  # 用户认证组件
from blog.models import UserInfo
from blog.myForms import UserForm  # froms组件
from blog import models
from django.db.models import Avg, Max, Min, Count, F, Q
from django.db import transaction  # 事务操作
from django.contrib.auth.decorators import login_required  # 用户登录证装饰器


def login(request):
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
            else:
                response["msg"] = "用户名或者密码错误"

        else:
            response['msg'] = "验证码错误"

        return JsonResponse(response)

    return render(request, 'blog/login.html')


def get_validCode(request):
    """
    基于PIL模块动态生成响应状态码图片
    :param request:
    :return:
    """
    data = get_validCode_img(request)
    return HttpResponse(data)


"""
 # 方式1：HttpResponse返回字符串
def get_validCode(request):

    with open('mingren.jpg', 'rb') as f:
        data = f.read()

    return HttpResponse(data)
"""

'''
# 方式2：基于PIL模块  pip install pillow
from PIL import Image
import random


def get_random_color():
    """生成随机颜色(255,255,255)"""
    return tuple([random.randint(0, 255) for _ in range(3)])


def get_validCode(request):
    # 在本地生成一张图片validCode.png
    img = Image.new("RGB", (270, 35), color=get_random_color())
    with open("validCode.png", 'wb') as f:
        img.save(f, 'png')

    with open('validCode.png', 'rb') as f:
        data = f.read()

    return HttpResponse(data)
'''

'''
# 方式3：内存处理
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
import random


def get_random_color():
    """生成随机颜色(255,255,255)"""
    return tuple([random.randint(0, 255) for _ in range(3)])


def get_validCode(request):

    # 在内存生成一张图片validCode.png
    img = Image.new('RGB', (210, 35), color=get_random_color())
    f = BytesIO()
    img.save(f, 'png')
    data = f.getvalue()

    return HttpResponse(data)
'''


def register(request):
    """
    注册页面
    :param request:
    :return:
    """
    # if request.method == 'POST':
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
            print(avatar_obj)

            extra_fields = {}
            if avatar_obj:
                extra_fields["avatar"] = avatar_obj

            UserInfo.objects.create_user(username=user, password=pwd, email=email, **extra_fields)

            """
            if avatar_obj:
                # 快捷键 alt + f7
                UserInfo.objects.create_user(username=user, password=pwd, email=email, avatar=avatar_obj)
            else:
                UserInfo.objects.create_user(username=user, password=pwd, email=email)
            """

        else:
            print(form.cleaned_data)
            print(form.errors)
            response['msg'] = form.errors

        return JsonResponse(response)

    form = UserForm

    return render(request, "blog/register.html", {'form': form})


def logout(request):
    auth.logout(request)  # request.session.flush()

    return redirect('/login/')


def index(request):
    article_list = models.Article.objects.all()

    return render(request, "blog/index.html", {"article_list": article_list})


'''
def home_site(request, username):
    """
    个人站点视图函数
    :param request:
    :return:
    """
    # print("username", username)
    user_obj = models.UserInfo.objects.filter(username=username).first()

    # 判断用户是否存在
    if not user_obj:
        return render(request, "blog/not_found.html")

    # 查询当前站点对象
    blog = user_obj.blog

    # 当前用户或者当前站点对应的所有文章

    # 方式1：基于对象查询
    article_list = user_obj.article_set.all()

    # 方式2：基于__
    article_list = models.Article.objects.filter(user=user_obj)

    # 跨表的分组查询的模型:
    # 每一个后的表模型.objects.values("pk").annotate(聚合函数(关联表__统计字段)).values("表模型的所有字段以及统计字段")   # 推荐pk字段查找

    from django.db.models import Avg, Max, Min, Count, F, Q

    # 查询每一个分类名称以及对应的文章数
    # 全部blog的
    ret1 = models.Category.objects.values('pk').annotate(c=Count("article__title")).values("title", 'c')
    # print(ret1)

    # 查询当前站点的每一个分类名称以及对应的文章数
    # 只取当前用户站点的
    # ret1 = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values("title",'c')
    cate_list = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values_list("title", 'c')
    # print(ret1)


    # 查询当前站点的每一个标签名称以及对应的文章数
    ret = models.Tag.objects.values('pk').annotate(c=Count('article')).values_list('title','c')
    tag_list = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article')).values_list('title','c')
    # print(ret)
    # print(ret1)




    # 查询当前站点每一个年月的名称以及对应的文章数


    # 查看最近发布的文章
    ret1 = models.Article.objects.extra(select={'is_recent':"create_time > 2018-07-28"}).values('title', 'is_recent')
    # print(ret1)

    # 查看这个月发布的文章
    ret1 = models.Article.objects.extra(select={'y_m_date':"date_format(create_time,'%%Y-%%m')"}).values('title', 'y_m_date')
    # print(ret1)

    # 统计年月日
    ret1 = models.Article.objects.extra(select={'y_m_date':"date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(c=Count('nid')).values_list('y_m_date', 'c')
    #(只统计本站点，用户的)
    date_list = models.Article.objects.filter(user=user_obj).extra(select={'y_m_date':"date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(c=Count('nid')).values_list('y_m_date', 'c')
    # print(ret1)

    # 方式2：
    from django.db.models.functions import TruncMonth

    models.Article.objects.filter(user=user_obj).annotate(month=TruncMonth('create_time')).values('month').annotate(c=Count('nid')).values_list('month','c')



    return render(request, 'blog/home_site.html', {'blog':blog,'article_list':article_list,"tag_list":tag_list,"date_list":date_list, "cate_list":cate_list})

'''


def home_site(request, username, **kwargs):
    print("kwargs", kwargs)

    user_obj = models.UserInfo.objects.filter(username=username).first()

    # 判断用户是否存在
    if not user_obj:
        return render(request, "blog/not_found.html")

    # 查询当前站点对象
    blog = user_obj.blog

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
            print(article_list)
        else:
            year, month = param.split('-')
            print(year, month)
            article_list = models.Article.objects.filter(user=user_obj).filter(create_time__year=year,
                                                                               create_time__month=month)
            print(article_list)

    from django.db.models import Avg, Max, Min, Count, F, Q
    # 查询当前站点的每一个分类名称以及对应的文章数
    cate_list = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values_list(
        "title", 'c')

    # 查询当前站点的每一个标签名称以及对应的文章数
    tag_list = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article')).values_list('title', 'c')

    # 统计年月日
    date_list = models.Article.objects.filter(user=user_obj).extra(
        select={'y_m_date': "date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(
        c=Count('nid')).values_list('y_m_date', 'c')

    return render(request, 'blog/home_site.html',
                  {"username": username, 'blog': blog, 'article_list': article_list, "tag_list": tag_list,
                   "date_list": date_list, "cate_list": cate_list})


# 解决复用问题：方式1
'''
def article_detail(request, username, article_id):
    """文章详情页"""

    context = get_query_data(username)

    return render(request,'blog/article_detail.html',context)


def get_query_data(username):
    user_obj = models.UserInfo.objects.filter(username=username).first()
    blog = user_obj.blog
    cate_list = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values_list("title", 'c')
    tag_list = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article')).values_list('title','c')
    date_list = models.Article.objects.filter(user=user_obj).extra(select={'y_m_date':"date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(c=Count('nid')).values_list('y_m_date', 'c')

    return {'blog':blog,"tag_list":tag_list,"date_list":date_list, "cate_list":cate_list}

'''


def article_detail(request, username, article_id):
    """文章详情页"""
    user_obj = models.UserInfo.objects.filter(username=username).first()
    blog = user_obj.blog

    # article_id对应的文章
    article_obj = models.Article.objects.filter(pk=article_id).first()

    # 评论显示
    comment_list = models.Comment.objects.filter(article_id=article_id)

    return render(request, 'blog/article_detail.html', locals())


import json


def digg(request):
    """点赞视图"""
    # print(request.POST)
    article_id = request.POST.get("article_id")
    # article_id = request.POST.get("is_up")       # true
    is_up = json.loads(request.POST.get("is_up"))  # True
    user_id = request.user.pk  # 点赞人即为登录人

    # 点赞记录以及存在
    from django.http import JsonResponse  # Json数据返回到前端
    response = {"state": True, "msg": None, "handled": None}

    obj = models.ArticleUpDown.objects.filter(user_id=user_id, article_id=article_id).first()
    if not obj:
        # 创建一条点赞记录
        ard = models.ArticleUpDown.objects.create(user_id=user_id, is_up=is_up, article_id=article_id)
        from django.db.models import F
        # 点赞数的保存
        queryset = models.Article.objects.filter(pk=article_id)
        if is_up:
            queryset.update(up_count=F("up_count") + 1)
        else:
            queryset.update(down_count=F("down_count") - 1)
    else:
        response['state'] = False
        response['handled'] = obj.is_up

    return JsonResponse(response)


def comment(request):
    """评论视图"""
    article_id = request.POST.get("article_id")
    content = request.POST.get("content")
    parent_id = request.POST.get("parent_id")
    user_id = request.user.pk

    article_obj = models.Article.objects.filter(pk=article_id).first()

    with transaction.atomic():  # 事务操作
        # 创建一条评论
        comment_obj = models.Comment.objects.create(user_id=user_id, article_id=article_id,
                                                    content=content, parent_comment_id=parent_id)
        # yun   # 事务中断
        # 评论 comment_count  +1
        models.Article.objects.filter(pk=article_id).update(comment_count=F("comment_count") + 1)

    """
    # 发送邮件
    from django.core.mail import send_mail
    from cnblog import settings

    send_mail(
        "你的文章【%s】新增了一条评论内容" % article_obj.title,
        content,
        settings.EMAIL_HOST_USER,
        ['849923747@qq.com']

    )


    import threading  # 多进程发送邮件
    t = threading.Thread(target=send_mail, args=("你的文章【%s】新增了一条评论内容" % article_obj.title,
                                                 content,
                                                 settings.EMAIL_HOST_USER,
                                                 ["849923747@qq.com"]
                                                 ))
    t.start()
"""

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
    article_list = models.Article.objects.filter(user=request.user)

    return render(request, "backend/backend.html", locals())


@login_required
def add_article(request):

    if request.method == "POST":
        title = request.POST.get('title')
        content = request.POST.get('content')

        # 过滤
        from bs4 import BeautifulSoup
        soup = BeautifulSoup(content,  "html.parser")
        for tag in soup.find_all():
            if tag.name == "script":
                tag.decompose()


        # 获取文本，进行截取，赋值给desc
        desc = soup.text[0:150]

        models.Article.objects.create(title=title,content=str(soup),desc=desc, user=request.user)
        return redirect("/cn_backend/")
    return render(request, "backend/add_article.html", locals())


def upload(request):
    """上传文件"""
    print(request.FILES)

    # 获取文件name
    img = request.FILES.get("upload_img")
    print(img.name)

    # 文件存取路径
    import os
    from cnblog import settings
    img_path = os.path.join(settings.MEDIA_ROOT, "add_article_img", img.name)

    # 图片读取，写入到服务端
    with open(img_path, "wb") as f:
        for line in img:
            f.write(line)


    # 文件预览功能
    response = {
        "error":0,
        "url":"/media/add_article_img/%s" % img.name
    }
    import json
    return HttpResponse(json.dumps(response))

