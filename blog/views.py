from django.shortcuts import render, HttpResponse, redirect

# Create your views here.
from django.contrib import auth     # 用户认证组件


def login(request):
    from django.http import JsonResponse        # Json数据返回到前端
    if request.method == "POST":

        response = {"user": None, "msg": None}
        user = request.POST.get("user")
        pwd = request.POST.get("pwd")
        valid_code = request.POST.get("valid_code")
        _valid_code_str = request.session.get("valid_code_str")

        # 验证码验证
        if _valid_code_str.upper() == valid_code.upper():

            user = auth.authenticate(username=user, password=pwd)
            if user:
                auth.login(request, user)       # request.user = user  当前登录对象
                response["user"] = user.username
                print(response)
            else:
                # response["msg"] = "username or password error!"
                response["msg"] = "用户名或者密码错误"
        else:
            # response["msg"] = "valid code error"
            response["msg"] = "验证码错误"

        return JsonResponse(response)

    return render(request, "blog/login.html")


def get_validCode(request):
    """
    基于PIL模块动态生成响应状态码图片
    :param request:
    :return:
    """
    from blog.utils.validCode import get_valid_code_img
    data = get_valid_code_img(request)    # 解耦
    return HttpResponse(data)


def index(request):

    return render(request, 'blog/index.html')

