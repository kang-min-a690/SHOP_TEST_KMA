<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String productId = request.getParameter("id");

    ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");

    if (cartList != null && productId != null) {
        cartList.removeIf(product -> product.getProductId().equals(productId));
        session.setAttribute("cartlist", cartList);
    }

    response.sendRedirect("cart.jsp");
%>
