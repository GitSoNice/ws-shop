<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>忘记密码</title>
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
<c:if test="${resetfailed != null }">
    <script>
        alert('修改密码失败！旧密码不正确');
    </script>
</c:if>
<c:if test="${emailFalse != null }">
    <script>
        alert('发送邮件失败！邮箱不正确');
    </script>
</c:if>
<c:if test="${sendEmail != null }">
    <script>
        alert('发送邮件失败！更新密码失败！');
    </script>
</c:if>
<c:if test="${noExistUser != null }">
    <script>
        alert('该用户不存在，请填写正确的用户名');
    </script>
</c:if>
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

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${sessionScope.user == null}">
                    <li id="headerLogin">
                        <a href="${ pageContext.request.contextPath }/userLogin">登录</a>
                    </li>
                    <li id="headerRegister" >
                        <a href="${ pageContext.request.contextPath }/userRegister">注册</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <li class="dropdown">
                        <a id="dLabel" data-target="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
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
                </c:if>
                <li><a href="${pageContext.request.contextPath}/myCart"><span class="glyphicon glyphicon-shopping-cart" ></span>购物车</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-10">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        忘记密码
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div id="div1" class="col-md-12">
                            <a class="edit" onclick="changStatus();"><img src="images/forget.jpg">忘记密码</a>
                            <form id= "form1" class="form-horizontal" action="${pageContext.request.contextPath}/beReset" method="post" >
                                <div class="form-group">
                                    <label for="username1" class="col-sm-2 control-label">账号</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="username1"  name="username" placeholder="账号" onblur="checkUsername();"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="col-sm-2 control-label">旧密码</label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" id="password" name="password" placeholder="旧密码" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="repassword" class="col-sm-2 control-label">新密码</label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" id="repassword" name="repassword" placeholder="新密码" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <input type="submit" value="修改" class="btn btn-primary"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div id="div2" class="col-md-12">
                            <form id= "form2" class="form-horizontal" action="${pageContext.request.contextPath}/beSendEmail" method="post" >
                                <div class="form-group">
                                    <label for="username" class="col-sm-2 control-label">账号</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="username"  name="username" pacleholder="登陆账号" onblur="checkUsername();"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" name="email" id="email" pacleholder="输入正确邮箱，例如xxx@qq.com" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <input type="submit" value="修改" class="btn btn-primary"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
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

    function checkUsername() {
        $.post(
            "checkUser/" + $("#username").val(),
            {},
            function (data) {
                if (data == 1) {
                    document.getElementById("span1").innerHTML = "<font color='red'>用户名不存在</font>";
                    $("#username").val("");
                    $("#username").focus();
                    $(".submit").unbind("click",
                        function (event) {

                        });
                } else {
                    document.getElementById("span1").innerHTML = "<font color='green'>用户名存在，请继续填写邮箱</font>";
                }
            });
    }
</script>
</html>