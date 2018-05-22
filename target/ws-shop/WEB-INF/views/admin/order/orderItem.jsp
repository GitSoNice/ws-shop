<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<table class="table">
		<tbody>
		<tr>
			<c:forEach items="${orderItems}" var="i">
			<tr bgcolor="#778899">
				<td>
					商品编号
				</td>
            <td><c:out value="${i.product.pid}" /></td>
			</tr>

			<tr>
				<td>
					名称
				</td>
				<td><c:out value="${i.product.pname}" /></td>
			</tr>

			<tr>
				<td>
					数量
				</td>
				<td><c:out value="${i.count}" /></td>
			</tr>

			<tr>
				<td>
					金额
				</td>
				<td><c:out value="${i.subtotal}" /></td>
			</tr>
			</c:forEach>
		</tbody>
</table>