<%@page import="utils.PasswordUtils"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    String root = request.getContextPath();
    
    // 사용자로부터 ID와 비밀번호를 가지고 오기.
    String userId = request.getParameter("id");
    String password = request.getParameter("pw");
    
    // 사용자 인증을 위해 DB에서 사용자 정보 조회
    User user = userDAO.getUserById(userId);
    
    if (user != null && PasswordUtils.check(password, user.getPassword())) {
        // 비밀번호가 일치하면 회원 탈퇴 처리
        int result = userDAO.delete(userId);
        
        if (result > 0) {
            // 탈퇴 성공
            response.sendRedirect(root + "/user/leave_complete.jsp?msg=1");
        } else {
            // 탈퇴 실패
            response.sendRedirect(root + "/user/leave.jsp?msg=0");
        }
    } else {
        // 아이디 또는 비밀번호 불일치
        response.sendRedirect(root + "/user/leave.jsp?msg=2");
    }
%>
