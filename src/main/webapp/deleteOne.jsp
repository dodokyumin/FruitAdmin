<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemService"%>
<%@page import="kr.ac.kopo.ctc.kopo444.domain.StockItem"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.Pagination"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 삭제 완료</title>
</head>
<body>
	<%
		StockItemService stockItemService = new StockItemServiceImpl();

		String strId = request.getParameter("id");

		StockItem stockItem = stockItemService.readOne(strId);

		Boolean result = stockItemService.stockItemDeleteOne(strId);
		
		ServletContext context = getServletContext();
		context.setAttribute("result", result);

		String fileName = stockItem.getFileName();
		String filePath2 = "C:\\Users\\501-01\\Documents\\workspace-spring-tool-suite-4-4.15.0.RELEASE\\FruitAdmin\\src\\main\\webapp\\assets\\" + fileName;

		File deleteFile2 = new File(filePath2);

		deleteFile2.delete();
	%>
	<script>
	
	
	if(${result}){
		if (window.confirm("게시글이 삭제되었습니다.")) {
			window.location.href = "index.jsp";
		}
	} else {
		window.confirm("게시글이 삭제 실패.")
	}
	
	</script>
</body>
</html>