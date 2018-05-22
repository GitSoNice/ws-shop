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
	function addCategory() {
		window.location.href = "${pageContext.request.contextPath}/gotoAddCategory";
	}
</script>
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
</HEAD>
<body>
	<br>
	<div style="padding-left:250px;">
		<form action="${pageContext.request.contextPath}/findByCidAndCname?catecpage=0" method="post">
			一级分类编号<input type="text" id="cid" name="cid" placeholder="一级分类编号" class="inputText" style="margin-right: 20px;"/>
			一级分类名称<input type="text" id="cname" name="cname" placeholder="一级分类名" class="inputText" style="margin-right: 20px;"/>
			<input type="submit" value="查询" class="btn btn-primary" style="margin-right: 10px;" />
			<button type="button" id="add" name="add" value="添加" class="btn btn-primary" onclick="addCategory()">
				&#28155;&#21152;</button>
		</form>
	</div>
	<table class="table">
		<tbody>
			<tr style="text-align:center;font-size:20px;font-weight: bold;">
				<td style="font-size:16px;">一级分类列表</td>
			</tr>
				<tr>
					<table class="table">
						<thead>
							<tr style="text-align:center;">
								<td style="font-size:14px;">序号</td>
								<td style="font-size:14px;">一级分类编号</td>
								<td style="font-size:14px;">一级分类名称</td>
								<td style="font-size:14px;">折扣</td>
								<td style="font-size:14px;">优惠时间</td>
								<td style="font-size:14px;">编辑</td>
								<td style="font-size:14px;">删除</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="c" items="${page.content}" varStatus="vs">
								<tr style="text-align:center;" onmouseover="this.style.backgroundColor = 'white'"
									onmouseout="this.style.backgroundColor = '#F5FAFE';">
									<td><c:out value="${vs.index+1}"></c:out></td>
									<td>
										<c:out value="${c.cid }" />
									</td>
									<td>
										<c:out value="${c.cname }" />
									</td>
									<td>
										<c:out value="${c.discount }" />
									</td>
									<td>
										<c:out value="${c.privilegeTime }" />
									</td>
									<td><a href="${ pageContext.request.contextPath }/gotoEditCategory/<c:out value="${c.cid }"/>">
											<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
									</a></td>
									<td>
										<a href="${ pageContext.request.contextPath }/deleteCategory/<c:out value="${c.cid}"/>">
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
					<c:if test="${cid == null}&&${cname == ''}">
						<c:if test="${page.totalPages !=0 }">
							<li><a href="${pageContext.request.contextPath}/listCategory?catepage=0">&laquo;</a></li>
							<c:if test="${page.number+1 > 1 }">
								<li><a href="${pageContext.request.contextPath}/listCategory?catepage=${page.number-1 }">&lt;</a></li>
							</c:if>
							<c:forEach var="i" begin="1" end="${page.totalPages}">
								<!-- 如果是当前页则不能够点击 -->
								<c:if test="${i == page.number+1 }">
									<li class="active"><a>${page.number +1}</a></li>
								</c:if>

								<c:if test="${i != page.number+1 }">
									<li>
										<a href="${pageContext.request.contextPath}/listCategory?catepage=${i-1}">
											<c:out value="${i}"/>
										</a>
									</li>
								</c:if>
							</c:forEach>

							<!-- 下一页 -->
							<c:if test="${page.number+1 < page.totalPages }">
								<li><a href="${pageContext.request.contextPath}/listCategory?catepage=${page.number+1 }">&gt;</a></li>
							</c:if>

							<!-- 尾页 -->
							<li><a href="${pageContext.request.contextPath}/listCategory?catepage=${page.totalPages-1 }">&raquo;</a></li>
						</c:if>
					</c:if>

					<c:if test="${page.totalPages !=0 }">
						<li><a href="${pageContext.request.contextPath}/findByCidAndCname1?catecpage=0&cid=${cid}&cname=${cname}">&laquo;</a></li>
						<c:if test="${page.number+1 > 1 }">
							<li><a href="${pageContext.request.contextPath}/findByCidAndCname1?catecpage=${page.number-1 }&cid=${cid}&cname=${cname}">&lt;</a></li>
						</c:if>
						<c:forEach var="i" begin="1" end="${page.totalPages}">
							<!-- 如果是当前页则不能够点击 -->
							<c:if test="${i == page.number+1 }">
								<li class="active"><a>${page.number +1}</a></li>
							</c:if>

							<c:if test="${i != page.number+1 }">
								<li>
									<a href="${pageContext.request.contextPath}/findByCidAndCname1?catecpage=${i-1}&cid=${cid}&cname=${cname}">
										<c:out value="${i}"/>
									</a>
								</li>
							</c:if>
						</c:forEach>

						<!-- 下一页 -->
						<c:if test="${page.number+1 < page.totalPages }">
							<li><a href="${pageContext.request.contextPath}/findByCidAndCname1?catecpage=${page.number+1 }&cid=${cid}&cname=${cname}">&gt;</a></li>
						</c:if>

						<!-- 尾页 -->
						<li><a href="${pageContext.request.contextPath}/findByCidAndCname1?catecpage=${page.totalPages-1 }&cid=${cid}&cname=${cname}">&raquo;</a></li>
					</c:if>
				</ul>
			</tr>
		</tbody>
	</table>
</body>
</HTML>

