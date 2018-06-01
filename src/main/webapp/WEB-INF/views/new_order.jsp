<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>确认订单页面</title>
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

</head>
<script>

    function checkForm() {
        var name = $("#name").val();
        if (name == null || name == '') {
            alert("姓名不能为空!");
            return false;
        }

        var phone = $("#phone").val();
        if (phone == null || phone == '') {
            alert("电话不能为空!");
            return false;
        }

        var addr = $("#addr").val();
        if (addr == null || addr == '') {
            alert("地址不能为空!");
            return false;
        }

        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(phone)) {
            alert("电话输入不正确!");
            return false;
        }
    }
</script>
<body>

<%@ include file="new_menu.jsp" %>

<div class="container1 cart">
    <div class="span24">
        <table class="table">
            <thead>
            <tr>
                <th colspan="5">订单编号:<c:out value="${order.oid}"/>&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <td><img
                            src="${ pageContext.request.contextPath }/<c:out value="${ orderItem.product.image}"/>"/>
                    </td>
                    <td><c:out value="${orderItem.product.pname}"/></td>
                    <td><fmt:formatNumber type="number" minFractionDigits="1" value="${orderItem.product.shop_price }"
                                          maxFractionDigits="1"/></td>
                    <td class="quantity" width="60">
                        <c:out value="${orderItem.count}"/></td>
                    <td><span class="subtotal">￥
							<c:out value="${orderItem.subtotal}"/></span></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <dl id="giftItems" class="hidden" style="display: none;">
        </dl>
        <div class="total">
            <em id="promotion"></em> 优惠后的商品金额: <strong id="effectivePrice">￥<c:out
                value="${order.total}"/>元
        </strong>
        </div>
        <form id="orderForm" action="${ pageContext.request.contextPath }/payOrder" method="post">
            <input type="hidden" name="oid"
                   value="<c:out value="${order.oid}"/>"/>
            <div class="span24">
                <p>
                    收货地址：<input name="addr" id="addr" type="text" class="inputText" value="<c:out value="${sessionScope.user.addr}"/>"
                                style="width: 350px"/> <br/>
                    收货人&nbsp;&nbsp;&nbsp;：<input name="name" id="name" type="text" class="inputText"
                                                 value="<c:out value="${sessionScope.user.name}"/>"
                                                 style="width: 150px"/> <br/>
                    联系方式：<input name="phone" id="phone" type="text" class="inputText" value="<c:out value="${sessionScope.user.phone}"/>"
                                style="width: 150px"/>

                    <%-- 隐藏域，订单总金额 --%>
                    <input name="total" type="hidden" value="${order.total}"/>
                </p>
                <hr/>

                <hr/>
                <p style="text-align: right">
                    <a href="javascript:document.getElementById('orderForm').submit();" onclick="return checkForm();">
                        <img src="${pageContext.request.contextPath}/images/finalbutton.gif" width="204" height="51" border="0"/>
                    </a>
                </p>
            </div>
        </form>
    </div>

</div>
</body>
</html>