<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--[if lt IE 9]>
<script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<style>
    .submit {
        width: 80px;
        height: 26px;
        border-radius: 10px;
        margin-left: 10px;
        color: #555;
        background-color: lightgrey;
        cursor: pointer;
        outline: none;
        blr: expression(this.hideFocus = true);
        border: none;
    }

    .inputText {
        width: 200px;
        height: 26px;
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
<!--导航-->
<nav class="navbar navbar-default header" >
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-content">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="${pageContext.request.contextPath}/index" class="navbar-brand">微商平台</a>
        </div>
        <div class="collapse navbar-collapse" id="nav-content">
            <ul class="nav navbar-nav navbar-left">
                <li  class="active"><a href="${ pageContext.request.contextPath }/finduserInfo" ><span class="glyphicon glyphicon-user"></span> 个人信息 </a></li>
                <li><a href="${ pageContext.request.contextPath }/findOrderByUid?uopage=0" ><span class="glyphicon glyphicon-tasks"></span> 我的订单</a></li>
                <li>
                    <div style="float:left;padding-top: 10px;padding-left: 10px;">
                        <form id="searchProduct" action="${pageContext.request.contextPath}/findByName?npage=0" method="post">
                            <input type="text" id="proname" name="proname" class="inputText" />
                            <input type="submit" value="搜索" class="submit"/>
                        </form>
                    </div>
                </li>
            </ul>

            <c:if test="${sessionScope.user == null}">
                <ul class="nav navbar-nav navbar-right">
                        <li id="headerLogin">
                            <a href="${ pageContext.request.contextPath }/userLogin">登录</a>
                        </li>
                        <li id="headerRegister" >
                            <a href="${ pageContext.request.contextPath }/userRegister">注册</a>
                        </li>
                    <li><a href="${pageContext.request.contextPath}/myCart"><span class="glyphicon glyphicon-shopping-cart" ></span>购物车</a></li>
                </ul>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                 <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                            <a id="dLabel" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <c:out value="${user.username }"/>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dLabel">
                            <li><a href="${ pageContext.request.contextPath }/finduserInfo">基本信息</a></li>
                            <li><a href="${ pageContext.request.contextPath }/toRetPassword">账号信息</a></li>
                            <li><a href="${ pageContext.request.contextPath }/findWalletByUid">小口袋</a></li>
                            <li><a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0">小卡袋</a></li>
                        </ul>
                    </li>
                    <li ><a href="${ pageContext.request.contextPath }/quit"><span class="glyphicon glyphicon-off text-danger" ></span>  退出</a></li>
                     <li><a href="${pageContext.request.contextPath}/myCart"><span class="glyphicon glyphicon-shopping-cart text-danger" ></span>购物车</a></li>
                 </ul>
            </c:if>
        </div>
    </div>
</nav>
    <ul class="nav nav-pills" style="padding-left:155px;font-size:15px;">
        <li class="active"><a href="${ pageContext.request.contextPath }/index">首页</a></li>

        <c:forEach items="${sessionScope.cList}" var="c">
            <li>
                <a href="${ pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>?cpage=0">
                    <c:out value="${c.cname}"></c:out>
                </a>
            </li>
        </c:forEach>
    </ul>