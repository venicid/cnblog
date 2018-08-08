/**
 * Created by Venicid on 2018/08/08 0008.
 */


//刷新验证码
$(function () {
    $("#id_valid_code_img").click(function () {
        $(this)[0].src += "?"
    })
});

//登录验证
$(function () {
    $('.login-btn').click(function () {
        $.ajax({
            url: '',
            type: 'post',
            data: {
                user: $("#id_username").val(),
                pwd: $("#id_password").val(),
                valid_code_str: $("#id_valid_code_str").val(),
                csrfmiddlewaretoken: $("[name='csrfmiddlewaretoken']").val()

            },
            success: function (data) {
                if (data.user) {
                    location.href = "/"
                }
                else {
                    $('.error').text(data.msg).css({'color': 'red'});

                    //定时器 1s后error_msg 消失
                    setTimeout(function () {
                        $('.error').text("")
                    }, 1000)
                }
            }

        })
    })
});
