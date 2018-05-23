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
		<style>
			.inputText {
				width: 200px;
				height: 26px;
				line-height: 26px;
				padding: 0px 4px;
				color: #666666;
				-webkit-border-radius: 2px;
				-moz-border-radius: 2px;
				border-radius: 5px;
				border: 1px solid;
				border-color: #b8b8b8 #dcdcdc #dcdcdc #b8b8b8;
			}

			.inputText:hover {
				-webkit-transition: box-shadow linear 0.2s;
				-moz-transition: box-shadow linear 0.2s;
				-ms-transition: box-shadow linear 0.2s;
				-o-transition: box-shadow linear 0.2s;
				transition: box-shadow linear 0.2s;
				-webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
				-moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
				box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
				border: 1px solid #74b9ef;
				background: white;
			}
		</style>
		<script type="text/javascript">
            function exportUser() {
                window.location.href = "${pageContext.request.contextPath}/exportUser";
            }
		</script>
	</HEAD>
	<body>
		<br>
		<div style="padding-left:400px;">
			<form action="${pageContext.request.contextPath}/findByUserName?uupage=0" method="post">
				用户名<input type="text" id="username" name="username" placeholder="用户名" class="inputText" style="margin-right: 20px;"/>
				<input type="submit" value="查询" class="btn btn-primary" style="margin-right: 10px;" />
				<button type="button" id="export" name="export" value="导出Excel" class="btn btn-primary" onclick="exportUser()">
					导出Excel</button>
			</form>
		</div>
			<table class="table">
				<tbody>
					<tr style="text-align:center;font-size:20px;font-weight: bold;">
						<td style="font-size:16px;">用户列表</td>
					</tr>
					<tr>
							<table class="table">
								<thead>
									<tr style="text-align:center;">
										<td style="font-size:14px;font-weight: bold;">序号</td>
										<td style="font-size:14px;font-weight: bold;">用户编号</td>
										<td style="font-size:14px;font-weight: bold;">用户名</td>
										<td style="font-size:14px;font-weight: bold;">真实姓名</td>
										<td style="font-size:14px;font-weight: bold;">邮箱</td>
										<td style="font-size:14px;font-weight: bold;">联系电话</td>
										<td style="font-size:14px;font-weight: bold;">联系地址</td>
										<td style="font-size:14px;font-weight: bold;">编辑</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="u" items="${page.content}" varStatus="vs">
										<tr style="text-align:center;" onmouseover="this.style.backgroundColor = 'white'"
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
							<c:if test="${username == ''}">
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
							</c:if>
							<c:if test="${username != ''}">
								<c:if test="${page.totalPages !=0 }">
									<li><a href="${pageContext.request.contextPath}/findByUserName1?uupage=0&username=${username}">&laquo;</a></li>
									<c:if test="${page.number+1 > 1 }">
										<li><a href="${pageContext.request.contextPath}/findByUserName1?uupage=${page.number-1 }&username=${username}">&lt;</a></li>
									</c:if>
									<c:forEach var="i" begin="1" end="${page.totalPages}">
										<!-- 如果是当前页则不能够点击 -->
										<c:if test="${i == page.number+1 }">
											<li class="active"><a>${page.number +1}</a></li>
										</c:if>

										<c:if test="${i != page.number+1 }">
											<li>
												<a href="${pageContext.request.contextPath}/findByUserName1?uupage=${i-1}&username=${username}">
													<c:out value="${i}"/>
												</a>
											</li>
										</c:if>
									</c:forEach>

									<!-- 下一页 -->
									<c:if test="${page.number+1 < page.totalPages }">
										<li><a href="${pageContext.request.contextPath}/findByUserName1?uupage=${page.number+1 }&username=${username}">&gt;</a></li>
									</c:if>

									<!-- 尾页 -->
									<li><a href="${pageContext.request.contextPath}/findByUserName1?uupage=${page.totalPages-1 }&username=${username}">&raquo;</a></li>
								</c:if>
							</c:if>
						</ul>
					</tr>
				</tbody>
			</table>
	</body>
	</body>
</HTML>

