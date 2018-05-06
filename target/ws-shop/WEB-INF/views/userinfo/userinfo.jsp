<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>个人信息</title>
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

    </style>
</head>

<body>
<c:if test="${updateSuccess != null }">
    <script>
        alert('更新成功！');
    </script>
</c:if>
<c:if test="${updateFlase != null }">
    <script>
        alert('更新失败！');
    </script>
</c:if>
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
                <a href="${ pageContext.request.contextPath }/finduserInfo" class="active">个人信息</a>
            </li>
            <li>
                <a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0">卡包</a>
            </li>
            <li>
                <a href="${ pageContext.request.contextPath }/findWalletByUid">钱包</a>
            </li>
        </ul>
    </div>
    <c:if test="${sessionScope.user != null}">
        <div class="content column">
            <div calss="header">
                <h1>个人信息</h1>
                <a class="edit" onclick="changStatus();"><img src="images/userinfoedit.jpg"> </a>
            </div>
            <div id="div1">
            <table class="show">
                <tr class="showinfotr">
                    <td style="padding-right: 50px;">姓名：</td>
                    <td><c:out value="${userinfo.name }"/></td>
                </tr>
                <tr class="showinfotr">
                    <td style="padding-right: 50px;">邮箱：</td>
                    <td><c:out value="${userinfo.email}"/></td>
                </tr>
                <tr class="showinfotr">
                    <td style="padding-right: 50px;">电话：</td>
                    <td><c:out value="${userinfo.phone}"/></td>
                </tr>
                <tr class="showinfotr">
                    <td style="padding-right: 50px;">年龄：</td>
                    <td><c:out value="${userinfo.age}"/></td>
                </tr>
                <tr class="showinfotr">
                    <td style="padding-right: 50px;">地址：</td>
                    <td><c:out value="${userinfo.addr}"/></td>
                </tr>
            </table>
            </div>
            <div id="div2">
                <form id= "form1" action="${pageContext.request.contextPath}/updateUserInfo" method="post" >
                    <input type="hidden" name="uid" value="<c:out value='${userinfo.uid }'/>"/>
                    <input type="hidden" name="username" value="<c:out value='${userinfo.username }'/>"/>
                    <input type="hidden" name="password" value="<c:out value='${userinfo.password }'/>"/>
                    <input type="hidden" name="state" value="<c:out value='${userinfo.state }'/>"/>
                    <table class="show">
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">姓名：</td>
                            <td><input type="text" class="inputText" name="name" value="<c:out value='${userinfo.name }'/>"/></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">邮箱：</td>
                            <td><input type="text" class="inputText" name="email" value="<c:out value='${userinfo.email }'/>"/></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">电话：</td>
                            <td><input type="text" class="inputText" name="phone" value="<c:out value='${userinfo.phone }'/>"/></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">年龄：</td>
                            <td><input type="text" class="inputText" name="age" value="<c:out value='${userinfo.age }'/>"/></td>
                        </tr>
                        <tr class="showinfotr">
                            <td style="padding-right: 50px;">地址：</td>
                            <td><input type="text" class="inputText" name="addr" value="<c:out value='${userinfo.addr }'/>"/></td>
                        </tr>
                        <tr class="showinfotr">
                            <td><input type="submit" value="修改" class="submit"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </c:if>
</div>
</div>
</body>
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
</html>