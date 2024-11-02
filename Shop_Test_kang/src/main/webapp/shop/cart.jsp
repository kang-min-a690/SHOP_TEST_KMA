<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> 
	<title>장바구니</title>
	<jsp:include page="/layout/meta.jsp"/>
	<jsp:include page="/layout/link.jsp"/>
</head>
<body>
	<jsp:include page="/layout/header.jsp"/>
	<%-- [Contents] ######################################################### --%>
	<form>
	
	
	</form>
	<%-- [Contents] #################################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	<script src="<%=request.getContextPath() %>">/static/js/validation.js</script>
</body>
</html>