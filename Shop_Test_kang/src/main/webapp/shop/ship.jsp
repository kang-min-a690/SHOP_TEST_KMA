<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>배송 정보 등록</title>
	<%@ include file="/layout/meta.jsp" %>
	<%@ include file="/layout/link.jsp" %>
	<link rel="stylesheet" href="static/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
	</div>
	<div class="container shop mb-5 p-4">
		<form action="ship_pro.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="E7DFB7E21FCEE66B899987D7B3EAD39B">
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">성명</label>
				<input type="text" class="form-control col-md-10" name="name" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">배송일</label>
				<input type="date" class="form-control col-md-10" name="shippingDate" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">국가명</label>
				<input type="text" class="form-control col-md-10" name="country" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">우편번호</label>
				<input type="text" class="form-control col-md-10" name="zipCode" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">주소</label>
				<input type="text" class="form-control col-md-10" name="addressName" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2">전화번호</label>
				<input type="tel" class="form-control col-md-10" name="phone" required>
			</div>
			
			<!-- 버튼 영역 -->
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div>
					<a href="cart.jsp" class="btn btn-lg btn-success">이전</a>
					<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-lg btn-danger">취소</a>
				</div>
				<div>
					<input type="submit" class="btn btn-lg btn-primary" value="등록">
				</div>
			</div>
		</form>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
</body>
</html>
