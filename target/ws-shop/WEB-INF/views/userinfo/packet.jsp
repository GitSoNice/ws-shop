<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>卡包</title>
    <link href="${pageContext.request.contextPath}/css/common.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/userinfo.css"
          rel="stylesheet" type="text/css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <style>
        .submit{
            width: 120px;
            height: 34px;
            font-size: 22px;
            border-radius: 10px;
            margin-left: 10px;
            color: #ffffff;
            background-color: #8a65e6;
            cursor: pointer;
            outline: none;
            blr: expression(this.hideFocus = true);
            border: none;
        }
        .inputText {
            width: 200px;
            height: 34px;
            font-size:22px;
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

        .a2button {
            height: 34px;
            line-height: 21px;
            padding: 0 11px;
            color: #ffffff;
            background: #e65457;
            border: 1px #e65457 solid;
            border-radius: 10px;
            /*color: #fff;*/
            display: inline-block;
            text-decoration: none;
            font-size: 22px;
            padding-top:5px;
            outline: none;
        }
        .a2button:hover{
            height: 34px;
            line-height: 21px;
            padding: 0 11px;
            color: #ffffff;
            background: #e65457;
            border: 1px #e65457 solid;
            border-radius: 10px;
            /*color: #fff;*/
            display: inline-block;
            text-decoration: none;
            font-size: 22px;
            padding-top:5px;
            outline: none;
        }

         .shoet{
             font-size:22px;
             text-align: center;
             font-family: 华文仿宋;
             font-weight: 300;
             padding-top:20px;
         }

        .shoett{
            width:18%;
            font-size:22px;
            font-family: 华文仿宋;
            font-weight: 500;
            padding-top:20px;
        }
    </style>
</head>
<script type="text/javascript">
    $(function(){
        init();
    });

    function init(){
        $("#div2").hide();
        $("#div1").show();
    }
    function changStatus(){
        $("#div1").hide();
        $("#div2").show();
    }

    function change(){
        $.ajax({
            url:'${pageContext.request.contextPath}/updateUserInfo',
            type:"POST",
            dataType:"text",
            data: $("#form1").serializeArray(),
            contentType: "application/x-www-form-urlencoded",
            success: function(res) {
                if(res.code == 200){
                    alert("更新成功！");
                }else{
                    alert("更新失败！");
                }
                init();
            }
        });
    }
</script>
<body>
<ul class="topmenu">
    <li>
        <a href="${pageContext.request.contextPath}/index" class="active">返回首页</a>
    </li>
    <c:if test="${userinfo != null}">
        <div class="dropdown">
            <a href="#" class="dropbtn"><c:out value="${userinfo.username }"/></a>
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

<div class="clearfix">
    <div class="column sidemenu">
        <ul>
            <li>
                <a href="${ pageContext.request.contextPath }/toRetPassword">修改密码</a>
            </li>
            <li>
                <a href="${ pageContext.request.contextPath }/finduserInfo" >个人信息</a>
            </li>
            <li>
                <a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0" class="active">卡包</a>
            </li>
            <li>
                <a href="${ pageContext.request.contextPath }/findWalletByUid">钱包</a>
            </li>
        </ul>
    </div>
    <c:if test="${sessionScope.user != null}">
        <c:if test="${packet != null}">
            <div class="content column">
                <div calss="header">
                    <h1>卡包</h1>
                </div>
                <c:if test="${packet != null}">
                    <div id="div1">

                        <table class="show">
                            <tr>
                                <th class="shoett">优惠金额</th>
                                <th class="shoett">满减金额</th>
                                <th class="shoett">使用时间</th>
                                <th class="shoett">分类名称</th>
                            </tr>
                            <c:forEach var="p" items="${page.content}">
                            <tr>
                                <td class="shoet"><c:out value="${p.privilege }"/></td>
                                <td class="shoet"><c:out value="${p.consume }"/></td>
                                <td class="shoet"><c:out value="${p.useTime }"/></td>
                                <td class="shoet"><c:out value="${p.category.cname }"/></td>
                            </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>
            </div>
        </c:if>
    </c:if>
</div>
<div class="pagination">

    <c:if test="${page.totalPages ==0 }">
    <div class="span24">
        <div class="step step1">
            <center style="color: red;padding-left:350px">
                            <span><h2>
                                您还没有任何优惠券！
                            </h2></span>
            </center>
        </div>
    </div>
    </c:if>
    <c:if test="${page.totalPages !=0 }">
    <span>第 <c:out value="${page.number+1}"/>/<c:out value="${page.totalPages}"/>页 </span>
    <span><a class="firstPage" href="${pageContext.request.contextPath}/findPacketByUid?ppage=0"></a></span>
    <c:if test="${page.number+1 > 1 }">
    <span><a class="previousPage" href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.number-1 }"></a></span>
    </c:if>

    <c:forEach var="i" begin="1" end="${page.totalPages}">
    <span>
							   <!-- 如果是当前页则不能够点击 -->
							   <c:if test="${i == page.number+1 }">
                                   <span class="currentPage">${page.number +1}</span>
                               </c:if>

							   <c:if test="${i != page.number+1 }">
								 <a href="${pageContext.request.contextPath}/findPacketByUid?ppage=${i}">
									<c:out value="${i}"/></a>
                               </c:if>
							</span>
    </c:forEach>

    <!-- 下一页 -->
    <c:if test="${page.number+1 < page.totalPages }">
    <span><a class="nextPage" href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.number+1 }"></a></span>
    </c:if>

    <!-- 尾页 -->
    <a class="lastPage" href="${pageContext.request.contextPath}/findPacketByUid?ppage=${page.totalPages-1 }"></a>
    </c:if>
</div>
</body>
</html>