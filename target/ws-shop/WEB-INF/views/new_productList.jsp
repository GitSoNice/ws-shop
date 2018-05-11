<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/product.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css"/>
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
<%@ include file="new_menu.jsp" %>

<div class="container1 " style="margin-top:20px;">
    <div class="span6">
        <div class="hotProductCategory">
            <c:forEach var="c" items="${sessionScope.cList }">
                <dl>
                    <dt>
                        <a
                                href="${pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>?cpage=0"><c:out
                                value="${c.cname}"/></a>
                    </dt>
                    <c:forEach var="cs" items="${c.categorySeconds}">
                        <dd style="padding-top: 8px;">
                            <a
                                    href="${ pageContext.request.contextPath }/findByCsid/<c:out value="${cs.csid}?cspage=0"/>"><c:out
                                    value="${cs.csname}"/></a>
                        </dd>
                    </c:forEach>
                </dl>
            </c:forEach>
        </div>
    </div>
    <div class="span18 last">

        <!-- 各项商品 -->
        <form id="productForm"
              action="${pageContext.request.contextPath}/image/蔬菜 - Powered By Mango Team.htm"
              method="get">
            <div id="result" class="result table clearfix">
                <ul>
                    <c:forEach var="p" items="${page.content}">
                        <li><a href="${ pageContext.request.contextPath }/findByPid/<c:out value="${p.pid}"/>">
                            <img src="${pageContext.request.contextPath}/<c:out value="${p.image}"/>" width="170" height="170" style="display: inline-block;"/>
                            <span style='color: green'> <c:out value="${p.pname}"/> </span>
                            <span class="price"> 商城价： ￥<c:out value="${p.shop_price}"/> </span>
                        </a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 分页 -->
            <!-- 根据一级分类的cid是不是为空来显示上一页下一页的状况 -->
            <c:if test="${cid != null }">
                <c:if test="${page.totalPages ==0 }">
                <span><h2>该类型的商品还在路上，敬请期待！！！</h2></span>
                </c:if>
                <ul class="pagination" style="float:right;">
                    <c:if test="${page.totalPages !=0 }">
                        <li><a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=0">&laquo;</a></li>
                        <c:if test="${page.number+1 > 1 }">
                            <li><a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.number-1 }">&lt;</a></li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${page.totalPages}">
                            <!-- 如果是当前页则不能够点击 -->
                            <c:if test="${i == page.number+1 }">
                                <li class="active"><a>${page.number +1}</a></li>
                            </c:if>

                            <c:if test="${i != page.number+1 }">
                                <li>
                                    <a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${i-1}">
                                        <c:out value="${i}"/>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
                            <li><a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.number+1 }">&gt;</a></li>
                        </c:if>

                        <!-- 尾页 -->
                        <li><a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.totalPages-1 }">&raquo;</a></li>
                    </c:if>
                </ul>
            </c:if>

            <!-- name的上一页和下一页 -->
            <c:if test="${name != null }">
                <c:if test="${page.totalPages ==0 }">
                <span><h2>对不起，没有找到相关商品！！!</h2></span>
                </c:if>
                <ul class="pagination" style="float:right;">
                    <c:if test="${page.totalPages !=0 }">
                        <li><a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=0">&laquo;</a></li>
                        <c:if test="${page.number+1 > 1 }">
                            <li><a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.number-1 }">&lt;</a></li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${page.totalPages}">
                            <!-- 如果是当前页则不能够点击 -->
                            <c:if test="${i == page.number+1 }">
                                <li class="active"><a>${page.number +1}</a></li>
                            </c:if>

                            <c:if test="${i != page.number+1 }">
                                <li>
                                    <a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${i-1}">
                                        <c:out value="${i}"/>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
                            <li><a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.number+1 }">&gt;</a></li>
                        </c:if>

                        <!-- 尾页 -->
                        <li><a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.totalPages-1 }">&raquo;</a></li>
                    </c:if>
                </ul>
            </c:if>

            <c:if test="${csid != null }">

                <c:if test="${page.totalPages ==0 }">
                <span><h2>该类型的商品还在路上，敬请期待！！！</h2></span>
                </c:if>
                <ul class="pagination" style="float:right;">
                    <c:if test="${page.totalPages !=0 }">
                        <li><a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=0">&laquo;</a></li>
                        <c:if test="${page.number+1 > 1 }">
                            <li><a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.number-1 }">&lt;</a></li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${page.totalPages}">
                            <!-- 如果是当前页则不能够点击 -->
                            <c:if test="${i == page.number+1 }">
                                <li class="active"><a>${page.number +1}</a></li>
                            </c:if>

                            <c:if test="${i != page.number+1 }">
                                <li>
                                    <a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${i-1}">
                                        <c:out value="${i}"/>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
                            <li><a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.number+1 }">&gt;</a></li>
                        </c:if>

                        <!-- 尾页 -->
                        <li><a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.totalPages-1 }">&raquo;</a></li>
                    </c:if>
                </ul>
            </c:if>
            </div>
        </form>
    </div>
</div>
</body>
</html>