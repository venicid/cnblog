# 方式4：加入噪点的
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
import random
import string  # string字符串


def get_random_color():
    return tuple([random.randint(0, 255) for _ in range(3)])


def get_validCode_img(request):
    holly_font = ImageFont.truetype('static/font/holly.ttf', size=28)  # 字体

    img = Image.new('RGB', (210, 35), color=get_random_color())
    draw = ImageDraw.Draw(img)  # 在img上作画

    # draw数字字母5个
    valid_code_str = ""  # 保存验证码字符串
    for i in range(5):
        random_char = random.choice(string.digits + string.ascii_letters)
        draw.text((i * 40 + 20, 5), random_char, get_random_color(), font=holly_font)
        valid_code_str += random_char

    print("valid_code_str", valid_code_str)

    # 把验证码放入session中
    request.session["valid_code_str"] = valid_code_str

    # 内存处理
    f = BytesIO()
    img.save(f, 'png')
    data = f.getvalue()

    return data
