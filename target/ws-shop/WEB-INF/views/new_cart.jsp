<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>购物车</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <link href="${pageContext.request.contextPath}/css/userinfo.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/cart.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css"/>
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <script language="JavaScript">
        $(document).ready(function () {
            $("#checkbox").on("click", function () {
                if ($("input[type='checkbox']").is(':checked')) {
                    var privilege = $("#privilege").val();
                    var total = $("#total").val();
                    var total1 = total - privilege;
                    $("#effectivePoint").text(parseFloat(total1).toFixed(1));
                    $("#discountTotal").text("￥" + parseFloat(total1).toFixed(1) + "元");
                } else {
                    var total = $("#total").val();
                    $("#effectivePoint").text(total);
                    $("#discountTotal").text("￥" + total + "元");
                }
            });
            $("#submit").on("click", function () {
                $.post(
                    "ChangeTotal/" + parseFloat($("#effectivePoint").text()),
                    {},
                    function (data) {
                    });
            });
        });
    </script>

</head>
<body>
<%@ include file="new_menu.jsp" %>

<div class="container1 cart" style="margin-top:20px;">
    <c:if test="${fn:length(sessionScope.cart.cartItems)!=0}">
        <div class="span24">
            <table class="table">
                <thead>
                <tr>
                    <th>图片</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>
                </thead>
                <%
                    String datetime = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()); //获取系统时间
                    request.setAttribute("currentTime", datetime);
                %>
                <tbody>
                <c:forEach var="cartItem" items="${sessionScope.cart.cartItems}">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath }/findByPid/<c:out value="${cartItem.product.pid}"/>">
                                <img src="${pageContext.request.contextPath}/<c:out value="${cartItem.product.image}"/>"/>
                            </a>
                        </td>

                        <td>
                            <a target="_blank"
                               href="${ pageContext.request.contextPath }/findByPid/<c:out value="${cartItem.product.pid}"/>">
                                <c:out value="${cartItem.product.pname}"/>
                            </a>
                        </td>

                        <c:if test="${currentTime !=  privilegeTime}">
                            <td>￥<fmt:formatNumber type="number" minFractionDigits="1"
                                                   value="${cartItem.product.shop_price }" maxFractionDigits="1"/>
                            </td>
                        </c:if>

                        <c:if test="${currentTime ==  privilegeTime}">
                            <td>￥<fmt:formatNumber type="number" minFractionDigits="1"
                                                   value="${cartItem.product.shop_price * cartItem.product.categorySecond.category.discount }"
                                                   maxFractionDigits="1"/>
                            </td>
                        </c:if>

                        <td class="quantity" width="60"><c:out value="${cartItem.count}"/></td>
                        <td width="140"><span class="subtotal">￥<c:out
                                value="${cartItem.subtotal}"/></span></td>
                        <td><a
                                href="${ pageContext.request.contextPath }/removeCart/<c:out value="${cartItem.product.pid}"/>"
                                class="delete">删除</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <dl id="giftItems" class="hidden" style="display: none;">
            </dl>

            <div class="total">
                <em id="promotion"></em>

                    <%-- 用户未登录 --%>
                <c:if test="${sessionScope.user == null}">
                    <em> 登录后确认是否享有优惠 </em>
                </c:if>

                   <%-- 用户已登录 --%>
                <c:if test="${sessionScope.user != null}">

                  <%--是否是打折日期--%>
                    <c:if test="${currentTime !=  privilegeTime}">
                        <em> 暂无可用优惠券 </em>
                    </c:if>

                    <c:if test="${currentTime ==  privilegeTime}">


                        <c:if test="${sessionScope.cart.total >= ticket.consume}">
                            <em><input id="checkbox" type="checkbox" value="privilege">满<c:out
                                    value="${ticket.consume}"/>减<c:out value="${ticket.privilege}"/></em>

                            <input type="hidden" id="privilege" value="<c:out value="${ticket.privilege}"/>"/>
                            <input type="hidden" id="total" value="<c:out value="${sessionScope.cart.total}"/>"/>
                        </c:if>

                        <c:if test="${sessionScope.cart.total < ticket.consume}">
                            <em> 暂无可用优惠券 </em>
                        </c:if>
                    </c:if>
                    </strong>
                </c:if>
                赠送积分: <em id="effectivePoint"><c:out value="${sessionScope.cart.total}"/></em>
                商品金额:
                <strong id="effectivePrice"><p id="discountTotal">￥<c:out value="${sessionScope.cart.total}"/>元</p>
                </strong>
            </div>
            <div class="bottom">
                <a href="${ pageContext.request.contextPath }/clearCart" id="clear" class="clear">清空购物车</a>
                <a href="${pageContext.request.contextPath}/saveOrder" id="submit" class="submit">提交订单</a>
            </div>
        </div>
    </c:if>

    <c:if test="${fn:length(sessionScope.cart.cartItems) == 0}">
        <span>
            <h2>
                购物车空空如也，您可以选择前往
                <a href="${ pageContext.request.contextPath }/index" style="color: #843d11"> 首页购物 </a>！！！
            </h2>
        </span>
    </c:if>
</div>
</body>
</html>