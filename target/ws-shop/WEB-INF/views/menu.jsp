<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .topmenu {
        list-style-type: none;
        height:50px;
        margin: 0;
        padding: 0;
        overflow: hidden;
        background-color: #777;
    }

    .topmenu li {
        float: right;
    }

    .topmenu li a,
    .dropbtn ,.selectbtn{
        display: inline-block;
        color: white;
        text-align: center;
        padding: 16px;
        text-decoration: none;
    }

    .topmenu li a:hover,
    .dropdown:hover,
    .dropbtn
    .selectbtn {
        background-color: lightblue;
        color:white;
    }

    .topmenu li a.active {
        background-color: lightgreen;
        color: white;
    }

    .dropdown {
        display: inline-block;
        float:right;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .submit {
        width: 80px;
        height: 26px;
        border-radius: 10px;
        margin-left: 10px;
        color: #ffffff;
        background-color: lightblue;
        cursor: pointer;
        outline: none;
        blr: expression(this.hideFocus = true);
        border: none;
    }

    .inputText {
        width: 130px;
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
        <ul class="topmenu">
            <div style="float:left;padding-top: 10px;padding-left: 10px;">
                <form id="searchProduct" action="${pageContext.request.contextPath}/findByName?npage=0" method="post">
                    <input type="text" id="proname" name="proname" class="inputText" />
                    <input type="submit" value="搜索" class="submit"/>
                </form>
            </div>
            <!-- 若用户未登录 -->
            <c:if test="${sessionScope.user == null}">
                <li id="headerLogin">
                    <a href="${ pageContext.request.contextPath }/userLogin">登录</a>
                </li>
                <li id="headerRegister" >
                    <a href="${ pageContext.request.contextPath }/userRegister">注册</a>
                </li>
            </c:if>

            <!-- 若用户已登录 -->
            <c:if test="${sessionScope.user != null}">
                    <div class="dropdown">
                        <a href="#" class="dropbtn"><c:out value="${user.username }"/></a>
                        <div class="dropdown-content">
                            <a href="${ pageContext.request.contextPath }/toRetPassword">修改密码</a>
                            <a href="${ pageContext.request.contextPath }/findWalletByUid">钱包</a>
                            <a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0">卡包</a>
                            <a href="${ pageContext.request.contextPath }/finduserInfo">个人信息</a>
                        </div>
                    </div>
                <li id="headerLogin" >
                    <a href="${ pageContext.request.contextPath }/findOrderByUid?uopage=0">我的订单</a>
                </li>
                <li id="headerRegister">
                    <a href="${ pageContext.request.contextPath }/quit">退出</a>
                </li>
            </c:if>
        </ul>
<div class="cart" style="float:right"><a href="${pageContext.request.contextPath}/myCart">购物车</a></div>
<div class="span24">
    <ul class="mainNav">
        <li><a href="${ pageContext.request.contextPath }/index">首页</a>|</li>

        <c:forEach items="${sessionScope.cList}" var="c">
            <li>
                <a href="${ pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>?cpage=0">
                <c:out value="${c.cname}"></c:out>
            </a>
            </li>
        </c:forEach>
    </ul>
</div>