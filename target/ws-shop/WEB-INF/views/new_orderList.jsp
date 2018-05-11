<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的订单列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/cart.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/product.css" rel="stylesheet" type="text/css"/>
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
<c:if test="${paymentSuccess != null }">
    <script>
        alert('付款成功！');
        jquery.js="${ pageContext.request.contextPath }/findOrderByUid?uopage=0"
    </script>
</c:if>
<c:if test="${paymentFalse != null }">
    <script>alert('余额不足，付款失败！');</script>
</c:if>
<div class="container1 cart">
    <div class="span24">
        <div>
            <ul>
                <li class="current"></li>
                <li><h2>我的订单</h2></li>
            </ul>
        </div>
        <table class="table">
            <c:forEach var="order" items="${page.content}">
                <thead>
                    <tr>
                        <th colspan="5">订单编号:<c:out value="${order.oid}"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            订单金额:<font color="red"><c:out value="${order.total }"/></font>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${order.state == 1}">
                                <a
                                        href="${ pageContext.request.contextPath }/findByOid/<c:out value="${order.oid}" />">
                                    <font color="red">付款</font>
                                </a>
                            </c:if>
                            <c:if test="${order.state == 2}">
                                已付款
                            </c:if>
                            <c:if test="${order.state == 3}">
                                <a href="${ pageContext.request.contextPath }/updateState/<c:out value="${order.oid}" />">确认收货</a>
                            </c:if>
                            <c:if test="${order.state == 4}">
                                交易成功
                            </c:if>
                        </th>
                    </tr>
                    <tr>
                        <th>图片</th>
                        <th>商品</th>
                        <th>价格</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="orderItem" items="${order.orderItems}">
                        <tr>
                            <td width="60"><a
                                    href="${ pageContext.request.contextPath }/findByPid/<c:out value="${orderItem.product.pid}"/>">
                                <img
                                        src="${ pageContext.request.contextPath }/<c:out value="${orderItem.product.image}"/>"/>
                            </a></td>
                            <td><c:out value="${ orderItem.product.pname}"/></td>
                            <td><c:out value="${orderItem.product.shop_price}"/></td>
                            <td class="quantity" width="60"><c:out
                                    value="${orderItem.count}"/></td>
                            <td width="140"><span class="subtotal">￥<c:out
                                    value="${orderItem.subtotal}"/>
                                    </span></td>
                        </tr>
                        </c:forEach>
            </c:forEach>
                    <tr>
                        <td>
                        <c:if test="${page.totalPages ==0 }">
                             <span>
                                 <h2>
                                    尊敬的用户，目前您还没用订单，您可以前往
                                    <a href="${ pageContext.request.contextPath }/index" style="color: #843d11">
                                     首页购物
                                    </a>
                                 </h2>
                             </span>
                        </c:if>
                        </td>
                        <td>
                        <ul class="pagination" style="float:right;">
                            <c:if test="${page.totalPages !=0 }">
                                <li><a href="${pageContext.request.contextPath}/findOrderByUid?uopage=0">&laquo;</a></li>
                                <c:if test="${page.number+1 > 1 }">
                                    <li><a href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.number-1 }">&lt;</a></li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${page.totalPages}">
                                    <!-- 如果是当前页则不能够点击 -->
                                    <c:if test="${i == page.number+1 }">
                                        <li class="active"><a>${page.number +1}</a></li>
                                    </c:if>

                                    <c:if test="${i != page.number+1 }">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/findOrderByUid?uopage=${i-1}">
                                                <c:out value="${i}"/>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <!-- 下一页 -->
                                <c:if test="${page.number+1 < page.totalPages }">
                                    <li><a href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.number+1 }">&gt;</a></li>
                                </c:if>

                                <!-- 尾页 -->
                                <li><a href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.totalPages-1 }">&raquo;</a></li>
                            </c:if>
                        </ul>
                        </td>
                    </tr>
                </tbody>
        </table>
    </div>
</div>
</body>
</html>