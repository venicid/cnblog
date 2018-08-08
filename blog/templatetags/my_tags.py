# -*- coding: utf-8 -*-
# @Time    : 2018/08/04 0004 22:03
# @Author  : Venicid
from django import template
from django.db.models import Count

from blog import models

register = template.Library()


@register.inclusion_tag("blog/classification.html")
def get_classification_style(username):
    user_obj = models.UserInfo.objects.filter(username=username).first()
    blog = user_obj.blog
    cate_list = models.Category.objects.filter(blog=blog).values('pk').annotate(c=Count("article__title")).values_list(
        "title", 'c')
    tag_list = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article')).values_list('title', 'c')
    date_list = models.Article.objects.filter(user=user_obj).extra(
        select={'y_m_date': "date_format(create_time,'%%Y-%%m')"}).values('y_m_date').annotate(
        c=Count('nid')).values_list('y_m_date', 'c')

    return {'blog': blog, "tag_list": tag_list, "date_list": date_list, "cate_list": cate_list, "username":username}
