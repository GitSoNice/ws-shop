<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>微商平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/slider.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
</head>
<body>
    <!-- 包含进去首页头部的文件 -->
    <%@ include file="new_menu.jsp" %>


<div class="container index" style="margin-left:140px;margin-top:20px;">

    <!-- 热门商品 -->
    <div class="span24">
        <div id="hotProduct" class="hotProduct clearfix">

            <div class="title">
                <strong>热门商品</strong>
            </div>

            <ul class="tab">
                <li class="current"><a href="#" target="_blank"></a></li>
                <li><a target="_blank"></a></li>
                <li><a target="_blank"></a></li>
            </ul>

            <ul class="tabContent" style="display: block;">
                <c:forEach var="p" items="${hList}">
                    <li>
                        <a href="${pageContext.request.contextPath }/findByPid/<c:out value="${p.pid}"/>"
                            target="_blank"> <img
                            src="${pageContext.request.contextPath }/<c:out value="${p.image }"/>"
                            style="display: block;"/></a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- 最新商品 -->
    <div class="span24">
        <div id="newProduct" class="newProduct clearfix">
            <div class="title">
                <strong>最新商品</strong> <a target="_blank"></a>
            </div>
            <ul class="tab">
                <li class="current"><a href="#" target="_blank"></a></li>
                <li><a target="_blank"></a></li>
                <li><a target="_blank"></a></li>
            </ul>

            <ul class="tabContent" style="display: block;">
                <c:forEach items="${nList }" var="p">
                    <li><a
                            href="${pageContext.request.contextPath }/findByPid/<c:out value="${p.pid}"/>"
                            target="_blank"><img
                            src="${pageContext.request.contextPath}/<c:out value="${p.image}"/>"
                            style="display: block;"/></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="span24">

    </div>
</div>

<div class="container footer">
</div>
</body>
</html>