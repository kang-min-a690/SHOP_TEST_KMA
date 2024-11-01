<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
    // 로그인된 사용자 ID 확인
    String loginId = (String) session.getAttribute("loginId");
    if (loginId == null || loginId.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 사용자가 제출한 폼 데이터 받기
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String birth = year + "/" + month + "/" + day;
    String email = request.getParameter("email1") + "@" + request.getParameter("email2");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // User 객체 생성 및 데이터 설정
    User user = new User();
    user.setId(loginId);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);

    // 회원 정보 업데이트
    int result = userDAO.update(user);

    // 결과에 따라 페이지 리다이렉트
    if (result > 0) {
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }
%>
