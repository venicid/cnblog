# 方式1
# with open('./static/blog/img/test1.png', 'rb') as f:
#     data = f.read()
# print(data)


# 方式2  # pip install pillow
# from PIL import Image
# img = Image.new("RGB", (270, 35), color=get_random_color())
#
# with open('validCode.png', 'wb') as f:
#     img.save(f, 'png')        # 在本地生成一张图片validCode.png
#
# with open('validCode.png', 'rb') as f:
#     data = f.read()


# 方式3：内存处理
# from PIL import Image, ImageDraw, ImageFont
# from io import BytesIO
#
# img = Image.new('RGB', (210, 35), color=get_random_color())
#
# f = BytesIO()
# img.save(f, 'png')
# data = f.getvalue()


import random


def get_random_color():
    return tuple([random.randint(0, 255) for _ in range(3)])


def get_valid_code_img(request):
    # 方式4：
    from PIL import Image, ImageDraw, ImageFont
    from io import BytesIO

    img = Image.new('RGB', (210, 35), color=get_random_color())
    # 在img上作画
    draw = ImageDraw.Draw(img)
    holly_font = ImageFont.truetype('static/font/holly.ttf', size=28)

    # 生成5个字符(数字或字母)
    # global valid_code_str = ""  #设置成全局变量，多个用户访问出现bug
    valid_code_str = ""
    import string

    for i in range(5):
        random_char = random.choice(string.digits + string.ascii_letters)
        draw.text((i * 40 + 20, 5), random_char, get_random_color(), font=holly_font)

        # 保存验证码字符串
        valid_code_str += random_char

    # print("valid_code_str", valid_code_str)
    request.session['valid_code_str'] = valid_code_str  # 把验证码存在session中

    """
    1   fasdfsadfsda
    2   COOKIE {"sessionid": fasdfsadfsda}
    3   django-session
        session-key     session-data
        fasdfsadfsda    {"valid_code_str":'12sda'}
    """

    """
    # 补充噪点噪音
    width, height = 210, 35
    for i in range(100):
        x1 = random.randint(0, width)
        x2 = random.randint(0, width)
        y1 = random.randint(0, width)
        y2 = random.randint(0, width)
        draw.line((x1, y1, x2, y2), fill=get_random_color())

    for i in range(400):
        draw.point([random.randint(0, width), random.randint(0, height)], fill=get_random_color())
        x = random.randint(0, width)
        y = random.randint(0, height)
        draw.arc((x, y, x+4, y+4), 0, 90, fill=get_random_color())
    """

    # draw.text((0, 5), "python", get_random_color(), font=holly_font)     # 文字
    # draw.line()     # 线
    # draw.point()    # 点

    f = BytesIO()
    img.save(f, 'png')
    data = f.getvalue()

    return data
