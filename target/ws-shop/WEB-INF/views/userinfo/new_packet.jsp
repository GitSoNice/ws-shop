<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>卡片袋</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css"
          rel="stylesheet" type="text/css"/>
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
</head>
<body>
<!--导航-->
<nav class="navbar navbar-default header" >
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-content"
            >
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
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a id="dLabel" data-target="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <c:out value="${userinfo.username }"/>
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
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${ pageContext.request.contextPath }/finduserInfo" class="list-group-item ">
                    基本信息
                </a>
                <a href="${ pageContext.request.contextPath }/toRetPassword" class="list-group-item ">账号信息</a>
                <a href="${ pageContext.request.contextPath }/findWalletByUid" class="list-group-item ">小口袋</a>
                <a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0" class="list-group-item active">卡片袋</a>
            </div>
        </div>
        <c:if test="${packet != null}">
            <div class="col-md-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            卡片袋
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div id="div1" class="col-md-12">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>优惠金额</th>
                                        <th>满减金额</th>
                                        <th>使用时间</th>
                                        <th>分类名称</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="p" items="${page.content}">
                                        <tr>
                                            <td><c:out value="${p.privilege }"/></td>
                                            <td><c:out value="${p.consume }"/></td>
                                            <td><c:out value="${p.useTime }"/></td>
                                            <td><c:out value="${p.category.cname }"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <c:if test="${page.totalPages ==0 }">
                            <span><h2>您还没有任何优惠券！</h2></span>
                        </c:if>
                        <ul class="pagination" style="float:right;">
                            <c:if test="${page.totalPages !=0 }">
                                <li><a href="${pageContext.request.contextPath}/findPacketByUid?ppage=0">&laquo;</a></li>
                                <c:if test="${page.number+1 > 1 }">
                                    <li><a href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.number-1 }">&lt;</a></li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${page.totalPages}">
                                    <!-- 如果是当前页则不能够点击 -->
                                    <c:if test="${i == page.number+1 }">
                                        <li class="active"><a>${page.number +1}</a></li>
                                    </c:if>

                                    <c:if test="${i != page.number+1 }">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/findPacketByUid?ppage=${i-1}">
                                                <c:out value="${i}"/>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <!-- 下一页 -->
                                <c:if test="${page.number+1 < page.totalPages }">
                                    <li><a href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.number+1 }">&gt;</a></li>
                                </c:if>

                                <!-- 尾页 -->
                                <li><a href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.totalPages-1 }">&raquo;</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>

            </div>
        </c:if>
    </div>
</div>

</body>
</html>