<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body>
<!--  -->
<form id="userAction_save_do" name="Form1"
	  action="${pageContext.request.contextPath}/addCategory" method="post"
	  enctype="multipart/form-data">
	&nbsp;
	<table class="table">
		<thead>
		<tr style="text-align:center;font-size:20px;font-weight: bold;">
			<td style="font-size:16px;">添加一级分类</td>
		</tr>
		</thead>
		<tbody>
			<tr style="text-align:center;">
				<td style="font-size:20px;">
					一级分类名称：<input type="text" name="cname" value="" id="category_name"/>
				</td>
			</tr>
			<tr style="text-align:center;">
				<td style="font-size:20px;">
					折扣：<input type="text" name="discount" value="" id="discount"/>
				</td>
			</tr>
			<tr style="text-align:center;">
				<td style="font-size:20px;">
					优惠时间：<input type="text" name="privilegeTime" value="" id="privilegeTime"/>
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
</form>
</body>
</HTML>