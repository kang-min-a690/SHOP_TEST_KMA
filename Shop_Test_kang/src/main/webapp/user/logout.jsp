<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 자동 로그인, 토큰 쿠키 삭제
    String tokenName = "authToken"; // 토큰 이름 설정
    Cookie cookie = new Cookie(tokenName, null);
    cookie.setMaxAge(0); // 쿠키 만료
    cookie.setPath("/"); // 모든 경로에서 유효하도록 설정
    response.addCookie(cookie); // 쿠키 삭제 요청

    // 세션 무효화( session 충돌, 커런트로 변경~)
    HttpSession currentSession  = request.getSession(false);
    if (session != null) {
        session.invalidate(); // 세션 무효화
    }

    // 쿠키 전달 및 로그아웃 완료 메시지
    response.sendRedirect("complete.jsp?msg=4"); // 로그아웃 완료 페이지로 리다이렉트
%>
