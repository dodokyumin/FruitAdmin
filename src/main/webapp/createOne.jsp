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
<meta charset="UTF-8">
<title>신규 재고 추가</title>
</head>
<body>
	<%
	String id = request.getParameter("id");

	StockItemService stockItemService = new StockItemServiceImpl();

	String newDate = stockItemService.newDate();
	pageContext.setAttribute("newDate", newDate);
	%>
	<form action="createDone.jsp" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<table cellspacing=1 width=600 border=1>
			<tr>
				<td width=100px>상품 번호</td>
				<td><input type="text" name="newId" maxlength='5' pattern='^[0-9]+$' placeholder="상품 번호를 입력하세요."></td>
			</tr>
			<tr>
				<td width=100px>상품명</td>
				<td><input type="text" placeholder="상품명을 입력하세요." maxlength='20' name="newName"
					pattern='^[가-힣a-zA-Z0-9\s?~!@#$%^&*()/ -]+$' required></td>
			</tr>
			<tr>
				<td width=100px>재고 현황</td>
				<td><input type="text" name="newStockNum"
					placeholder="재고를 입력하세요" pattern='^[0-9]+$' maxlength='5'></td>
			</tr>
			<tr>
				<td width=100px>상품 등록일</td>
				<td><input type="text" value="${newDate}" readonly></td>
			</tr>
			<tr>
				<td width=100px>재고 등록일</td>
				<td><input type="text" value="${newDate}" readonly></td>
			</tr>
			<tr>
				<td width=100px>상품설명</td>
				<td><input type="text" name="newContent"
					placeholder="상품 설명을 입력하세요."
					pattern='^[가-힣a-zA-Z0-9\s?~!@#$%^&*()/]+$' required>
				</td>
			</tr>
			<tr>
				<td width=100px>이미지 첨부</td>
				<td height="650px"><input type="file" name="img"></td>
				<!--  .jpg, .jpeg, .png, .gif  -->
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
</body>
</html>