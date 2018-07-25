from django.shortcuts import render, HttpResponse, redirect

# Create your views here.
from django.contrib import auth  # 用户认证组件


def login(request):
    from django.http import JsonResponse  # Json数据返回到前端
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
                auth.login(request, user)  # request.user = user  当前登录对象
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
    from blog.utils.validCode1 import get_valid_code_img
    data = get_valid_code_img(request)  # 解耦
    return HttpResponse(data)


def index(request):
    return render(request, 'blog/index.html')




from blog.myForms import UserForm
from blog.models import UserInfo

def register(request):
    """

    :param request:
    :return:
    """
    from django.http import JsonResponse  # Json数据返回到前端
    # if request.method == "POST":
    if request.is_ajax():
        form = UserForm(request.POST)

        response = {"user": None, "msg": None}
        if form.is_valid():
            response["user"] = form.cleaned_data.get("user")
            # 生成一条用户对象
            user = form.cleaned_data.get("user")
            pwd = form.cleaned_data.get("pwd")
            email = form.cleaned_data.get("email")
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
            response["msg"] = form.errors
            print('response',response)

        return JsonResponse(response)

    form = UserForm()
    return render(request, "blog/register.html", {"form": form})
