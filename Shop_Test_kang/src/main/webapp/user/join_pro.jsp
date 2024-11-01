<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	User user = new User();
	UserRepository userDAO = new UserRepository();
	//아이디
	user.setId(request.getParameter("id"));
	//비밀번호
	user.setPassword(request.getParameter("pw"));
	//이름
	user.setName(request.getParameter("name"));
	// 성별
	user.setGender(request.getParameter("gender"));
	
	// 생일 입력
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	// 날짜 나눠서
	String birth = year + "/" + month + "/" + day;
	user.setBirth(birth);
	
	// 이메일 입력
	String email = request.getParameter("email");
	user.setMail(email);
	
	//폰
	user.setPhone(request.getParameter("phone"));
	//주소
	user.setAddress(request.getParameter("address"));
	
	int result = userDAO.insert(user);
	if (result != 1){
		response.sendRedirect(root + "/user/join.jsp");
	} else {
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	}
%>
