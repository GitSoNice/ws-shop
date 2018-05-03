<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>

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

    <title>登录</title>

    <link href="${pageContext.request.contextPath}/css/common.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/login.css"
          rel="stylesheet" type="text/css"/>
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
<div class="container header">

    <%@ include file="menu.jsp" %>

</div>
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
<div class="container login">
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
                            <td><form:input path="username" name="username" id="username" value="<%=username%>"
                                            class="text" maxlength="20"/>
                                <c:if test="${notUser != null }">
                                    <font color="red">没有此用户</font>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <th>密&nbsp;&nbsp;码:</th>
                            <td><form:password id="password" path="password" class="text" maxlength="20"/>
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
                                    <input type="text" id="captcha" name="checkcode" class="text captcha"
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
<div class="container footer">
</div>
</body>
</html>