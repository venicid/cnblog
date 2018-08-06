from django.urls import path, re_path
from blog import views
from django.views.static import serve
from cnblog import settings

urlpatterns = [
    re_path('^login/$', views.login, name='login'),
    re_path('^get_validCode/$', views.get_validCode, name='get_validCode'),
    re_path('^register/$', views.register, name='register'),
    re_path('^logout/$', views.logout, name='logout'),

    # 主页
    re_path('^index/$', views.index, name='index'),

    # media配置
    re_path(r'^media/(?P<path>.*)/$', serve, {"document_root": settings.MEDIA_ROOT}),

    # 个人站点页面设计
    re_path(r'^(?P<username>\w+)$', views.home_site, name='home_site'),
    # 个人站点的跳转
    re_path(r'^(?P<username>\w+)/(?P<condition>tag|category|archive)/(?P<param>.*)/$', views.home_site, name='home_site'),


    # 文章详情页
    re_path(r'^(?P<username>\w+)/articles/(?P<article_id>\d+)$', views.article_detail, name='article_detail'),

    # 点赞
    re_path('^digg/$', views.digg, name='digg'),

    # 评论
    re_path('^comment/$', views.comment, name='comment'),
    # 评论树
    re_path('^get_comment_tree/$', views.get_comment_tree, name='get_comment_tree'),


    # 后台管理url
    re_path(r'^cn_backend/$', views.cn_backend, name='cn_backend'),
    re_path(r'^cn_backend/add_article/$', views.add_article, name='add_articles'),

    # 富文本编辑框 图片上传
    re_path(r'^upload/$', views.upload, name='upload'),

]
