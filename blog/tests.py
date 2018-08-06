from django.test import TestCase

# Create your tests here.

from bs4 import BeautifulSoup

s = "<h1>hello</h1> <span>world</sapn> <script>alert(1111)</script>"

soup = BeautifulSoup(s, "html.parser")      # 按照html格式过滤

print(soup.text)        # 过滤掉标签，只剩下text文本

print(soup.find_all())  # 按标签进行截断

for tag in soup.find_all():
    print(tag.name)     # 打印标签的name

    if tag.name == "script":
        tag.decompose()     # Recursively destroys the contents of this tree.

print(str(soup))