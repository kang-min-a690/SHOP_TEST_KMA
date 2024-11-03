<%@page import="shop.dto.Ship"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<%
    Ship ship = new Ship();

    String name = request.getParameter("name"); 
    String shippingDate = request.getParameter("shippingDate");
    String country = request.getParameter("country");
    String zipCode = request.getParameter("zipCode");
    String addressName = request.getParameter("addressName");
    String phone = request.getParameter("phone");

    ship.setShipName(name);
    ship.setDate(shippingDate);
    ship.setCountry(country);
    ship.setZipCode(zipCode);
    ship.setAddress(addressName);
    ship.setPhone(phone);

    session.setAttribute("ship", ship);

    response.sendRedirect(root + "/shop/order.jsp"); // root는 meta.jsp에서 선언된 것을 사용
%>
