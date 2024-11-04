<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    String root = request.getContextPath();

    // 사용자로부터 ID를 가지고 오기
    String userId = request.getParameter("id");

    // 회원 탈퇴 처리
    int result = userDAO.delete(userId);

    if (result > 0) {
        // 탈퇴 성공
        response.sendRedirect(root + "/user/index.jsp?msg=1");
    } else {
        // 탈퇴 실패
        out.println("<script type='text/javascript'>");
        out.println("alert('탈퇴 처리에 실패했습니다. 다시 시도해주세요.');");
        out.println("window.location.href='" + root + "/user/update.jsp';"); // 회원정보 수정 페이지로 리다이렉트
        out.println("</script>");
    }
%>
