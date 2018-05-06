<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>个人信息</title>
    <link href="${pageContext.request.contextPath}/css/common.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/userinfo.css"
          rel="stylesheet" type="text/css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <style>
        .submit{
            width: 120px;
            height: 34px;
            font-size: 22px;
            border-radius: 10px;
            margin-left: 10px;
            color: #ffffff;
            background-color: #8a65e6;
            cursor: pointer;
            outline: none;
            blr: expression(this.hideFocus = true);
            border: none;
        }
        .inputText {
            width: 200px;
            height: 34px;
            font-size:22px;
            line-height: 26px;
            padding: 0px 4px;
            color: #666666;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 5px;
            border: 1px solid;
            border-color: #b8b8b8 #dcdcdc #dcdcdc #b8b8b8;
        }

        .inputText:hover {
            -webkit-transition: box-shadow linear 0.2s;
            -moz-transition: box-shadow linear 0.2s;
            -ms-transition: box-shadow linear 0.2s;
            -o-transition: box-shadow linear 0.2s;
            transition: box-shadow linear 0.2s;
            -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            border: 1px solid #74b9ef;
            background: white;
        }

    </style>
</head>

<body>
<c:if test="${resetfailed != null }">
    <script>
        alert('修改密码失败！旧密码不正确');
    </script>
</c:if>
<c:if test="${emailFalse != null }">
    <script>
        alert('发送邮件失败！邮箱不正确');
    </script>
</c:if>
<c:if test="${sendEmail != null }">
    <script>
        alert('发送邮件失败！更新密码失败！');
    </script>
</c:if>
<c:if test="${noExistUser != null }">
    <script>
        alert('该用户不存在，请填写正确的用户名');
    </script>
</c:if>
<ul class="topmenu">
    <li>
        <a href="${pageContext.request.contextPath}/index" class="active">返回首页</a>
    </li>
</ul>

<div class="clearfix">
        <div class="content column">
                <div calss="header">
                    <h1>重置密码</h1>
                    <a class="edit" onclick="changStatus();"><img src="images/forget.jpg">忘记密码</a>
                </div>
                <div id="div2">
                    <form id= "form2" action="${pageContext.request.contextPath}/beSendEmail" method="post" >
                         <table class="show">
                            <tr class="showinfotr">
                                <td style="padding-right: 50px;">用户名：</td>
                                <td><input type="text" class="inputText" name="username" onblur="checkUsername()"/></td>
                            </tr>
                            <tr class="showinfotr">
                                <td style="padding-right: 50px;">邮箱：</td>
                                <td><input type="text" class="inputText" name="email" /></td>
                            </tr>
                             <tr class="showinfotr">
                                 <td><input type="submit" value="发送邮件" class="submit"/></td>
                             </tr>
                         </table>
                    </form>
            </div>

            <div id="div1">
                <form id= "form1" action="${pageContext.request.contextPath}/beReset" method="post" >
                    <table class="show">
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">用户名：</td>
                            <td><input type="text" class="inputText"  name="username" /></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">旧密码：</td>
                            <td><input type="password" class="inputText" name="password" /></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">新密码：</td>
                            <td><input type="password" class="inputText" name="repassword" /></td>
                        </tr>
                        <tr class="showinfotr">
                            <td><input type="submit" value="修改" class="submit"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
</div>
</div>
</body>
<script type="text/javascript">
    $(function(){
        init();
    });

    function init(){
        $("#div2").hide();
        $("#div1").show();
    }
    function changStatus(){
        $("#div1").hide();
        $("#div2").show();
    }

    function change(){
        $.ajax({
            url:'${pageContext.request.contextPath}/updateUserInfo',
            type:"POST",
            dataType:"text",
            data: $("#form1").serializeArray(),
            contentType: "application/x-www-form-urlencoded",
            success: function(res) {
                if(res.code == 200){
                    alert("更新成功！");
                }else{
                    alert("更新失败！");
                }
                init();
            }
        });
    }

    function checkUsername() {
        $.post(
            "checkUser/" + $("#username").val(),
            {},
            function (data) {
                if (data == 1) {
                    document.getElementById("span1").innerHTML = "<font color='red'>用户名不存在</font>";
                    $("#username").val("");
                    $("#username").focus();
                    $(".submit").unbind("click",
                        function (event) {

                        });
                } else {
                    document.getElementById("span1").innerHTML = "<font color='green'>用户名存在，请继续填写邮箱</font>";
                }
            });
    }
</script>
</html>