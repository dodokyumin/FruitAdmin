<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemService"%>
<%@page import="kr.ac.kopo.ctc.kopo444.domain.StockItem"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.Pagination"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>재고 확인</title>
</head>
<body>
	<%
	String id = request.getParameter("id");

		StockItemService stockItemService = new StockItemServiceImpl();
		String cPage = stockItemService.checkcPage(id);

		StockItem stockItem = stockItemService.readOne(id);

		ServletContext context = getServletContext();
		context.setAttribute("stockItem", stockItem);
	%>
	<table cellspacing=1 width=600 border=1>
		<tr>
			<td width=100px>상품 번호</td>
			<td>${stockItem.id}</td>
		</tr>
		<tr>
			<td width=100px>상품명</td>
			<td>${stockItem.name}</td>
		</tr>
		<tr>
			<td width=100px>재고 현황</td>
			<td>${stockItem.stockNum}</td>
		</tr>
		<tr>
			<td width=100px>상품등록일</td>
			<td>${stockItem.regDate}</td>
		</tr>
		<tr>
			<td width=100px>재고등록일</td>
			<td>${stockItem.curDate}</td>
		</tr>
		<tr>
			<td width=100px>상품설명</td>
			<td>${stockItem.content}</td>
		</tr>
		<tr>
			<td width=100px>상품사진</td>
			<td><img width="400" src="assets/${stockItem.fileName}"></td>
		</tr>
	</table>
	<c:if test="${stockItem.id != 0}">
		<table cellspacing=1 width=400 border=0>
			<tr>
				<td width="200"></td>
				<td width="100"><p align="center">
						<input type="submit" value="수정"
							onclick="location.href='updateOne.jsp?id=${stockItem.id}'">
					</p></td>
				<td width="100"><p align="center">
						<input type="submit" value="삭제"
							onclick="location.href='deleteOne.jsp?id=${stockItem.id}'">
					</p></td>
			</tr>
		</table>
	</c:if>

</body>
</html>