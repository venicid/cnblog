from django.shortcuts import render, HttpResponse, redirect
from blog.utils.validCode import get_validCode_img  # 导入验证码函数
from django.http import JsonResponse  # Json数据返回到前端
from django.contrib import auth     # 用户认证组件
from blog.models import UserInfo
from blog.myForms import UserForm  # froms组件


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
                auth.login(request, user)   # request.user == 当前登录对象
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


def index(request):

    return HttpResponse(request.user.username)





def register(request):
    """
    注册页面
    :param request:
    :return:
    """
    # if request.method == 'POST':
    if request.is_ajax():
        response = {'user':None, "msg":None}

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

    return render(request, "blog/register.html", {'form':form})
