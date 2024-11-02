<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"> 
    <title>장바구니</title>
    <jsp:include page="/layout/meta.jsp"/>
    <jsp:include page="/layout/link.jsp"/>
    <link rel="stylesheet" href="static/css/style.css">
    <!-- Bootstrap CSS 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/layout/header.jsp"/>
    
    <div class="container-cart mt-5">
        <div class="text-center mb-4">
            <h1 class="display-4">장바구니</h1>
            <p class="lead">장바구니 목록입니다.</p>
        </div>

        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>상품</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>소계</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");

                    if (cartList != null && !cartList.isEmpty()) {
                        for (Product product : cartList) {
                            int total = product.getUnitPrice() * product.getQuantity(); // 각 제품의 소계 계산
                    %>
                    <tr>
                        <td><%= product.getProductId() %> - <%= product.getName() %></td>
                        <td><%= product.getUnitPrice() %> 원</td>
                        <td><%= product.getQuantity() %></td>
                        <td><%= total %> 원</td>
                        <td>
                            <a href="./deleteCart.jsp?id=<%= product.getProductId() %>" class="btn btn-danger btn-sm">삭제</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">장바구니가 비어있습니다.</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3" class="text-right">총액</th>
                        <td colspan="2">
                            <jsp:include page="cart_pro.jsp"/> <!-- 총액 계산 로직 포함 -->
                        </td>
                    </tr>
                </tfoot>
            </table>

            <!-- 버튼 영역 -->
            <div class="d-flex justify-content-between align-items-center mt-3">
                <a href="deleteCart.jsp?cartId=<%= session.getId() %>" class="btn btn-lg btn-danger">전체삭제</a>
                <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
            </div>
        </div>  
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    <script src="<%= request.getContextPath() %>/static/js/validation.js"></script>
    <!-- Bootstrap JS 및 jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
