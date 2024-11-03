<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보</title>
    <jsp:include page="/layout/meta.jsp"/>
    <jsp:include page="/layout/link.jsp"/>
    <link rel="stylesheet" href="static/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">주문정보</h1>
        <form action="~/shop/complete.jsp" method="post">
            <div class="mb-3">
                <label for="orderType" class="form-label">주문 형태</label>
                <input type="text" class="form-control" id="orderType" name="orderType" value="${orderType}" readonly>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">성명</label>
                <input type="text" class="form-control" id="name" name="name" value="${name}" readonly>
            </div>
            <div class="mb-3">
                <label for="zipcode" class="form-label">우편번호</label>
                <input type="text" class="form-control" id="zipcode" name="zipcode" value="${zipcode}" readonly>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">주소</label>
                <input type="text" class="form-control" id="address" name="address" value="${address}" readonly>
            </div>
            <div class="mb-3">
                <label for="deliveryDate" class="form-label">배송일</label>
                <input type="text" class="form-control" id="deliveryDate" name="deliveryDate" value="${deliveryDate}" readonly>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${phone}" readonly>
            </div>

            <c:if test="${orderType == '비회원'}">
                <div class="mb-3">
                    <label for="orderPw" class="form-label">주문 비밀번호</label>
                    <input type="password" class="form-control" id="orderPw" name="orderPw" required>
                </div>
            </c:if>

            <div class="d-flex justify-content-between">
                <a href="javascript:history.back()" class="btn btn-secondary">이전</a>
                <a href=http://localhost:8080/Shop_Test_kang/index.jsp class="btn btn-danger">취소</a>
                <button type="submit" class="btn btn-success">주문완료</button>
            </div>
        </form>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
