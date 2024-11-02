<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"> 
    <title>장바구니</title>
    <jsp:include page="/layout/meta.jsp"/>
    <jsp:include page="/layout/link.jsp"/>
    <link rel="stylesheet" href="static/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/layout/header.jsp"/>
    
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">장바구니 목록입니다.</p>
        </div>

        <div class="container order">
            <table class="table table-striped table-hover table-bordered text-center align-middle">
                <thead class="thead-light">
                    <tr class="table-primary">
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
                            int total = product.getUnitPrice() * product.getQuantity();
                    %>
                    <tr>
                        <td><%= product.getProductId() %> - <%= product.getName() %></td>
                        <td><%= product.getUnitPrice() %> 원</td>
                        <td><%= product.getQuantity() %></td>
                        <td><%= total %> 원</td>
                        <td>
                            <!-- 삭제 버튼이 deleteCart.jsp로 이동 -->
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
                <%
                if (cartList != null && !cartList.isEmpty()) {
                %>
                <tfoot>
                    <tr>
                        <th colspan="3" class="text-right">총액</th>
                        <td colspan="2">
                            <jsp:include page="cart_pro.jsp"/>
                        </td>
                    </tr>
                </tfoot>
                <%
                }
                %>
            </table>

            <div class="d-flex justify-content-between align-items-center mt-3">
                <a href="deleteCart.jsp?cartId=<%= session.getId() %>" class="btn btn-lg btn-danger">전체삭제</a>
                <a href="javascript:void(0);" class="btn btn-lg btn-primary" onclick="checkCart()">주문하기</a>
            </div>
        </div>  
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    <script src="<%= request.getContextPath() %>/static/js/validation.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function checkCart() {
            var cartList = <%= cartList != null ? cartList.size() : 0 %>;
            if (cartList <= 0) {
                alert("장바구니에 담긴 상품이 없습니다.");
            } else {
                window.location.href = "shop/ship.jsp?cartId=<%= session.getId() %>";
            }
        }
    </script>
</body>
</html>
