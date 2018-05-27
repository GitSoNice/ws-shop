<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="${pageContext.request.contextPath}/css/Style1.css" type="text/css" rel="stylesheet">
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
		action="${pageContext.request.contextPath}/addProduct" method="post"
		enctype="multipart/form-data">
		&nbsp;
		<table class="table">
			<thead>
			    <tr style="text-align:center;font-size:20px;font-weight: bold;">
					<td style="font-size:16px;">添加商品</td>
				</tr>
			</thead>
			<tbody>
				<tr style="text-align:center;">
					<td>商品名称：<input type="text" name="pname" value="" id="product_name"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="padding-right:120px;">是否热门：
						<select name="is_hot">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td>市场价格：
						<input type="text" name="market_price" value="" id="marke_price" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td>商城价格：
						<input type="text" name="shop_price" value="" id="shop_price" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td>库存：
						<input type="text" name="inventory" value="" id="inventory" />
					</td>
				</tr>
				<tr style="text-align: center;">
					<td style="padding-right:150px;">商品图片：
						<input type="file" name="upload" style="padding-left:550px;"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="padding-right:20px;">
						所属的二级分类：
						<select name="csid">
							<c:forEach var="cs" items="${categorySeconds }">
								<option value="<c:out value="${cs.csid}"/>"><c:out
										value="${cs.csname}" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td>商品描述：
						<textarea name="pdesc" rows="5" cols="30"></textarea>
					</td>
				</tr>
				<tr>
					<td width="100%" style="text-align:center;">
						<button type="submit" id="userAction_save_do_submit" value="确定" class="btn btn-primary">&#30830;&#23450;</button> <FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
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