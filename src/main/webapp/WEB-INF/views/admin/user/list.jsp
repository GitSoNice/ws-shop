<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
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
		
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/WEB-INF/user/list.jsp" method="post">
			<table class="table">
				<tbody>
					<tr style="text-align:center;font-size:20px;font-weight: bold;">
						<td style="font-size:16px;">用户列表</td>
					</tr>
					<tr>
							<table class="table">
								<thead>
									<tr>
										<td>序号</td>
										<td>用户表号</td>
										<td>用户账号</td>
										<td>真实姓名</td>
										<td>邮箱</td>
										<td>联系电话</td>
										<td>联系地址</td>
										<td>编辑</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="u" items="${page.content}" varStatus="vs">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td>
												<c:out value="${vs.index+1}"></c:out>
											</td>
											<td>
												<c:out value="${u.uid }"></c:out>
											</td>
											<td>
												<c:out value="${u.username }"></c:out>
											</td>
											<td>
												<c:out value="${u.name }"></c:out>
											</td>
											<td>
												<c:out value="${u.email }"></c:out>
											</td>
											<td>
												<c:out value="${u.phone }"></c:out>
											</td>
											<td>
												<c:out value="${u.addr }"></c:out>
											</td>
											<td>
												<a href="${ pageContext.request.contextPath }/editUser/<c:out value="${u.uid }"/>">
													<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
												</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
					</tr>

					<tr>
						<ul class="pagination" style="float:right;">
							<c:if test="${page.totalPages !=0 }">
							<li><a href="${pageContext.request.contextPath}/listUser?page=0">&laquo;</a></li>
							<c:if test="${page.number+1 > 1 }">
							<li><a href="${pageContext.request.contextPath}/listUser?page=${page.number-1 }">&lt;</a></li>
							</c:if>
							<c:forEach var="i" begin="1" end="${page.totalPages}">
							<!-- 如果是当前页则不能够点击 -->
							<c:if test="${i == page.number+1 }">
							<li class="active"><a>${page.number +1}</a></li>
							</c:if>

							<c:if test="${i != page.number+1 }">
							<li>
								<a href="${pageContext.request.contextPath}/listUser?page=${i-1}">
									<c:out value="${i}"/>
								</a>
							</li>
							</c:if>
							</c:forEach>

							<!-- 下一页 -->
							<c:if test="${page.number+1 < page.totalPages }">
							<li><a href="${pageContext.request.contextPath}/listUser?page=${page.number+1 }">&gt;</a></li>
							</c:if>

							<!-- 尾页 -->
							<li><a href="${pageContext.request.contextPath}/listUser?page=${page.totalPages-1 }">&raquo;</a></li>
							</c:if>
						</ul>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</HTML>

