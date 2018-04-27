<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
		<TBODY>
		<tr>
			<c:forEach items="${orderItems}" var="i">
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					图片
				</td>
				<td class="ta_01" bgColor="#ffffff">
					<img id="pic" width="40" height="45" src="${ pageContext.request.contextPath }/<c:out value="${i.product.image}"/>">
				</td>
			</tr>

			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					名称
				</td>
				<td class="ta_01" bgColor="#ffffff"><c:out value="${i.product.pname}" /></td>
			</tr>

			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					数量
				</td>
				<td class="ta_01" bgColor="#ffffff"><c:out value="${i.count}" /></td>
			</tr>

			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					金额
				</td>
				<td class="ta_01" bgColor="#ffffff"><c:out value="${i.subtotal}" /></td>
			</tr>
			</c:forEach>
</table>