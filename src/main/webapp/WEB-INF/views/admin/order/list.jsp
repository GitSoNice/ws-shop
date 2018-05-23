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
			function showDetail(oid){
				var but = document.getElementById("but"+oid);
				var div1 = document.getElementById("div"+oid);
				if(but.value == "订单详情"){
					// 1.创建异步对象
					var xhr = createXmlHttp();
					// 2.设置监听
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4){
							if(xhr.status == 200){
								div1.innerHTML = xhr.responseText;
							}
						}
					}
					// 3.打开连接
					xhr.open("GET","${pageContext.request.contextPath}/findOrderItem/"+oid+"/"+new Date().getTime(),true);
					// 4.发送
					xhr.send(null);
					but.value = "关闭";
				}else{
					div1.innerHTML = "";
					but.value="订单详情";
				}
				
			}
			function createXmlHttp(){
				   var xmlHttp;
				   try{ // Firefox, Opera 8.0+, Safari
				        xmlHttp=new XMLHttpRequest();
				    }
				    catch (e){
					   try{// Internet Explorer
					         xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
					      }
					    catch (e){
					      try{
					         xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
					      }
					      catch (e){}
					      }
				    }

					return xmlHttp;
				 }

            function exportExcel() {
                window.location.href = "${pageContext.request.contextPath}/exportOrders";
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
		<form action="${pageContext.request.contextPath}/findByOidAndUid?oupage=0" method="post">
			订单编号<input type="text" id="oid" name="oid" placeholder="订单编号" class="inputText" style="margin-right: 20px;"/>
			用户编号<input type="text" id="uid" name="uid" placeholder="用户编号" class="inputText" style="margin-right: 20px;"/>
			<input type="submit" value="查询" class="btn btn-primary" style="margin-right: 10px;" />
			<button type="button" id="export" name="export" value="导出Excel" class="btn btn-primary" onclick="exportExcel()">
				导出Excel</button>
		</form>
	</div>
		<table class="table">
			<tbody>
			<tr style="text-align:center;font-size:20px;font-weight: bold;">
				<td style="font-size:16px;">订单列表</td>
			</tr>

			<tr>
				<table class="table">
					<thead>
						<tr style="text-align:center;">
							<td style="font-size:14px;font-weight: bold;">订单编号</td>
							<td style="font-size:14px;font-weight: bold;">订单时间</td>
							<td style="font-size:14px;font-weight: bold;">订单金额</td>
							<td style="font-size:14px;font-weight: bold;">收货人</td>
							<td style="font-size:14px;font-weight: bold;">收货地址</td>
							<td style="font-size:14px;font-weight: bold;">联系电话</td>
							<td style="font-size:14px;font-weight: bold;">订单状态</td>
							<td style="font-size:14px;font-weight: bold;">订单详情</td>
							<td style="font-size:14px;font-weight: bold;">删除</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="o" items="${page.content}">
							<tr style="text-align:center;" onmouseover="this.style.backgroundColor = 'white'"
								onmouseout="this.style.backgroundColor = '#F5FAFE';">
								<td><c:out value="${o.oid }" /></td>
								<td><c:out value="${o.ordertime }" /></td>
								<td><c:out value="${o.total }" /></td>
								<td><c:out value="${o.name }" /></td>
								<td><c:out value="${o.addr }" /></td>
								<td><c:out value="${o.phone }" /></td>
								<td><c:if test="${o.state==1}">
												未付款
											</c:if> <c:if test="${o.state==2}">
										<a href="${ pageContext.request.contextPath }/updateStateOrder/<c:out value="${o.oid }"/>">
											<font color="blue">发货</font>
										</a>
									</c:if> <c:if test="${o.state==3}">
												等待确认收货
											</c:if> <c:if test="${o.state==4}">
												订单完成
											</c:if>
								<td>
								<input type="button" value="订单详情" id="but<c:out value="${o.oid }"/>" onclick="showDetail(<c:out value="${o.oid }"/>)" />
									<div id="div<c:out value="${o.oid }"/>"></div></td>

								<td>
									<a id="delete" href="${ pageContext.request.contextPath }/deleteOrder/<c:out value="${o.oid}"/>">
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
					<c:if test="${oid == null} && ${uid == null }">
						<c:if test="${page.totalPages !=0 }">
							<li><a href="${pageContext.request.contextPath}/listOrder?opage=0">&laquo;</a></li>
							<c:if test="${page.number+1 > 1 }">
								<li><a href="${pageContext.request.contextPath}/listOrder?opage=${page.number-1 }">&lt;</a></li>
							</c:if>
							<c:forEach var="i" begin="1" end="${page.totalPages}">
								<!-- 如果是当前页则不能够点击 -->
								<c:if test="${i == page.number+1 }">
									<li class="active"><a>${page.number +1}</a></li>
								</c:if>

								<c:if test="${i != page.number+1 }">
									<li>
										<a href="${pageContext.request.contextPath}/listOrder?opage=${i-1}">
											<c:out value="${i}"/>
										</a>
									</li>
								</c:if>
							</c:forEach>

							<!-- 下一页 -->
							<c:if test="${page.number+1 < page.totalPages }">
								<li><a href="${pageContext.request.contextPath}/listOrder?opage=${page.number+1 }">&gt;</a></li>
							</c:if>

							<!-- 尾页 -->
							<li><a href="${pageContext.request.contextPath}/listOrder?opage=${page.totalPages-1 }">&raquo;</a></li>
						</c:if>
					</c:if>

					<c:if test="${page.totalPages !=0 }">
						<li><a href="${pageContext.request.contextPath}/findByOidAndUid?oupage=0&oid=${oid}&uid=${uid}">&laquo;</a></li>
						<c:if test="${page.number+1 > 1 }">
							<li><a href="${pageContext.request.contextPath}/findByOidAndUid?oupage=${page.number-1 }&oid=${oid}&uid=${uid}">&lt;</a></li>
						</c:if>
						<c:forEach var="i" begin="1" end="${page.totalPages}">
							<!-- 如果是当前页则不能够点击 -->
							<c:if test="${i == page.number+1 }">
								<li class="active"><a>${page.number +1}</a></li>
							</c:if>

							<c:if test="${i != page.number+1 }">
								<li>
									<a href="${pageContext.request.contextPath}/findByOidAndUid?oupage=${i-1}&oid=${oid}&uid=${uid}">
										<c:out value="${i}"/>
									</a>
								</li>
							</c:if>
						</c:forEach>

						<!-- 下一页 -->
						<c:if test="${page.number+1 < page.totalPages }">
							<li><a href="${pageContext.request.contextPath}/findByOidAndUid?oupage=${page.number+1 }&oid=${oid}&uid=${uid}">&gt;</a></li>
						</c:if>

						<!-- 尾页 -->
						<li><a href="${pageContext.request.contextPath}/findByOidAndUid?oupage=${page.totalPages-1 }&oid=${oid}&uid=${uid}">&raquo;</a></li>
					</c:if>
				</ul>
			</tr>
			</tbody>
		</table>
</body>
</HTML>

