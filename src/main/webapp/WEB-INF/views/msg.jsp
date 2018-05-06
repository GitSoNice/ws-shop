<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/second.js"></script>
</head>

<body  onload="startSecond()">

<div id="divcontent">
    <table width="850px" border="0" cellspacing="0">
        <tr>
            <td style="padding:30px; text-align:center">
                <table width="60%" border="0" cellspacing="0" style="margin-top:70px">
                    <tr>
                        <td style="width:98px"><img src="${pageContext.request.contextPath}/images/IconTexto_WebDev_009.jpg" width="128"
                                height="128"/></td>
                        <td style="padding-top:30px">
                            <font style="font-weight:bold; color:#FF0000">
                                <c:if test="${registerSuccess != null }">
                                    注册成功，可以登录了!
                                    <span id="second">5</span>秒后自动为您转跳登录页面
                                </c:if>
                                <c:if test="${notUser != null }">
                                    激活失败,无此用户!
                                    <span id="second">5</span>秒后自动为您转跳登录页面
                                </c:if>
                                <c:if test="${notLogin != null}">
                                    您还没有登陆，请先登录
                                    <span id="second">5</span>秒后自动为您转跳登录页面
                                </c:if>

                            </font>
                            <br/>
                            <br/>
                            <a href="${ pageContext.request.contextPath }/index">首页</a>
                            <a href="${ pageContext.request.contextPath }/userRegister">注册</a>
                            <a href="${ pageContext.request.contextPath }/userLogin">登录</a>
                        </td>
                    </tr>
                </table>
                <h1>&nbsp;</h1></td>
        </tr>
    </table>
</div>

</body>
</html>