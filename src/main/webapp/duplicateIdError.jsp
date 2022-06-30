<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page isErrorPage="true"%>
<html>
<head>

</head>
<body>
	<script>
		if (window.confirm("상품 번호가 중복됩니다. \n 다른 번호를 입력해주세요.")) {
			history.back();
		}
	</script>

</body>

</html>