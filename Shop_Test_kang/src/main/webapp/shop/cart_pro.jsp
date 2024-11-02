<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int sum = 0;

	// 세션에서 cartlist 속성 가져오기
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	
	if (cartList != null && !cartList.isEmpty()) {
		for (Product product : cartList) {
			// 장바구니 목록 하나씩 출력하기
			int total = product.getUnitPrice() * product.getQuantity();
			sum += total;
		}
	} else {

	}
%>
<%-- <p>총 합계: <%= sum %> 원</p> --%>
