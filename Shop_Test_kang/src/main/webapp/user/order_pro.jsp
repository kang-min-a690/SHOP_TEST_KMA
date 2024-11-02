<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% String root = request.getContextPath(); %>
<%
    // 파라미터로 전달된 비회원 전화번호와 주문 비밀번호 받기
    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");

    // OrderRepository 객체 생성
    OrderRepository orderRepository = new OrderRepository();

    // 비회원 주문 내역 조회
    List<Product> orderList = orderRepository.list(phone, orderPw);

    // 조회된 주문 내역이 있을 경우 세션에 저장
    if (orderList != null && !orderList.isEmpty()) {
        session.setAttribute("orderList", orderList);
        session.setAttribute("orderPhone", phone);
    } else {
        // 조회된 주문 내역이 없을 경우, 에러 메시지를 세션에 저장
        session.setAttribute("errorMsg", "주문 내역을 찾을 수 없습니다. 다시 시도해주세요.");
    }

    // 주문 내역 페이지로 리다이렉트
    response.sendRedirect(root + "/user/order.jsp");
%>
