<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// 상품 id 받아오기
	String id = request.getParameter("id");

	// id 값이 존재하지 않거나 공백이면
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}

	ProductRepository dao = new ProductRepository(); // 인스턴스 생성
	Product product = dao.getProductById(id);
	if (product == null) {
		// id에 해당하는 상품이 존재하지 않으면 해당 에러 페이지로 이동
		response.sendRedirect("exceptionNoProductId.jsp");
		return;
	}

	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");

	if (cartList != null) {
		Iterator<Product> iterator = cartList.iterator();
		while (iterator.hasNext()) {
			Product goodsQnt = iterator.next();
			// 삭제하려는 상품과 동일한 상품이 list에 있으면
			if (goodsQnt.getProductId().equals(id)) {
				iterator.remove(); // 안전하게 삭제
				break; // 중복 삭제 방지
			}
		}
	}

	// 장바구니 페이지로 리다이렉트
	response.sendRedirect("cart.jsp");

%>
