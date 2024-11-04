<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<%@ include file="/layout/meta.jsp" %>
	<%@ include file="/layout/link.jsp" %>
</head>
<body>
	<%
		String productId = request.getParameter("productId");
		Product product = productDAO.getProductById(productId);
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
	
		<h1 class="display-5 fw-bold text-body-emphasis">상품정보</h1>
		<div class="col-lg-6 mx-auto">
		
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">	
			
			
				<a href="./products.jsp" class="btn btn-primary btn-lg px-4 gap-3" alt="싱품목록">상품목록</a>
				</div>
			</div>
		</div>
			<div class="container">
						<div class="row">
				<div class="col-md-6">
					<img src="<%= root %>/shop/img?id=<%= product.getProductId() %>" class="w-100 p-2">
				</div>
					<div class="col-md-6">
					<h3 class="mb-5"><%=product.getName()%></h3>
			 		<table class="table">
			 			<colgroup>
				 			<col width="120px">
				 			<col>
			 			</colgroup>
			 		<tbody><tr>
			 			<td>상품ID :</td>
			 			<td><%=product.getProductId()%></td>
			 		</tr>
			 		<tr>
			 			<td>제조사 :</td>
			 			<td><%=product.getManufacturer()%></td>
			 		</tr>
			 		<tr>
			 			<td>분류 :</td>
			 			<td><%=product.getCategory()%></td>
			 		</tr>
			 		<tr>
			 			<td>상태 :</td>
			 			<td><%=product.getCondition()%></td>
			 		</tr>
			 		<tr>
			 			<td>재고 수 :</td>
			 			<td><%=product.getUnitsInStock()%></td>
			 		</tr>
			 		<tr>
			 			<td>가격 :</td>
			 			<td><%=product.getUnitPrice()%></td>
			 		</tr>
				</tbody></table>
				<div class="mt-4">
					<form name="addForm" action="./addCart.jsp" method="post">
						<input type="hidden" name="id" value="P100001">
						<div class="btn-box d-flex justify-content-end ">
							<a href="./cart.jsp" class="btn btn-lg btn-warning mx-3" alt="장바구니">장바구니</a>
							
							<a href="javascript:;" class="btn btn-lg btn-success mx-3" alt="주문하기" onclick="addToCart('<%=productId%>','<%=root%>')">주문하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<script type="text/javascript">
		function addToCart(productId,root){
			window.location.href = root+"/shop/addCart.jsp?productId="+productId;
		}
	</script>
</body>
</html>