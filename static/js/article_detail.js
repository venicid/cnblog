/**
 *
 * Created by Venicid on 2018/08/08 0008.
 */

$(function () {
    //点赞请求
    $("#div_digg .action").click(function () {
        var is_up = $(this).hasClass("diggit");

        $obj = $(this).children("span");        // 获取点赞数


        $.ajax({
            url: "/digg/",
            type: "post",
            data: {
                "csrfmiddlewaretoken": $("[name='csrfmiddlewaretoken']").val(),
                "is_up": is_up,
                "article_id":article_id,
            },
            success: function (data) {
                console.log(data)
                // 点赞 +1
                if (data.state) {
                    var val = parseInt($obj.text());
                    $obj.text(val + 1)

                } else {

                    //点赞过了
                    var val = data.handled ? "您已经推荐过了" : "您已经反对过了"
                    $('#digg_tips').html(val)

                    setTimeout(function () {
                        $("#digg_tips").html("")
                    }, 2000)
                }
            }
        })
    })
})

$(function () {
    //评论请求
    var parent_id = "";

    $('.comment_btn').click(function () {

        var content = $("#comment_content").val()

        if (parent_id) {
            var index = content.indexOf("\n")
            content = content.slice(index + 1)
        }

        $.ajax({
            url: '/comment/',
            type: "post",
            data: {
                "csrfmiddlewaretoken": $("[name='csrfmiddlewaretoken']").val(),
                "article_id":article_id,
                "content": content,
                "parent_id": parent_id,

            },
            success: function (data) {
                console.log(data);

                // dom操作  es6  标签字符串
                var create_time = data.create_time
                var username = data.username
                var content = data.content

                var s = `
                <li class="list-group-item">
                    <div class="comment_head">
                        <span>${create_time}</span>&nbsp;&nbsp;
                        <a href="">${username}</a>
                        <a class="pull-right">回复</a>
                    </div>

                    <div class="comment_content">
                        <p>${content}</p>
                    </div>
                </li>`;


                $("ul.comment_list").append(s)

                //清空评论框
                parent_id = ""
                $("#comment_content").val("")
            }
        })


    })

    //回复按钮事件
    $(".reply_btn").click(function () {

        $("#comment_content").focus()
        var val = "@" + $(this).attr("username") + "\n";
        $("#comment_content").val(val)

        parent_id = $(this).attr("parent_comment_pk")

    })


    //评论树
    $(".tree_btn").click(function () {

        $.ajax({
            url: "/get_comment_tree/",
            type: "get",
            data: {
                article_id:article_id
            },
            success: function (comment_list) {
                $.each(comment_list, function (index, comment_object) {
                    var pk = comment_object.pk
                    var content = comment_object.content
                    var parent_comment_id = comment_object.parent_comment_id

                    var s = '<div class="comment_item well" comment_id=' + pk + '><span>' + content + '</span>' + '</div>'

                    if (!parent_comment_id) {
                        //根评论展示
                        $(".comment_tree").append(s)

                    } else {
                        //子评论展示
                        $("[comment_id=" + parent_comment_id + "]").append(s)
                    }

                })
            }
        })

        $('.comment_tree').html("")

    })
})

