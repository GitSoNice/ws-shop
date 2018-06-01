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
<script>

    function checkForm() {
        var pname = $("#pname").val();
        if (pname == null || pname == '') {
            alert("商品名称不能为空!");
            return false;
        }
        var marke_price = $("#marke_price").val();
        if (marke_price == null || marke_price == '') {
            alert("市场价不能为空!");
            return false;
        }

        var shop_price = $("#shop_price").val();
        if (shop_price == null || shop_price == '') {
            alert("商城价不能为空!");
            return false;
        }

        var inventory = $("#inventory").val();
        if (inventory == null || inventory == '') {
            alert("库存不能为空!");
            return false;
        }

        var upload = $("#upload").val();
        if (upload == null || upload == '') {
            alert("图片不能为空!");
            return false;
        }

        var pdesc = $("#pdesc").val();
        if (pdesc == null || pdesc == '') {
            alert("描述不能为空!");
            return false;
        }

        var pattern = /^[0-9]+(.[0-9]{1,2})?$/;
        if(!pattern.test(marke_price)){
            alert("输入市场价格金额不正确！！");
            return false;
		}

        var reg =  /^[0-9]+(.[0-9]{1,2})?$/;
        if(!reg.test(shop_price)){
            alert("输入商城价格金额不正确！！");
            return false;
        }
    }
</script>
<body>
	<!--  -->
	<form id="Form1" name="Form1"
		action="${pageContext.request.contextPath}/addProduct" method="post"
		enctype="multipart/form-data"  onsubmit="return checkForm();">
		&nbsp;
		<table class="table">
			<thead>
			    <tr style="text-align:center;font-size:20px;font-weight: bold;">
					<td style="font-size:22px;">添加商品</td>
				</tr>
			</thead>
			<tbody>
				<tr style="text-align:center;">
					<td style="font-size:16px;">商品名称：<input type="text" name="pname" value="" id="pname"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="padding-right:120px;font-size:16px;">是否热门：
						<select name="is_hot">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">市场价格：
						<input type="text" name="market_price" value="" id="marke_price" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">商城价格：
						<input type="text" name="shop_price" value="" id="shop_price" />
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:16px;">库存：
						<input type="text" name="inventory" value="" id="inventory" />
					</td>
				</tr>
				<tr style="text-align: center;">
					<td style="padding-right:150px;font-size:16px;">商品图片：
						<input type="file" name="upload" id="upload" style="padding-left:550px;"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="padding-right:20px;font-size:16px;">
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
					<td style="font-size:16px;">商品描述：
						<textarea name="pdesc" rows="5" cols="30" id="pdesc"></textarea>
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