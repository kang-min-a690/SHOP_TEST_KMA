<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />

<%
    // 세션에서 로그인한 사용자 ID 확인
    String loginId = (String) session.getAttribute("loginId");
    String productId = request.getParameter("id");
    
    // 해당 상품 정보 가져오기
    Product product = productDAO.getProductById(productId);
    
    // 상품이 없으면 오류 페이지로 리디렉션
    if (product == null) {
        response.sendRedirect("error.jsp?msg=상품을 찾을 수 없습니다.");
        return;
    }
    
    // 장바구니 리스트 가져오기
    List<Product> productList = (List<Product>) session.getAttribute(loginId != null ? loginId : "user");
    
    // 장바구니가 없으면 새로 생성
    if (productList == null) {
        productList = new ArrayList<>();
    }
    
    // 상품이 이미 장바구니에 있는지 확인
    boolean productExists = false;
    for (Product test : productList) {
        if (test.getProductId().equals(product.getProductId())) {
            test.setQuantity(test.getQuantity() + 1); // 수량 증가
            productExists = true;
            break;
        }
    }
    
    // 장바구니에 없으면 상품 추가
    if (!productExists) {
        product.setQuantity(1); // 처음 추가 시 수량 1로 설정
        productList.add(product);
    }
    
    // 장바구니 리스트를 세션에 저장
    session.setAttribute(loginId != null ? loginId : "user", productList);
    
    // 상품 목록 페이지로 리디렉션
    response.sendRedirect(request.getContextPath() + "/shop/products.jsp");
%>
