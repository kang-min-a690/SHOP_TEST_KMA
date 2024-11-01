<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% String root = request.getContextPath(); %>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		
		<% 
			String msg = request.getParameter("msg");
			String message = "";
			
			if ("1".equals(msg)) {
				message = "로그인이 완료되었습니다.";
			} else if ("2".equals(msg)) {
				message = "회원 가입이 완료되었습니다.";
			} else if ("3".equals(msg)) {
				message = "정보 수정이 완료되었습니다.";
			} else {
				message = "처리된 요청이 없습니다.";
			}
		%>
		
		<p><%= message %></p>
		<a href="<%= root %>/user/index.jsp" class="btn btn-primary mt-3">메인 페이지로 이동</a>
	</div>
	
	<div class="container mb-5">
		<!-- 추가적인 내용이 필요하다면 여기에 작성 -->
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
