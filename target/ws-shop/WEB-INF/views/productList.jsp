<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0048)http://localhost:8080/mango/product/list/1.jhtml -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>微商平台</title>
    <link href="${pageContext.request.contextPath}/css/common.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/product.css"
          rel="stylesheet" type="text/css"/>

</head>
<body>
<div class="container header">
    <%@ include file="menu.jsp" %>
</div>

<div class="container productList">
    <div class="span6">
        <div class="hotProductCategory">
            <c:forEach var="c" items="${sessionScope.cList }">
                <dl>
                    <dt>
                        <a
                                href="${pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>?cpage=0"><c:out
                                value="${c.cname}"/></a>
                    </dt>
                    <c:forEach var="cs" items="${c.categorySeconds}">
                        <dd>
                            <a
                                    href="${ pageContext.request.contextPath }/findByCsid/<c:out value="${cs.csid}?cspage=0"/>"><c:out
                                    value="${cs.csname}"/></a>
                        </dd>
                    </c:forEach>
                </dl>
            </c:forEach>
        </div>
    </div>
    <div class="span18 last">

        <!-- 各项商品 -->
        <form id="productForm"
              action="${pageContext.request.contextPath}/image/蔬菜 - Powered By Mango Team.htm"
              method="get">
            <div id="result" class="result table clearfix">
                <ul>
                    <c:forEach var="p" items="${page.content}">
                        <li><a
                                href="${ pageContext.request.contextPath }/findByPid/<c:out value="${p.pid}"/>">
                            <img
                                    src="${pageContext.request.contextPath}/<c:out value="${p.image}"/>"
                                    width="170" height="170" style="display: inline-block;"/> <span
                                style='color: green'> <c:out value="${p.pname}"/>
								</span> <span class="price"> 商城价： ￥<c:out
                                value="${p.shop_price}"/>
								</span>
                        </a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 分页 -->
            <div class="pagination">

                <!-- 根据一级分类的cid是不是为空来显示上一页下一页的状况 -->
                <c:if test="${cid != null }">
                    <c:if test="${page.totalPages ==0 }">
                        <div class="span24">
                            <div class="step step1">
                                <center style="color: red;padding-left:350px">
                            <span><h2>
                                该类型的商品还在路上，敬请期待！！！
                            </h2></span>
                                </center>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${page.totalPages !=0 }">
                        <span>第 <c:out value="${page.number+1}"/>/<c:out value="${page.totalPages}"/>页 </span>
                        <span><a class="firstPage" href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=0"></a></span>
                        <c:if test="${page.number+1 > 1 }">
							<span><a class="previousPage" href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.number-1 }"></a></span>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${page.totalPages}">
							<span>
							   <!-- 如果是当前页则不能够点击 -->
							   <c:if test="${i == page.number+1 }">
                                   <span class="currentPage">${page.number +1}</span>
                               </c:if>

							   <c:if test="${i != page.number+1 }">
								 <a href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${i-1}">
									<c:out value="${i}"/></a>
                               </c:if>
							</span>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
							<span><a class="nextPage" href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.number+1 }"></a></span>
                         </c:if>

                        <!-- 尾页 -->
                        <a class="lastPage" href="${pageContext.request.contextPath}/findByCid/${cid}?cpage=${page.totalPages-1 }"></a>
                    </c:if>
                </c:if>

                <!-- name的上一页和下一页 -->
                <c:if test="${name != null }">
                    <c:if test="${page.totalPages ==0 }">
                        <div class="span24">
                            <div class="step step1">
                                <center style="color: red;padding-left:350px">
                            <span><h2>
                                对不起，没有找到相关商品！！
                            </h2></span>
                                </center>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${page.totalPages !=0 }">
                        <span>第 <c:out value="${page.number+1}"/>/<c:out value="${page.totalPages}"/>页 </span>
                        <span><a class="firstPage" href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=0"></a></span>
                        <c:if test="${page.number+1 > 1 }">
                            <span><a class="previousPage" href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.number-1 }"></a></span>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${page.totalPages}">
							<span>
							   <!-- 如果是当前页则不能够点击 -->
							   <c:if test="${i == page.number+1 }">
                                   <span class="currentPage">${page.number+1 }</span>
                               </c:if>

							   <c:if test="${i != page.number+1 }">
								 <a href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${i-1}">
									<c:out value="${i}"/></a>
                               </c:if>
							</span>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
                            <span><a class="nextPage" href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.number+1 }"></a></span>
                        </c:if>

                        <!-- 尾页 -->
                        <a class="lastPage" href="${pageContext.request.contextPath}/findByName1?proname=${name}&npage=${page.totalPages-1 }"></a>
                    </c:if>
                </c:if>

                <c:if test="${csid != null }">
                    <c:if test="${page.totalPages ==0 }">
                        <div class="span24">
                            <div class="step step1">
                                <center style="color: red;padding-left:350px">
                            <span><h2>
                                该类型的商品还在路上，敬请期待！！！
                            </h2></span>
                                </center>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${page.totalPages !=0 }">
                        <span>第 <c:out value="${page.number+1}"/>/<c:out value="${page.totalPages}"/>页 </span>
                        <span><a class="firstPage" href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=0"></a></span>
                        <c:if test="${page.number+1 > 1 }">
                            <span><a class="previousPage" href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.number-1 }"></a></span>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${page.totalPages}">
							<span>
							   <!-- 如果是当前页则不能够点击 -->
							   <c:if test="${i == page.number+1 }">
                                   <span class="currentPage">${page.number +1}</span>
                               </c:if>

							   <c:if test="${i != page.number+1 }">
								 <a href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${i-1}">
									<c:out value="${i}"/></a>
                               </c:if>
							</span>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:if test="${page.number+1 < page.totalPages }">
                            <span><a class="nextPage" href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.number+1 }"></a></span>
                        </c:if>

                        <!-- 尾页 -->
                        <a class="lastPage" href="${pageContext.request.contextPath}/findByCsid/${csid}?cspage=${page.totalPages-1 }"></a>
                    </c:if>
                </c:if>
            </div>
        </form>
    </div>
</div>
<div class="container footer">
</div>
</body>
</html>