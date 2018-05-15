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
	function addProduct() {
		window.location.href = "${pageContext.request.contextPath}/gotoAddProduct";
	}
	$(function(){
		$("#delete").click(function() {
			if(! confirm("你真的确定要删除?")){				
				return false;
			}
		});
	});
</script>
</HEAD>
<body>
	<br>
    <div>
        <form action="${pageContext.request.contextPath}/findByPidAndPnameAndCsname?ppcpage=0" method="post">
                    商品编号<input type="text" id="pid" name="pid" placeholder="商品编号"/>
                    商品名称<input type="text" id="pname" name="pname" placeholder="商品名"/>
                    二级分类名称<input type="text" id="csname" name="csname" placeholder="二级分类名"/>
                    <input type="submit" value="查询" class="btn btn-primary" />
                    <button type="button" id="add" name="add" value="添加" class="btn btn-primary" onclick="addProduct()">
                        &#28155;&#21152;</button>
        </form>
    </div>
		<table class="table">
			<tbody>
				<tr style="text-align:center;font-size:20px;font-weight: bold;">
                    <td style="font-size:16px;">商品列表</td>
				</tr>

				<tr>
                    <table class="table" >
                        <thead>
                            <tr>
                                <td>序号</td>
                                <td>商品编号</td>
                                <td>二级分类</td>
                                <td>商品图片</td>
                                <td>商品名称</td>
                                <td>商品价格</td>
                                <td>库存量</td>
                                <td>是否热门</td>
                                <td>编辑</td>
                                <td>删除</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${page.content}" varStatus="vs">
                                <tr onmouseover="this.style.backgroundColor = 'white'"
                                    onmouseout="this.style.backgroundColor = '#F5FAFE';">
                                    <td><c:out value="${vs.index+1}"></c:out></td>
                                    <td><c:out value="${p.pid}" /></td>
                                    <td><c:out value="${p.categorySecond.csname}" /></td>
                                    <td>
                                        <img width="40" height="45" src="${ pageContext.request.contextPath }/<c:out value="${p.image}"/>">
                                    </td>
                                    <td><c:out value="${p.pname}" /></td>
                                    <td><c:out value="${p.shop_price}" /></td>
                                    <td><c:out value="${p.inventory}" /></td>
                                    <td>
                                        <c:if test="${p.is_hot==1}">是</c:if>
                                        <c:if test="${p.is_hot!=1}">否</c:if>
                                    </td>
                                    <td>
                                        <a href="${ pageContext.request.contextPath }/editProduct/<c:out value="${p.pid}"/>">
                                            <img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
                                        </a>
                                    </td>

                                    <td>
                                        <a id="delete" href="${ pageContext.request.contextPath }/deleteProduct/<c:out value="${p.pid}"/>">
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
                        <c:if test="${pid == null} && ${pname == null } && ${csname == null}">
                            <c:if test="${page.totalPages !=0 }">
                                <li><a href="${pageContext.request.contextPath}/listProduct?propage=?ppage=0">&laquo;</a></li>
                                <c:if test="${page.number+1 > 1 }">
                                    <li><a href="${pageContext.request.contextPath}/listProduct?propage=${page.number-1 }">&lt;</a></li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${page.totalPages}">
                                    <!-- 如果是当前页则不能够点击 -->
                                    <c:if test="${i == page.number+1 }">
                                        <li class="active"><a>${page.number +1}</a></li>
                                    </c:if>

                                    <c:if test="${i != page.number+1 }">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/listProduct?propage=${i-1}">
                                                <c:out value="${i}"/>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <!-- 下一页 -->
                                <c:if test="${page.number+1 < page.totalPages }">
                                    <li><a href="${pageContext.request.contextPath}/listProduct?propage=${page.number+1 }">&gt;</a></li>
                                </c:if>

                                <!-- 尾页 -->
                                <li><a href="${pageContext.request.contextPath}/listProduct?ppcpage=${page.totalPages-1 }">&raquo;</a></li>
                            </c:if>
                        </c:if>

                        <c:if test="${page.totalPages !=0 }">
                            <li><a href="${pageContext.request.contextPath}/PidPnameCsname?ppcpage=0&pid=${pid}&pname=${pname}&csname=${csname}">&laquo;</a></li>
                            <c:if test="${page.number+1 > 1 }">
                                <li><a href="${pageContext.request.contextPath}/PidPnameCsname?ppcpage=${page.number-1 }&pid=${pid}&pname=${pname}&csname=${csname}">&lt;</a></li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${page.totalPages}">
                                <!-- 如果是当前页则不能够点击 -->
                                <c:if test="${i == page.number+1 }">
                                    <li class="active"><a>${page.number +1}</a></li>
                                </c:if>

                                <c:if test="${i != page.number+1 }">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/PidPnameCsname?ppcpage=${i-1}&pid=${pid}&pname=${pname}&csname=${csname}">
                                            <c:out value="${i}"/>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>

                            <!-- 下一页 -->
                            <c:if test="${page.number+1 < page.totalPages }">
                                <li><a href="${pageContext.request.contextPath}/PidPnameCsname?ppcpage=${page.number+1 }&pid=${pid}&pname=${pname}&csname=${csname}">&gt;</a></li>
                            </c:if>

                            <!-- 尾页 -->
                            <li><a href="${pageContext.request.contextPath}/PidPnameCsname?ppcpage=${page.totalPages-1 }&pid=${pid}&pname=${pname}&csname=${csname}">&raquo;</a></li>
                        </c:if>
                    </ul>
				</tr>
			</tbody>
		</table>
</body>
</HTML>