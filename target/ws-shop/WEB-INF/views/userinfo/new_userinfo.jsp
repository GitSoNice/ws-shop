<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>基本信息</title>
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
                <a href="${ pageContext.request.contextPath }/finduserInfo" class="list-group-item active ">
                    基本信息
                </a>
                <a href="${ pageContext.request.contextPath }/toRetPassword" class="list-group-item ">账号信息</a>
                <a href="${ pageContext.request.contextPath }/findWalletByUid" class="list-group-item">小口袋</a>
                <a href="${ pageContext.request.contextPath }/findPacketByUid?ppage=0" class="list-group-item">卡片袋</a>
            </div>
        </div>
        <div class="col-md-10">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        基本信息
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div id="div2" class="col-md-12">
                            <form id= "form1" class="form-horizontal" action="${pageContext.request.contextPath}/updateUserInfo" method="post" onsubmit="return checkForm();" >
                                <input type="hidden" name="uid" value="<c:out value='${userinfo.uid }'/>"/>
                                <input type="hidden" name="username" value="<c:out value='${userinfo.username }'/>"/>
                                <input type="hidden" name="password" value="<c:out value='${userinfo.password }'/>"/>
                                <input type="hidden" name="state" value="<c:out value='${userinfo.state }'/>"/>
                                <div class="form-group">
                                    <label for="name" class="col-sm-2 control-label">姓名</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control form-control-static" id="name" name="name" value="<c:out value='${userinfo.name }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="email" name="email" value="<c:out value='${userinfo.email }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="phone" class="col-sm-2 control-label">电话</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="phone" name="phone" value="<c:out value='${userinfo.phone }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="age" class="col-sm-2 control-label">年龄</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="age" name="age" value="<c:out value='${userinfo.age }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="addr" class="col-sm-2 control-label">地址</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="addr" name="addr" value="<c:out value='${userinfo.addr }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <input type="submit" value="修改" class="btn btn-primary"/>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div id="div1" class="col-md-12">
                            <a class="edit" onclick="changStatus();" data-toggle="tooltip" title="点我修改信息">
                                <img style=" width:20px;" src="images/userinfoedit.jpg">
                            </a>
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="name1" class="col-sm-2 control-label">姓名</label>
                                    <div class="col-sm-10">
                                        <input type="text" readonly class="form-control form-control-static" id="name1" name="name" value="<c:out value='${userinfo.name }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email1" class="col-sm-2 control-label">邮箱</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" readonly id="email1" name="email" value="<c:out value='${userinfo.email }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="phone1" class="col-sm-2 control-label">电话</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" readonly id="phone1" name="phone" value="<c:out value='${userinfo.phone }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="age1" class="col-sm-2 control-label">年龄</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" readonly id="age1" name="age" value="<c:out value='${userinfo.age }'/>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="addr1" class="col-sm-2 control-label">地址</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" readonly id="addr1" name="addr" value="<c:out value='${userinfo.addr }'/>"/>
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

    function checkForm() {
        var addr = $("#addr").val();
        if (addr == null || addr == '') {
            alert("地址不能为空!");
            return false;
        }

        var name = $("#name").val();
        if (name == null || name == '') {
            alert("姓名不能为空!");
            return false;
        }

        var email = $("#email").val();
        if (email == null || email == '') {
            alert("邮箱不能为空!");
            return false;
        }
        var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(!reg.test(email)){
            alert("邮箱格式不正确!");
            return false;
        }

        var phone =$("#phone").val();
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(phone)) {
            alert("电话输入不正确!");
            return false;
        }

        var age = $("#age").val();
        if (age == null || age == '') {
            alert("年龄不能为空!");
            return false;
        }
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

</body>
</html>
