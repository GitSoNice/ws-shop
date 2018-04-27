<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/WEB-INF/user/list.jsp" method="post">
			<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
				<TBODY>
					<tr>
						<td class="ta_01" align="center" bgColor="#afd1f3">
							<strong>会员列表</strong>
						</TD>
					</tr>
					<tr>
						
					</tr>
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="18%">
										序号
									</td>
									<td align="center" width="17%">
										用户编号
									</td>
									<td align="center" width="17%">
										会员名称
									</td>
									<td align="center" width="17%">
										真实姓名
									</td>
									<td width="7%" align="center">
										编辑
									</td>
								</tr>
									<c:forEach var="u" items="${page.content}" varStatus="vs">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												<c:out value="${vs.index+1}"></c:out>
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												<c:out value="${u.uid }"></c:out>
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												<c:out value="${u.username }"></c:out>
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												<c:out value="${u.name }"></c:out>
											</td>
											<td align="center" style="HEIGHT: 22px">
												<a href="${ pageContext.request.contextPath }/editUser/<c:out value="${u.uid }"/>">
													<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
												</a>
											</td>
										</tr>
									</c:forEach>	
							</table>
						</td>
					</tr>
					<tr align="center">
						<td colspan="7">
							第<c:out value="${page.number+1}" />/<c:out value="${page.totalPages}"/>页
							<a href="listUser?page=0"/>首页</a>|
							<c:if test="${page.number+1 > 1 }">
									<a href="${ pageContext.request.contextPath }/listUser?page=<c:out value="${page.number-1 }"/>">上一页</a>|
							</c:if>
							<c:if test="${page.number+1 < page.totalPages }">
							<a href="${ pageContext.request.contextPath }/listUser?page=<c:out value="${page.number+1 }"/>">下一页</a>|
						</c:if>
							<a href="${ pageContext.request.contextPath }/listUser?page=<c:out value="${page.totalPages-1 }"/>">尾页</a>|
						</td>
					</tr>
				</TBODY>
			</table>
		</form>
	</body>
</HTML>

