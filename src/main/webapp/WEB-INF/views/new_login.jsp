<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css"/>
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />

    <script type="text/javascript">
        $(function () {
            //点击更换验证码
            $("#captchaImage").click(function () {
                $("#captchaImage").attr("src", "${pageContext.request.contextPath}/getCheckCodeImage?date=" + new Date().getTime());
            });
        });
        $(function () {
            $("#username").focus(function () {
                $("#username").val("");
            });
        });
    </script>
</head>

<body>
<%
    String username="";
    String check="";
    Cookie[] cookies=request.getCookies();
    for(int i=0;cookies!=null&&i<cookies.length;i++){
        if("username".equals(cookies[i].getName())){
            username=cookies[i].getValue();
            check="checked";
        }
    }
%>
    <%@ include file="new_menu.jsp" %>
<c:if test="${resetsuccess != null }">
    <script>
        alert('修改密码成功！请重新登录');
    </script>
</c:if>
<c:if test="${sendEmail != null }">
    <script>
        alert('发送重置密码邮件成功！请关注邮箱获得随机密码，重新登录');
    </script>
</c:if>
<div class="container login" style="width:950px;margin-top:10px;">
    <div class="span12">
        <div class="ad">

        </div>
    </div>
    <div class="span12 last">
        <div class="wrap">
            <div class="main">
                <div class="title">
                    <strong>登录</strong>USER LOGIN
                </div>

                <form:form id="loginForm" modelAttribute="user"
                           action="${ pageContext.request.contextPath }/login"
                           method="post">
                    <table>
                        <tbody>
                        <tr>
                            <th>用户名:</th>
                            <td><form:input path="username" name="username" id="username" value="<%=username%>" class="inputText" maxlength="20"/>
                                <c:if test="${notUser != null }">
                                    <font color="red">没有此用户</font>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <th>密&nbsp;&nbsp;码:</th>
                            <td><form:password id="password" path="password" class="inputText" maxlength="20"/>
                                <c:if test="${notPassword != null}">
                                    <font color="red">密码错误</font>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                验证码:
                            </th>
                            <td>
                                <span class="fieldSet">
                                    <input type="text" id="captcha" name="checkcode" class="inputText captcha"
                                           maxlength="4"/>
                                    <img id="captchaImage" class="captchaImage"
                                         src="${pageContext.request.contextPath}/getCheckCodeImage"
                                         title="点击更换验证码"/>
                                </span>
                                <c:if test="${errorCheckCode != null}">
                                    <font color="red">验证码出错</font>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>&nbsp;</th>
                            <td>
                                <label>
                                    <input type="checkbox" id="isRememberUsername" name="isRememberUsername" checked="<%=check%>"
                                           value="true"/>记住用户名 </label>
                                <label> &nbsp;&nbsp;<a href ="${pageContext.request.contextPath}/forgetPassword">找回密码</a>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>&nbsp;</th>
                            <td><input type="submit" class="submit" value="登 录"/></td>
                        </tr>
                        <tr class="register">
                            <th>&nbsp;</th>
                            <td>
                                <dl>
                                    <dt>
                                        <a href="${pageContext.request.contextPath }/userRegister">还没有注册账号？立即注册</a>
                                    </dt>
                                </dl>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form:form>

            </div>
        </div>
    </div>
</div>
</body>
</html>