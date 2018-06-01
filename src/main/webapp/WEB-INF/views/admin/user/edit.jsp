<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="${pageContext.request.contextPath}/css/Style1.css"
	type="text/css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
	<!--[if lt IE 9]>
	<script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
</HEAD>
<script>

    function checkForm() {
        var username = $("#username").val();
        if (username == null || username == '') {
            alert("用户名不能为空!");
            return false;
        }

        if ((username.charAt(0).charCodeAt(0) < 65) || (username.charAt(0).charCodeAt(0) > 90)) {
            alert("输入的用户名首字符必须是大写字母");
            return false;
        }

        var password = $("#password").val();
        if (password == null || password == '') {
            alert("密码不能为空!");
            return false;
        }

        var name = $("#name").val();
        if (name == null || name == '') {
            alert("姓名不能为空!");
            return false;
        }

        var email = $("#email").val();
        if (email == null || email == '') {
            alert("邮件不能为空!");
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

        var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(!reg.test(email)){
            alert("邮箱格式不正确!");
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
	<form:form id="Form1" name="Form1"
		action="${pageContext.request.contextPath}/updateUser" method="post"
		modelAttribute="user" onsubmit="return checkForm();">
		<table class="table">
			<tr style="text-align:center;font-size:20px;font-weight: bold;">
				<td style="font-size:22px;">编辑用户</td>
			</tr>
			<form:hidden path="state"/>
			<form:hidden path="uid"/>
			<form:hidden path="code"/>
			<tbody>
				<tr style="text-align:center;">
					<td style="font-size:16px;">用户名称：
						<form:input type="text" path="username" id="username" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">密码：
						<form:input type="password" path="password" id="password"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">真实姓名：
						<form:input type="text" path="name" id="name" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">邮箱：
						<form:input type="text" path="email" id="email" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">电话：
						<form:input type="text" path="phone" id="phone" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">地址：
						<form:input type="text" path="addr" id="addr" />
					</td>
				</tr>
				<tr>
					<td width="100%" style="text-align:center;">
						<button type="submit" id="userAction_save_do_submit" value="确定" class="btn btn-primary">
							&#30830;&#23450;
						</button>
						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<button type="reset" value="重置" class="btn btn-primary">&#37325;&#32622;</button>
						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <INPUT
						class="btn btn-primary" type="button" onclick="history.go(-1)" value="返回" />
						<span id="Label1"></span>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</HTML>