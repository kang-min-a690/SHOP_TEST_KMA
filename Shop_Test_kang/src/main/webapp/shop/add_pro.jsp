<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
<%
    // 업로드 경로 설정
    String uploadPath = application.getRealPath("/uploads"); // 업로드할 디렉토리
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 디렉토리가 존재하지 않으면 생성
    }

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

    DiskFileUpload upload = new DiskFileUpload();
    upload.setRepositoryPath(uploadPath);	
    // 파일 업로드 처리
    List<FileItem> items = upload.parseRequest(request);
    Iterator params = items.iterator();
    while( params.hasNext() ) {
        FileItem item = (FileItem) params.next();
        // 일반 데이터
        if ( item.isFormField() ) {
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
            String fileFieldName = item.getFieldName();
            String fileName = item.getName();
            String contentType = item.getContentType();
            
            fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
            long fileSize = item.getSize();
            
            File file = new File(uploadPath + "/" + fileName);
            item.write(file);
            fileUrl = file.getPath().replace("\\", "/");
        }
    }

    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    product.setFile(fileUrl);
    int result = productDAO.insert(product);
    if (result > 0) {
        response.sendRedirect(root + "/shop/products.jsp");
    } else {
        response.sendRedirect(root + "/shop/add.jsp");
    }
%>