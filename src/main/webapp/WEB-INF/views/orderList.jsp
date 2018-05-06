<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <title>订单页面</title>
    <link href="${pageContext.request.contextPath}/css/common.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/cart.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/product.css"
          rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container header">
    <%@ include file="menu.jsp" %>
</div>
<c:if test="${paymentSuccess != null }">
    <script>
        alert('付款成功！');
        jquery.js="${ pageContext.request.contextPath }/findOrderByUid?uopage=0"
    </script>
</c:if>
<c:if test="${paymentFalse != null }">
    <script>alert('余额不足，付款失败！');</script>
</c:if>
<div class="container cart">
    <div class="span24">
        <div>
            <ul>
                <li class="current"></li>
                <li><b>我的订单</b></li>
            </ul>
        </div>
        <table>
            <tbody>
            <c:forEach var="order" items="${page.content}">
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
                <th colspan="5">
                    <div class="pagination">
                        <c:if test="${page.totalPages ==0 }">
                            <div class="span24">
                                <div class="step step1">
                                    <center style="color: red">
						            <span><h2>
                                尊敬的用户，目前您还没用订单，您可以前往
						<a href="${ pageContext.request.contextPath }/index" style="color: #843d11">
                            首页购物
						</a>
						</h2></span>
                                    </center>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${page.totalPages !=0 }">
                            <span>第 <c:out value="${page.number+1}"/>/<c:out value="${page.totalPages}"/>页 </span>
                            <span><a class="firstPage"
                                     href="${pageContext.request.contextPath}/findOrderByUid?uopage=0"></a></span>
                            <c:if test="${page.number+1 > 1 }">
                                <span><a class="previousPage"
                                         href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.number-1 }"></a></span>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${page.totalPages }">
									<span>
							   <!-- 如果是当前页则不能够点击 -->
							   <c:if test="${i == page.number+1 }">
                                   <span class="currentPage">${page.number +1}</span>
                               </c:if>

							   <c:if test="${i != page.number+1 }">
								 <a href="${pageContext.request.contextPath}/findOrderByUid?uopage=${i}">
									<c:out value="${i}"/></a>
                               </c:if>
							</span>
                            </c:forEach>
                            <!-- 下一页 -->
                            <c:if test="${page.number+1 < page.totalPages }">
                                <span><a class="nextPage"
                                         href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.number+1 }"></a></span>
                            </c:if>

                            <!-- 尾页 -->
                            <a class="lastPage"
                               href="${pageContext.request.contextPath}/findOrderByUid?uopage=${page.totalPages-1 }"></a>
                        </c:if>
                    </div>
                </th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="container footer">
</div>
</body>
</html>