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
<title>게시글 수정 페이지</title>
</head>
<body>
	<%
	String id = request.getParameter("id");

		StockItemService stockItemService = new StockItemServiceImpl();
		String cPage = stockItemService.checkcPage(id);

		StockItem stockItem = stockItemService.readOne(id);
		String newDate = stockItemService.newDate();
		pageContext.setAttribute("newDate", newDate);

		ServletContext context = getServletContext();
		context.setAttribute("stockItem", stockItem);
	%>
	
	<form action="updateDone.jsp" method="post">
		<table cellspacing=1 width=600 border=1>
			<tr>
				<td width=100px>상품 번호</td>
				<td><input type="text" name="id" value="${stockItem.id}" readonly></td>
			</tr>
			<tr>
				<td width=100px>상품명</td>
				<td><input type="text" placeholder="제목을 입력하세요." value="${stockItem.name}" readonly></td>
			</tr>
			<tr>
				<td width=100px>재고 현황</td>
				<td><input type="text" name="newStockNum" value="${stockItem.stockNum}" pattern='^[0-9]+$' ></td>
			</tr>
			<tr>
				<td width=100px>상품 등록일</td>
				<td><input type="text" value="${stockItem.regDate}" readonly></td>
			</tr>
			<tr>
				<td width=100px>재고 등록일</td>
				<td><input type="text" value="${newDate}" readonly></td>
			</tr>
			<tr>
				<td width=100px>상품설명</td>
				<td><input type="text" value="${stockItem.content}" readonly></input></td>
			</tr>
			<tr>
				<td width=100px>이미지 첨부</td>
				<td><textarea style="width: 500px; height: 300px;" readonly>이미지 들어갈 곳.</textarea></td>
			</tr>
		</table>
		<table cellspacing=1 width=400 border=0>
			<tr>
				<td width="200"></td>
				<td width="100"><p align="center">
						<input type="submit" value="등록">
					</p></td>
				<td width="100"><p align="center">
						<input type="button" value="취소"
							onclick="location.href='index.jsp'">
					</p></td>
			</tr>
		</table>
	</form>
	<p align="center">
		<input type="submit" value="삭제"
			onclick="location.href='deleteOne.jsp?id=${stockItem.id}'">
</body>
</html>