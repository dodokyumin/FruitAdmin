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
<title>게시글 수정 완료</title>
</head>
<body>
	<%
		StockItemService stockItemService = new StockItemServiceImpl();

		request.setCharacterEncoding("UTF-8");
		String stockNum = request.getParameter("newStockNum");
		String id = request.getParameter("id");
		
		StockItem boardItem = stockItemService.stockItemUpdateOne(stockNum, id);

		ServletContext context = getServletContext();
		context.setAttribute("boardItem", boardItem);
	%>

	<script>
		if (window.confirm("게시글이 수정되었습니다.")) {
			window.location.href = "index.jsp";
		}
	</script>
</body>
</html>