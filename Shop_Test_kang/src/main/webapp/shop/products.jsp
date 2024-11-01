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
	<title></title>
</head>
<body>  
	


    

<nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/Shop/">Home</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/Shop/shop/products.jsp">Product</a>
        </li>
      </ul>
       <ul class="navbar-nav d-flex align-items-center px-3">
       	
       	<!-- 비로그인 시 -->
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="/Shop/user/login.jsp">로그인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="/Shop/user/join.jsp">회원가입</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="/Shop/user/order.jsp">주문내역</a>
        </li>
        
        <li class="nav-item">
	        <a class="nav-link position-relative" aria-current="page" href="/Shop/shop/cart.jsp">
	        	<i class="material-symbols-outlined">shopping_bag</i>
	        	<span class="cart-count">0</span>
	        </a>
        </li>
      </ul>
      <form class="d-flex" role="search" action="/Shop/shop/products.jsp" method="get">
        <input class="form-control me-2" type="search" name="keyword" placeholder="Search" aria-label="Search" value="자바">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>





	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 목록</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			
				<a href="/Shop/shop/add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
				<a href="/Shop/shop/editProducts.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 편집</a>
				<a href="/Shop/shop/cart.jsp" class="btn btn-warning btn-lg px-4 gap-3">장바구니</a>
				
			</div>
		</div>
	</div>
	
	<div class="container mb-5">
		<div class="row gy-4">
			
				<div class="col-md-6 col-xl-4 col-xxl-3">
					<div class="card p-3">
						<!-- 이미지 영역 -->
						<div class="img-content">
							<img src="img?id=P100001" class="w-100 p-2">
						</div>
						<!-- 컨텐츠 영역 -->
						<div class="content">
							<h3 class="text-center">자바 프로그래밍</h3>
							<p>안녕하세요 자바프로그래밍 강의입니다.</p>
							<p class="text-end price">₩ 50000</p>
							<p class="d-flex justify-content-between">
								<a href="./cart_pro.jsp?id=P100001" class="btn btn-outline-primary"><i class="material-symbols-outlined">shopping_bag</i></a>
								<a href="./product.jsp?id=P100001" class="btn btn-outline-primary">상세 정보</a>
							</p>
						</div>						
					</div>
				</div>
			
			
			
		</div>
	</div>
	
<footer class="container p-5">
	<p>copyright Shop</p>
</footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!-- <script src="../static/js/validation.js"></script> -->			<!-- 상대경로 -->
	<!-- 절대경로 -->
<script src="/Shop/static/js/validation.js"></script>












</body>
</html>