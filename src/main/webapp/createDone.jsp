<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.StockItemService"%>
<%@page import="kr.ac.kopo.ctc.kopo444.domain.StockItem"%>
<%@page import="kr.ac.kopo.ctc.kopo444.service.Pagination"%>
<%@page import="java.util.List, java.util.Enumeration,com.oreilly.servlet.multipart.DefaultFileRenamePolicy, com.oreilly.servlet.MultipartRequest"%>
<%@page errorPage="duplicateIdError.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>신규 게시글 추가 완료</title>
</head>
<body>
	<%
	int size = 1024 * 1024 * 10;// 파일 사이즈 설정
	String fileName = ""; //업로드한 파일 이름
	String originalFileName = ""; //서버에 중복된 파일 이름이 존재할 경우 처리하기 위해

	String strId = "";
	String strName = "";
	String strStockNum = "";
	String strContent = "";
	String path = "";

	path = "C:\\Users\\501-01\\Documents\\workspace-spring-tool-suite-4-4.15.0.RELEASE\\FruitAdmin\\src\\main\\webapp\\assets";
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	// 전송한 전체 파일이름들을 가져온다.
	Enumeration<?> files = multi.getFileNames();
	String str = (String) files.nextElement();
	//파일명 중복이 발생했을 때 정책에 의해 뒤에 1,2,3 처럼 숫자가 붙어 고유 파일명을 생성한다.
	// 이때 생성된 이름을 FilesystemName이라고 하여 그 이름 정보를 가져온다. (중복 처리)
	fileName = multi.getFilesystemName(str); //실제 assets 폴더에 저장된 파일 이름
	originalFileName = multi.getOriginalFileName(str); //사용자가 업로드 할 때 원본 파일 이름

	strId = multi.getParameter("newId");
	strName = multi.getParameter("newName");
	strStockNum = multi.getParameter("newStockNum");
	strContent = multi.getParameter("newContent");
	
	StockItemService stockItemService = new StockItemServiceImpl();
	Boolean result = stockItemService.stockItemCreateOne(strName, strStockNum, strContent, strId, fileName);
	ServletContext context = getServletContext();
	context.setAttribute("result", result);
	%>
	<script>
	if(${result}){
		if (window.confirm("게시글이 등록되었습니다.")) {
			window.location.href = "index.jsp";
		}
	} else {
		window.confirm("게시글 등록 실패.")
	}
	
	</script>
</body>
</html>