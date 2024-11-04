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
	<% 
		String root = request.getContextPath(); 	// root 경로 불러오기 
		String msg = request.getParameter("msg");	// msg 전달값
		String printMsg = "";						// 출력할 메세지
		String userId = (String) session.getAttribute("userId"); // 로그인시 아이디값
		String orderId = request.getParameter("order_no"); // 주문번호
		String deliveryAddress = request.getParameter("address"); // 배송지

		// 주문 처리 로직
		// 비회원인지 확인
		boolean isGuest = (userId == null);
		if (isGuest) {
			String phone = request.getParameter("phone");
			String orderPw = request.getParameter("order_pw");
			// 비회원 주문 처리 로직 (order 테이블에 추가)
			// 비회원 정보를 사용하여 주문 내역 추가하는 로직을 구현
			// product_io 테이블에도 출고 정보 추가
			// 재고 수량 감소 로직
		} else {
			// 회원 주문 처리 로직 (userId 사용하여 주문 내역 추가)
			// product_io 테이블에도 출고 정보 추가
			// 재고 수량 감소 로직
		}
		
		// 메세지 설정
		switch(msg) {
			case "0" : printMsg = userId + "님 환영 합니다."; break; 
			case "1" : printMsg = "회원 가입이 완료되었습니다."; break; 
			case "2" : printMsg = "회원 정보가 수정되었습니다."; break; 
			case "3" : printMsg = "회원 정보가 삭제되었습니다."; break; 
		}
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	<!-- 주문 정보 출력 -->
	<div class="container mb-5">
		<p class="display-6 text-body-emphasis">주문 번호: <%= orderId %></p>
		<p class="display-6 text-body-emphasis">배송지: <%= deliveryAddress %></p>
		<p class="display-5 text-body-emphasis"><%= printMsg %></p>
		<a href="<%=root %>/user/order.jsp" class="btn btn-primary">주문내역</a>
		<a href="<%=root %>/" class="btn btn-secondary">메인화면</a>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
