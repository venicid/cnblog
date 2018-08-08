/**
 * Created by Venicid on 2018/08/08 0008.
 */

$(function () {
    $('#avatar').change(function () {
        //获取用户选中的文件对象
        var file_obj = $(this)[0].files[0];

        //获取文件对象的路径
        var reader = new FileReader();
        reader.readAsDataURL(file_obj);

        //修改img的src属性， src= 文件对象的路径
        // $(this).prepend('img').attr("src", reader.result);  // 等页面加载完成在执行onload
        reader.onload = function () {
            $("#avatar_img").attr("src", reader.result)
        }
    })
});

//基于ajax提交数据
$(function () {
    $('.register-btn').click(function () {

        //获取数据
        var formdata = new FormData();
        <!--
        formdata.append("user", $('#id_user').val());
        formdata.append("pwd", $('#id_pwd').val());
        formdata.append("re_pwd", $('#id_re_pwd').val());
        formdata.append("email", $('#id_email').val());
        formdata.append("csrfmiddlewaretoken", $('[name="csrfmiddlewaretoken"]').val());
        -->
        var request_data = $('#id_form').serializeArray();
        $.each(request_data, function (index, data) {
            formdata.append(data.name, data.value)
        });

        formdata.append("avatar", $("#avatar")[0].files[0]);


        $.ajax({
            url: '',
            type: 'post',
            contentType: false,
            processData: false,
            data: formdata,
            success: function (data) {
                console.log(data);
                if (data.user) { //注册成功
                    location.href = "/login"

                } else {
                    //清空错误信息,和div的样式
                    $('span.error').html("");
                    $(".form-group").removeClass("has-error");

                    //展示error_msg
                    $.each(data.msg, function (field, error_list) {
                        if (field == "__all__") {
                            $('#id_re_pwd').next('span').html(error_list[0]).parent('div').addClass('has-error');

                        } else {
                            $('#id_' + field).next('span').html(error_list[0]).parent('div').addClass('has-error');

                        }
                    })

                }

            }
        })
    })
});
