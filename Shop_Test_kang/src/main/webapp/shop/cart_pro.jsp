<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
<%
    String loginId = (String) session.getAttribute("loginId");
    String productId = request.getParameter("id");
    Product product = productDAO.getProductById(productId);
    
    List<Product> productList = (List<Product>) session.getAttribute(
        loginId != null ? loginId : "user"
    );
    
    if (productList == null) {
        productList = new ArrayList<>();
    }
    
    boolean productExists = false;
    
    for (Product test : productList) {
        if (test.getProductId().equals(product.getProductId())) {
            test.setQuantity(test.getQuantity() + 1);
            productExists = true;
            break;
        }
    }
    
    if (!productExists) {
        product.setQuantity(1);
        productList.add(product);
    }
    
    session.setAttribute(loginId != null ? loginId : "user", productList);
    
    response.sendRedirect(request.getContextPath() + "/shop/products.jsp");

%>
