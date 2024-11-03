<%@page import="java.sql.SQLException"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Types"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.JDBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 완료</title>
     <jsp:include page="/layout/meta.jsp"/>
    <jsp:include page="/layout/link.jsp"/>
    <link rel="stylesheet" href="static/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	 <jsp:include page="/layout/header.jsp"/>

    <div class="container">
        <h1>주문 완료</h1>

        <%
            // 주문 정보를 세션에서 가져옵니다.
            String orderId = (String) session.getAttribute("orderId");
            String userId = (String) session.getAttribute("loginId");
            String phone = (String) session.getAttribute("phone");
            String shippingAddress = (String) session.getAttribute("shippingAddress");
            String orderPassword = (String) session.getAttribute("orderPassword");

            // 주문 정보 출력
        %>
        <h2>주문 정보</h2>
        <p>주문번호: <%= orderId != null ? orderId : "없음" %></p>
        <p>배송지: <%= shippingAddress != null ? shippingAddress : "정보 없음" %></p>

        <a href="<%= request.getContextPath() %>/user/order.jsp" class="btn">주문내역</a>

        <%
            // 주문 처리 기능 구현
            JDBConnection dbConnection = new JDBConnection();
            Connection conn = null;

            try {
                conn = dbConnection.con; // JDBConnection에서 가져온 Connection
                conn.setAutoCommit(false); // 트랜잭션 시작

                // 주문 내역 추가
                String insertOrderSQL = "INSERT INTO `order` (order_id, user_id, phone, order_pw) VALUES (?, ?, ?, ?)";
                PreparedStatement orderStmt = conn.prepareStatement(insertOrderSQL);
                orderStmt.setString(1, orderId);
                if (userId != null) {
                    orderStmt.setString(2, userId); // 회원일 경우 userId 저장
                    orderStmt.setNull(3, Types.VARCHAR); // 전화번호는 null
                    orderStmt.setNull(4, Types.VARCHAR); // 주문 비밀번호는 null
                } else {
                    orderStmt.setNull(2, Types.VARCHAR); // 비회원일 경우 userId는 null
                    orderStmt.setString(3, phone); // 전화번호 저장
                    orderStmt.setString(4, orderPassword); // 주문 비밀번호 저장
                }
                orderStmt.executeUpdate();

                // 상품 입출고 테이블에 출고 데이터 추가
                ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
                String insertProductIO_SQL = "INSERT INTO product_io (product_id, type, amount) VALUES (?, 'OUT', ?)";
                PreparedStatement productIOStmt = conn.prepareStatement(insertProductIO_SQL);

                for (Product product : cartList) {
                    productIOStmt.setString(1, product.getProductId());
                    productIOStmt.setInt(2, product.getQuantity());
                    productIOStmt.executeUpdate();
                }

                // 상품 테이블에서 재고 감소
                String updateProduct_SQL = "UPDATE product SET units_in_stock = units_in_stock - ? WHERE product_id = ?";
                PreparedStatement updateProductStmt = conn.prepareStatement(updateProduct_SQL);

                for (Product product : cartList) {
                    updateProductStmt.setInt(1, product.getQuantity());
                    updateProductStmt.setString(2, product.getProductId());
                    updateProductStmt.executeUpdate();
                }

                // 트랜잭션 커밋
                conn.commit();

                // 연결 종료
                orderStmt.close();
                productIOStmt.close();
                updateProductStmt.close();
            } catch (Exception e) {
                e.printStackTrace();
                // 오류 처리 및 롤백
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            } finally {
                if (conn != null) {
                    try {
                        conn.close(); // 데이터베이스 연결 닫기
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
    
     <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
