## BBS+ BLOG系统（仿博客园）

### 一、概要

```
欢迎您使用该BBS+BLOG系统，希望在您使用的过程中体验到便捷和愉快的使用感受，并对我们的软件提出您发现的问题和建议，谢谢。
联系邮箱：liangshuo1994@outlook.com
```

**注意事项：**

1、相关文件说明：

```
tree.txt          该项目的所有文件
requirements.txt  依赖包文件
img-floder        项目效果图
tables		  表关系
```

2、环境安装：

```
请您在python官网下载python3.5以上版本进行安装。
```

3、当前程序的所有依赖包及其精确版本号。

```
请您打开CMD控制台，到依赖包同目录下，执行：pip install -r requirements.txt
```

4、测试用例文档给您提供了更好的测试思路，您可以通过测试用例达到更好的测试效果

5、该项目博客地址: [<https://www.cnblogs.com/venicid/category/1261668.html>]

6、github地址： [<https://github.com/venicid/cnblog>]

7、效果图

![1533721366225](https://github.com/venicid/cnblog/blob/master/img-floder/index.png?raw=true)

### 二、项目流程

```
1 搞清楚需求（产品经理）
	(1) 基于用户认证组件和AJAX实现登录验证（图片验证码）

	(2)	基于forms组件和ajax实现注册功能

	(3) 设计系统首页 (文章列表渲染)

	(4) 设计个人站点页面

	(5)	文章详情页

	(6) 实现文章点赞功能

	(7) 实现文章的评论
	    -------文章的评论
		-------评论的评论

	(8) 后台管理页面
		--- 富文本编辑框
		--- 防止xss攻击


2 设计表结构


3 按着每一个功能进行开发


4 功能测试


5 项目部署上线

```

### 二、功能实现

1. login_reg_404模块

```
	1) 主页
        /
    2) 注册
        /reg/
    3) 登录
        /login/
        /get_validCode/		# 验证码
    4) 注销
        /logout/
    5) 404页面
    	not_found.html
```



2. 个人站点，文章模块

```
1) 个人站点页面
	/alex/

2) 文章详情页
	/alex/articles/4
	/digg				# 点赞
	/comment			# 评论
	/get_comment_tree	# 评论树展示
	
4）media开放目录
	/media
```



3. 后台管理

```
	/cn_backend				   # 主页
	/cn_backend/add_article/	# 添加文章
	/cn_backend/edit_article/4   # 编辑文章
	/delete						# 删除
```



### 三、所用技术概述

1、验证用户是否登录：用户认证组件

```
实质：session会话跟踪技术
from django.contrib import auth
通过中间件auth_middleware.py,采用白名单，对url进行控制，替代装饰器@login_requierd，否则每一个函数都有要加装饰器。
from django.utils.deprecation import MiddlewareMixin
```

2、验证字段：表单forms组件

```
对每个数据库中的字段进行校验，返回error
from django import forms
```

3、自定义分页器

```
分页器pagination.py
解耦
from blog.utils.pagination import MyPaginator  # 分页器
```

4、记录日志log

```
settings配置文件，终端打印sql语句
mylog.py 日志文件，解耦，终端打印并在log文件记录用户操作
import logging
```

5、模板继承

```
{% extends 'base.html' %}

{% block site-header %}

{% endblock %}
```

6、ORM表关系

```
一对一(user blog)
一对多(user article)
多对多(article tag)
```

7、注意点：

```
1) 时区：
settings.py配置
	# TIME_ZONE = 'UTC'
	TIME_ZONE = 'Asia/Shanghai'
	USE_TZ = False

2) 静态文件目录
STATICFILES_DIRS = [
	os.path.join(BASE_DIR, 'static')
]
```

8、连接mysql数据库

```python
settings配置
# 连接mysql数据库
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'cnblog',            # 要连接的数据库，连接前需要创建好
        'USER': 'root',           # 连接数据库的用户名
        'PASSWORD': 'root',          # 连接数据库的密码
        'HOST': '127.0.0.1',     # 连接主机，默认本级
        'PORT': 3306,            # 端口 默认3306
    }
}
```

9、评论后发送邮件

```python
settings文件配置
# 发送邮件
EMAIL_USE_SSL = True
# EMIAL_HOST = 'smtp.exmail.qq.com'       # 如果是163 改成smtp.163.com
EMAIL_HOST = 'smtp.qq.com'  # 如果是 163 改成 smtp.163.com
EMAIL_PORT = 465
EMAIL_HOST_USER = '719633333@qq.com'        # 账号
EMAIL_HOST_PASSWORD = 'or333333ndzubdie'    # qq邮箱的授权码而不是密码
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER


views视图
from django.core.mail import send_mail  # 发送邮件

# 多进程发送邮件
t = threading.Thread(target=send_mail, args=("你的文章【%s】新增了一条评论内容" % article_obj.title,
                                                 content,
                                                 settings.EMAIL_HOST_USER,
                                                 [request.user.email],
                                                 ))
 t.start()
```

10、验证码

```
PIL模块生成验证码
from PIL import Image, ImageDraw, ImageFont
```

11、自定义tag标签

```
from django import template
register = template.Library()
@register.inclusion_tag("blog/classification.html")
def get_classification_style(username):
```

12、数据库事务操作

```
from django.db import transaction  # 事务操作
```

13、富文本编辑框
```
KindEditor
```

14、防止xss攻击
```
from bs4 import BeautifulSoup
```


### 四、鸣谢

```
感谢在开发过程中的老师和同学们的帮助。
```
