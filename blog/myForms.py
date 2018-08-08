from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError

from blog.models import UserInfo


class UserForm(forms.Form):
    user = forms.CharField(min_length=4,max_length=32, label="用户名",
                           error_messages={'required': '该字段不能为空', 'min_length': '不能少于4个字符', },
                           widget=widgets.TextInput(attrs={"class": "form-control"}))
    pwd = forms.CharField(min_length=4,max_length=32, label="密码",
                          error_messages={'required': '该字段不能为空', 'min_length': '不能少于4个字符', },
                          widget=widgets.PasswordInput(attrs={"class": "form-control"}))
    re_pwd = forms.CharField(min_length=4,max_length=32, label="确认密码",
                             error_messages={'required': '该字段不能为空', 'min_length': '不能少于4个字符', },
                             widget=widgets.PasswordInput(attrs={"class": "form-control"}))
    email = forms.EmailField(max_length=32, label="邮箱",
                             error_messages={'required': '该字段不能为空', 'invalid': '格式错误'},
                             widget=widgets.EmailInput(attrs={"class": "form-control"}))

    # 用户名的认证
    def clean_user(self):
        user = self.cleaned_data.get('user')
        user_obj = UserInfo.objects.filter(username=user).first()
        if not user_obj:
            return user
        else:
            raise ValidationError('该用户名已经注册')

    # 密码
    def clean(self):
        pwd = self.cleaned_data.get("pwd")
        re_pwd = self.cleaned_data.get("re_pwd")

        if pwd and re_pwd:
            if pwd == re_pwd:
                return self.cleaned_data
            else:
                raise ValidationError("两次密码不一致")
        else:
            return self.cleaned_data
