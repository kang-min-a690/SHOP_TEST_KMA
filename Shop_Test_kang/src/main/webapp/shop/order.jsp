<%@page import="shop.dto.Ship"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Order</title>
	<%@ include file="/layout/meta.jsp" %>
	<%@ include file="/layout/link.jsp" %>
</head>
<body>
	<%
		String loginId = (String) session.getAttribute("loginId");
		List<Product> productList = null;
		String cartId = null;
		String orderType="비회원 주문";
		if(loginId!=null){
			cartId = loginId;
			orderType="회원 주문";
			productList = (List<Product>) session.getAttribute(loginId);
		}
		else{
			cartId = "user";
			productList = (List<Product>) session.getAttribute("user");
		}
		Ship ship = (Ship)application.getAttribute("ship");
		if (ship == null) {
			out.println("배송 정보가 없습니다.");
			return;
		}
		int sum = 0;
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
	</div>
	<div class="container order mb-5">
		<form action="complete.jsp" method="post">
		<!-- 배송정보 -->
		<div class="ship-box">
			<table class="table ">
				<tbody>
					<tr>
						<td>주문 형태 :</td>
						<td><%=orderType%></td>
					</tr>
					<tr>
						<td>성 명 :</td>
						<td><%=ship.getShipName() %></td>
					</tr>
					<tr>
						<td>우편번호 :</td>
						<td><%=ship.getZipCode() %></td>
					</tr>
					<tr>
						<td>주소 :</td>
						<td><%=ship.getAddress() %></td>
					</tr>
					<tr>
						<td>배송일 :</td>
						<td><%=ship.getDate() %></td>
					</tr>
					<tr>
						<td>전화번호 :</td>
						<td><%=ship.getPhone() %></td>
					</tr>
					<% if(loginId==null) { %>
					<tr>
						<td>주문 비밀번호 :</td>
						<td><input type="password" class="form-control col-md-10" name="password" value=""></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div>
		
		<!-- 주문목록 -->
		<div class="cart-box">
		<table class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
				if(productList != null){
					for(Product product:productList) {
						int total = product.getUnitPrice() * product.getQuantity();
						sum += total;
				%>
					<tr>
						<td><%=product.getName()%></td>
						<td><%=product.getUnitPrice()%></td>
						<td><%=product.getQuantity()%></td>
						<td><%=total%></td>
						<td></td>
					</tr>
				<% } } %>
			</tbody>
			<%
			if (productList == null || productList.size() == 0) {
			%>
			<tfoot>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>	
				</tr>
			</tfoot>
			<%
			} else {
			%>
			<tfoot>
				<tr>
					<td></td>
					<td></td>
					<td>총액</td>
					<td id="cart-sum"><%=sum%></td>
					<td></td>
				</tr>
			</tfoot>
			<% } %>
		</table>
		</div>
		<input type="hidden" value="<%=sum%>" name="total_price">
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between mt-5 mb-5">
			<div class="item">
				<a href="ship.jsp" class="btn btn-lg btn-success">이전</a>
				<a href="index.jsp" class="btn btn-lg btn-danger">취소</a>
			</div>
			<div class="item">
				<input type="hidden" name="login" value="true">
				<input type="hidden" name="totalPrice" value="<%= sum %>">
				<input type="submit" class="btn btn-lg btn-primary" value="주문완료">	
			</div>
		</div>
		</form>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
