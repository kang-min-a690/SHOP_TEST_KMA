<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    
    UserRepository userDAO = new UserRepository();
    User loginUser = userDAO.login(id, pw);
    
    // 로그인 실패
    if (loginUser == null) {
        // 로그인 실패 처리 (예: 에러 메시지 출력)
        response.sendRedirect("login.jsp?error=1"); // 실패시 로그인 페이지로 리다이렉트
        return;
    }
    
    // 로그인 성공
    // - 세션에 아이디 등록
    session.setAttribute("userId", loginUser.getId());
    
    // 아이디 저장
    String rememberMe = request.getParameter("remember-me");
    if ("on".equals(rememberMe)) {
        String token = userDAO.insertToken(loginUser.getId()); // DB에 사용자 ID와 토큰 저장

        // 쿠키 전달
        Cookie tokenCookie = new Cookie("token", URLEncoder.encode(token, "UTF-8"));
        tokenCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 동안 유지
        tokenCookie.setPath("/"); // 모든 경로에서 쿠키 접근 가능
        response.addCookie(tokenCookie);
    }

    // 로그인 성공 페이지로 이동
    response.sendRedirect("complete.jsp?msg=0");		
%>
