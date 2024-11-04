<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
	// ID 확
	String loginId = (String) session.getAttribute("loginId");
	if( loginId == null || loginId.isEmpty()) {
		response.sendRedirect("login.jsp");
		return;
	}
	
	String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String birth = year + "/" + month + "/" + day;
    String email = request.getParameter("email1") + "@" + request.getParameter("email2");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    
    User user = new User();
    user.setId(loginId);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);
    
	// 회원 정보 수정 처리

    int result = userDAO.update(user);

    if (result >0 ){
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }

%>