<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 cartList 가져오기
    String loginId = (String) session.getAttribute("loginId");
    ArrayList<Product> cartList = loginId != null ? 
                                  (ArrayList<Product>) session.getAttribute(loginId) :
                                  (ArrayList<Product>) session.getAttribute("user");

    // 개별 또는 전체 삭제 구분
    String productId = request.getParameter("id");  // 개별 삭제 상품 ID
    String deleteAll = request.getParameter("deleteAll"); // 전체 삭제 여부 확인

    if (deleteAll != null && deleteAll.equals("true")) {
        // 전체 삭제
        cartList.clear();
    } else if (productId != null) {
        // 개별 삭제
        cartList.removeIf(product -> product.getProductId().equals(productId));
    }

    // 삭제된 장바구니 상태 세션에 저장
    if (loginId != null) {
        session.setAttribute(loginId, cartList);
    } else {
        session.setAttribute("user", cartList);
    }

    // 장바구니 페이지로 리디렉션
    response.sendRedirect("cart.jsp");
%>
