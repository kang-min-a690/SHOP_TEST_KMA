<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shop</title>
    <jsp:include page="/layout/meta.jsp" /> 
    <jsp:include page="/layout/link.jsp" />
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>   
    <% 
        String root = request.getContextPath();
        String msg = request.getParameter("msg");
    %>
    
    <jsp:include page="/layout/header.jsp" />
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
    </div>

    <!-- 회원 가입/수정/탈퇴 완료 -->
    <div class="container mb-5">
        <%
            String message = null;

            if (msg != null) {
                switch (msg) {
                    case "1":
                        message = "회원 가입이 완료되었습니다.";
                        break;
                    case "0":
                        message = "joeun님 환영 합니다.";
                        break;
                    case "2":
                        message = "회원 정보가 수정되었습니다.";
                        break;
                    case "3":
                        message = "회원 정보가 삭제되었습니다.";
                        break;
                }
            }
        %>
        
        <%
            if (message != null) {
        %>
            <h1 class="text-center"><%= message %></h1>
            <br>
            <!-- 중앙 -->
            <a href="<%= root %>/index.jsp" class="btn btn-primary w-20 py-2 mt-5">메인화면</a>
        <%
            }
        %>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
