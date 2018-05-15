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
<script type="text/javascript">
	function addCategorySecond() {
		window.location.href = "${pageContext.request.contextPath}/gotoAddCategorySecond";
	}
</script>
</HEAD>
<body>
	<br>
	<form id="Form1" name="Form1"
		action="${pageContext.request.contextPath}/user/list.jsp"
		method="post">
		<table class="table">
			<tbody>
			<tr style="text-align:center;font-size:20px;font-weight: bold;">
				<td style="font-size:16px;">二级分类列表</td>
			</tr>
			<tr>
				<td>
					<button type="button" id="add" name="add" value="添加"
							class="btn btn-primary" style="float:right;" onclick="addCategorySecond()">
						&#28155;&#21152;</button>

				</td>
			</tr>
				<tr>
					<table class="table">
						<thead>
							<tr>
								<td>序号</td>
								<td>二级分类id</td>
								<td>所属一级分类名称</td>
								<td>二级分类名称</td>
								<td>编辑</td>
								<td>删除</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="cs" items="${page.content}" varStatus="vs">
								<tr onmouseover="this.style.backgroundColor = 'white'"
									onmouseout="this.style.backgroundColor = '#F5FAFE';">
									<td><c:out value="${vs.index+1}"></c:out></td>
									<td><c:out value="${cs.csid}" /></td>
									<td><c:out value="${cs.category.cname}" /></td>
																				
									<td><c:out value="${cs.csname}" /></td>
									
									<td>
										<a href="${ pageContext.request.contextPath }/gotoEditCategorySecond/<c:out value="${cs.csid }" />">
											<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
										</a>
									</td>

									<td>
										<a href="${ pageContext.request.contextPath }/deleteCategorySecond/<c:out value="${cs.csid }" />">
											<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
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
						<li><a href="${pageContext.request.contextPath}/listCategorySecond?catespage=0">&laquo;</a></li>
						<c:if test="${page.number+1 > 1 }">
							<li><a href="${pageContext.request.contextPath}/listCategorySecond?catespage=${page.number-1 }">&lt;</a></li>
						</c:if>
						<c:forEach var="i" begin="1" end="${page.totalPages}">
							<!-- 如果是当前页则不能够点击 -->
							<c:if test="${i == page.number+1 }">
								<li class="active"><a>${page.number +1}</a></li>
							</c:if>

							<c:if test="${i != page.number+1 }">
								<li>
									<a href="${pageContext.request.contextPath}/listCategorySecond?catespage=${i-1}">
										<c:out value="${i}"/>
									</a>
								</li>
							</c:if>
						</c:forEach>

						<!-- 下一页 -->
						<c:if test="${page.number+1 < page.totalPages }">
							<li><a href="${pageContext.request.contextPath}/listCategorySecond?catespage=${page.number+1 }">&gt;</a></li>
						</c:if>

						<!-- 尾页 -->
						<li><a href="${pageContext.request.contextPath}/listCategorySecond?catespage=${page.totalPages-1 }">&raquo;</a></li>
					</c:if>
				</ul>
			</tr>
			</tbody>
		</table>
	</form>
</body>
</HTML>

