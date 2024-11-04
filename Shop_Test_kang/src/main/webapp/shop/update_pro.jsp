<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
<%
    request.setCharacterEncoding("UTF-8"); // 문자 인코딩 설정	

    Product product = new Product();
    String productId = "";
    String name = "";
    int unitPrice = 0;
    String description = "";
    String manufacturer = "";
    String category = "";
    int unitsInStock = 0;
    String condition = "";
    String fileUrl = "";

    String path = application.getRealPath("/upload"); // 파일 업로드 경로 설정
    File uploadDir = new File(path);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 경로가 없으면 생성
    }

    // ServletFileUpload 객체 생성
    ServletFileUpload upload = new ServletFileUpload();

    // 파일 업로드 처리
    try {
        List<FileItem> items = upload.parseRequest(request);
        Iterator<FileItem> params = items.iterator();

        while (params.hasNext()) {
            FileItem item = params.next();
            // 일반 데이터
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String value = item.getString("utf-8");
                switch (fieldName) {
                    case "productId":
                        productId = value;
                        break;
                    case "name":
                        name = value;
                        break;
                    case "unitPrice":
                        unitPrice = Integer.parseInt(value);
                        break;
                    case "description":
                        description = value;
                        break;
                    case "manufacturer":
                        manufacturer = value;
                        break;
                    case "category":
                        category = value;
                        break;
                    case "unitsInStock":
                        unitsInStock = Integer.parseInt(value);
                        break;
                    case "condition":
                        condition = value;
                        break;
                }
            }
            // 파일 데이터
            else {
                if (item.getName().length() > 0) {
                    String fileName = item.getName();
                    // 파일 이름에서 경로 제거
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    long fileSize = item.getSize();

                    File file = new File(path + "/" + fileName);
                    try {
                        item.write(file);
                    } catch (Exception e) {
                        out.println("<script>alert('파일 업로드에 실패했습니다.'); window.history.back();</script>");
                        return;
                    }
                    fileUrl = file.getPath().replace("\\", "/");
                }
            }
        }

        // 제품 정보를 업데이트
        product = productDAO.getProductById(productId);
        if (product != null) { // 제품이 존재하는지 확인
            product.setProductId(productId);
            product.setName(name);
            product.setUnitPrice(unitPrice);
            product.setDescription(description);
            product.setManufacturer(manufacturer);
            product.setCategory(category);
            product.setUnitsInStock(unitsInStock);
            product.setCondition(condition);

            if (fileUrl.length() > 0)
                product.setFile(fileUrl);

            int result = productDAO.update(product);
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/shop/products.jsp"); // 리다이렉션 경로 수정
            } else {
                response.sendRedirect(request.getContextPath() + "/shop/update.jsp?id=" + productId);
            }
        } else {
            // 제품이 존재하지 않는 경우 처리
            out.println("<script>alert('상품이 존재하지 않습니다.'); window.location.href='products.jsp';</script>");
        }
    } catch (FileUploadException e) {
        out.println("<script>alert('파일 업로드 중 오류가 발생했습니다.'); window.history.back();</script>");
    }
%>
