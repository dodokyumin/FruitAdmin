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
<title>(주)트와이스</title>
</head>
<body>
	<h1>(주)트와이스 재고 현황 - 전체현황</h1>
	<table cellspacing=1 width=700 border=1>
		<tr style="background-color: grey;">
			<th width=100px>상품번호</th>
			<th width=300px>상품명</th>
			<th width=100px>현재 재고 수</th>
			<th width=100px>재고 파악일</th>
			<th width=100px>상품 등록일</th>
		</tr>
		<%
		String strcPage = request.getParameter("strcPage");

				StockItemService stockItemService = new StockItemServiceImpl();
				String cPage = stockItemService.checkcPage(strcPage);

				List<StockItem> stockItems = stockItemService.readAll(cPage);
				int rowCount = stockItemService.getRowCount();
				Pagination pagination = stockItemService.getPagination(cPage);

				ServletContext context = getServletContext();
				context.setAttribute("rowCount", rowCount);
				context.setAttribute("stockItems", stockItems);
				context.setAttribute("pagination", pagination);
		%>
		<c:if test="${rowCount == 0}">
			<tr>
				<td colspan="5" style="text-align: center">남은 재고가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:forEach var="stockItem" items="${stockItems}">
			<tr>
				<td style="text-align: center">${stockItem.id}</td>
				<td><a href="readOne.jsp?id=${stockItem.id}">${stockItem.name}</a></td>
				<td style="text-align: center">${stockItem.stockNum}</td>
				<td style="text-align: center">${stockItem.curDate}</td>
				<td style="text-align: center">${stockItem.regDate}</td>
			</tr>
		</c:forEach>
	</table>
	<div>
			<input type="button" value="신규"
				onclick="location.href='createOne.jsp'"> <input
				type="button" value="초기화" onclick="location.href='deleteAll.jsp'"><br>


		<c:if test="${rowCount != 0}">
			<c:if test="${pagination.ppPage != 0 && pagination.pPage != 0}">
				<a href='index.jsp?strcPage=${pagination.getPpPage()}'> << </a>
				<a href='index.jsp?strcPage=${pagination.getpPage()}'> < </a>
			</c:if>


			<c:forEach var="noPage" begin="${pagination.firstPage}"
				end="${pagination.lastPage}">
				<c:if test="${noPage != 0}">
					<c:choose>
						<c:when test="${noPage == pagination.cPage}">
							<b><a style='text-decoration: underline;'
								href='index.jsp?strcPage=${noPage}'>${noPage}</a></b>
						</c:when>
						<c:when test="${noPage != pagination.getcPage()}">
							<a href='index.jsp?strcPage=${noPage}'>${noPage}</a>
						</c:when>
					</c:choose>
				</c:if>
			</c:forEach>

			<c:if test="${pagination.nnPage != 0 && pagination.nPage != 0}">
				<a href='index.jsp?strcPage=${pagination.nPage}'> > </a>
				<a href='index.jsp?strcPage=${pagination.nnPage}'> >> </a>
			</c:if>
		</c:if>
	</div>
</body>
</html>