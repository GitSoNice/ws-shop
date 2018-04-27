<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/Style1.css"
	rel="stylesheet" type="text/css" />
<script language="javascript"
	src="${pageContext.request.contextPath}/js/public.js"></script>
<script type="text/javascript">
	function addCategory() {
		window.location.href = "${pageContext.request.contextPath}/gotoAddCategory";
	}
</script>
</HEAD>
<body>
	<br>
	<table cellSpacing="1" cellPadding="0" width="100%" align="center"
		bgColor="#f5fafe" border="0">
		<TBODY>
			<tr>
				<td class="ta_01" align="center" bgColor="#afd1f3"><strong>一级分类列表</strong>
				</TD>
			</tr>
			<tr>
				<td class="ta_01" align="right">
					<button type="button" id="add" name="add" value="添加"
						class="button_add" onclick="addCategory()">
						&#28155;&#21152;</button>

				</td>
			</tr>
			<tr>
				<td class="ta_01" align="center" bgColor="#f5fafe">
					<table cellspacing="0" cellpadding="1" rules="all"
						bordercolor="gray" border="1" id="DataGrid1"
						style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
						<tr
							style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

							<td align="center" width="18%">序号</td>
							<td align="center" width="17%">一级分类号</td>
							<td align="center" width="17%">一级分类名称</td>
							<td align="center" width="17%">折扣</td>
							<td align="center" width="17%">优惠时间</td>
							<td width="7%" align="center">编辑</td>
							<td width="7%" align="center">删除</td>
						</tr>
						<c:forEach var="c" items="${page.content}" varStatus="vs">
							<tr onmouseover="this.style.backgroundColor = 'white'"
								onmouseout="this.style.backgroundColor = '#F5FAFE';">
								<td style="CURSOR: hand; HEIGHT: 22px" align="center"
									width="18%"><c:out value="${vs.index+1}"></c:out></td>
								<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">
									<c:out value="${c.cid }" />
								</td>
								<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">
									<c:out value="${c.cname }" />
								</td>
								<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">
									<c:out value="${c.discount }" />
								</td>
								<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">
									<c:out value="${c.privilegeTime }" />
								</td>
								<td align="center" style="HEIGHT: 22px"><a
									href="${ pageContext.request.contextPath }/gotoEditCategory/<c:out value="${c.cid }"/>">
										<img src="${pageContext.request.contextPath}/images/i_edit.gif"
										border="0" style="CURSOR: hand">
								</a></td>
								<td align="center" style="HEIGHT: 22px"><a
									href="${ pageContext.request.contextPath }/deleteCategory/<c:out value="${c.cid}"/>">
										<img src="${pageContext.request.contextPath}/images/i_del.gif"
										width="16" height="16" border="0" style="CURSOR: hand">
								</a></td>
							</tr>
						</c:forEach>
						<tr align="center">
							<td colspan="7">
								第<c:out value="${page.number+1}" />/<c:out value="${page.totalPages}"/>页
								<a href="listCategory?catepage=0"/>首页</a>|
								<c:if test="${page.number+1 > 1 }">
									<a href="${ pageContext.request.contextPath }/listCategory?catepage=<c:out value="${page.number-1 }"/>">上一页</a>|
								</c:if>
								<c:if test="${page.number+1 < page.totalPages }">
									<a href="${ pageContext.request.contextPath }/listCategory?catepage=<c:out value="${page.number+1 }"/>">下一页</a>|
								</c:if>
								<a href="${ pageContext.request.contextPath }/listCategory?catepage=<c:out value="${page.totalPages-1 }"/>">尾页</a>|
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</TBODY>
	</table>
</body>
</HTML>

