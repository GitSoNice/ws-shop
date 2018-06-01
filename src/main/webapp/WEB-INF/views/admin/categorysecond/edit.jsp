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
            var csname = $("#csname").val();
            if (csname == null || csname == '') {
                alert("二级分类名称不能为空!");
                return false;
            }
        }
	</script>
	<body>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/updateCategorySecond" method="post" onsubmit="return checkForm();">
			<input type="hidden" name="csid" value="${categorySecond.csid }"/>
			&nbsp;
			<table class="table">
				<tr style="text-align:center;font-size:20px;font-weight: bold;">
					<td style="font-size:22px;">编辑二级分类</td>
				</tr>
				<tbody>
				<tr style="text-align:center;">
					<td style="font-size:20px;">二级分类名称：<input type="text" name="csname" value="<c:out value="${categorySecond.csname }"/>" id="csname"/>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td style="font-size:20px;">
						所属的一级分类：
						<select name="cid">
						<c:forEach items="${categorys}" var="c">
							<option value="${c.cid }"
									<c:if test="${categorySecond.category.cid == c.cid}">selected</c:if>/>
							<c:out value="${c.cname }" />
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td width="100%" style="text-align:center;">
					<button type="submit" id="userAction_save_do_submit" value="确定" class="btn btn-primary">
							&#30830;&#23450;
					</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<button type="reset" value="重置" class="btn btn-primary">&#37325;&#32622;</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<INPUT class="btn btn-primary" type="button" onclick="history.go(-1)" value="返回"/>
						<span id="Label1"></span>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</body>
</HTML>