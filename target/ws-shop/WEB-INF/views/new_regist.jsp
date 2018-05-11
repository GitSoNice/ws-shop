<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/register.css" rel="stylesheet" type="text/css"/>

    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />

    <style>
        .error {
            color: red
        }

        .nessary {
            color: red
        }
    </style>

    <script>
        function checkForm() {
            var username = $("#username").val();
            if (username == null || username == '') {
                alert("用户名不能为空!");
                return false;
            }
            if ((username.charAt(0).charCodeAt(0) < 65) || (username.charAt(0).charCodeAt(0) > 90)) {
                alert("输入的用户名首字符必须是大写字母");
                return false;
            }
            var password = $("#password").val();
            if (password == null || password == '') {
                alert("密码不能为空!");
                return false;
            }
            var repassword = $("#repassword").val();
            if (repassword != password) {
                alert("两次密码输入不一致!");
                return false;
            }
            var address = $("#address").val();
            if (address == null || address == '') {
                alert("地址不能为空!");
                return false;
            }
            var email = $("#email").val();
            if (email == null || email == '') {
                alert("邮箱不能为空!");
                return false;
            }
            var age = $("#age").val();
            if (age == null || age == '') {
                alert("年龄不能为空!");
                return false;
            }
        }

        function checkUsername() {
            $.post(
                "checkUser/" + $("#username").val(),
                {},
                function (data) {
                    if (data == 1) {
                        document.getElementById("span1").innerHTML = "<font color='red'>用户名已经存在</font>";
                        $("#username").val("");
                        $("#username").focus();
                        $(".submit").unbind("click",
                            function (event) {

                            });
                    } else {
                        document.getElementById("span1").innerHTML = "<font color='green'>该用户名可以使用</font>";
                    }
                });
        }
    </script>

</head>

<body>
<%@ include file="new_menu.jsp" %>
<div class="container register" style="width:950px;margin-top:10px;">
    <div class="span24">
        <div class="wrap">
            <div class="main clearfix">
                <div class="title">
                    <strong>用戶注册</strong>USER REGISTER
                </div>

                <form:form commandName="user" action="${ pageContext.request.contextPath }/register" method="post" modelAttribute="user" onsubmit="return checkForm();">
                    <table>
                        <tbody>
                        <tr>
                            <th><span class="nessary">*</span>用户名:</th>
                            <td><form:input path="username" id="username"
                                            class="inputText" maxlength="20" onblur="checkUsername()"  placeholder="首字母必须大写"/> <span
                                    id="span1" style="padding-left: 10px;"></span></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>密&nbsp;&nbsp;码:</th>
                            <td><form:password path="password" id="password" name="password"
                                               class="inputText" maxlength="20"  placeholder="请输入密码"/></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>确认密码:</th>
                            <td><input id="repassword" type="password"
                                       name="repassword" class="inputText" maxlength="20"  placeholder="请重复输入密码"/></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>E-mail:</th>
                            <td><form:input path="email" id="email"
                                            class="inputText" maxlength="20" placeholder="请输入正确的邮箱地址"/>
                                <form:errors path="email" cssClass="error"/>
                            </td>
                        </tr>
                        <tr>
                            <th>姓名:</th>
                            <td><form:input path="name" class="inputText"
                                            maxlength="200" placeholder="请输入您的姓名"/></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>年龄:</th>
                            <td><form:input path="age" id="age" class="inputText" type="number" min="1"
                                            maxlength="3" placeholder="请输入您的年龄"/>
                                <form:errors path="age" cssClass="error"/>
                            </td>
                        </tr>
                        <tr>
                            <th>电话:</th>
                            <td><form:input path="phone" class="inputText" placeholder="请输入您的电话"/>
                                <form:errors path="phone" cssClass="error"/></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>地址:</th>
                            <td><form:input path="addr" class="inputText" id="address"
                                            maxlength="200" placeholder="请输入您的地址"/></td>
                        </tr>
                        <tr>
                            <th><span class="nessary">*</span>验证码:</th>
                            <td><span class="fieldSet"> <input type="inputText"
                                                               id="checkcode" name="checkcode" class="inputText captcha"
                                                               maxlength="4"/> <img id="checkImg" class="captchaImage"
                                                                                    src="${pageContext.request.contextPath}/getCheckCodeImage"
                                                                                    onclick="changeImg()"
                                                                                    title="点击更换验证码"/></span>
                                <c:if test="${errorCheckCode !=null}">
                                    <font color="red">验证码出错</font>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <th>&nbsp;</th>
                            <td><input type="submit" class="submit" value="确认注册"/></td>
                        </tr>

                        </tbody>
                    </table>

                </form:form>
            </div>
        </div>
    </div>
</div>
<div id="_my97DP"
     style="position: absolute; top: -1970px; left: -1970px;">
</div>

<script type="text/javascript">
    function changeImg() {
        var img1 = document.getElementById("checkImg");
        img1.src = "${pageContext.request.contextPath}/getCheckCodeImage"
            + "?date=" + new Date();
    }
</script>

</body>
</html>
