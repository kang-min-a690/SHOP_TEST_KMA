package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {
	
	//C.R.U.D 
	// Create 생성
	// Read 조회
	// Update 수정
	// Delete 삭제
	// SQL에서 ctrl + F (Find 찾기) **잊지말자
	
	
	/**
	 * 상품 입출고 등록 ok
	 * @param product
	 * @param type
	 * @return
	 */
	public String table() {
		
		return "product_io";	//테이블 명 반환
	}
	
	public int insert(Product product) { // dto 프로덕트
		
		int result = 0; //초기화
		
		String SQL = " INSERT INTO " + table() + " ( "
				   + " product_id "
				   + " ,order_no "
				   + " ,amount "
				   + " ,type "
				   + " ,io_date "
				   + " ,user_id ) "
				   + " VALUES( ? , ? , ? , ? , NOW() , ? ) "
				   ;
		
		try {
			
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setInt(3, product.getAmount());	
			psmt.setString(4, product.getType());
			psmt.setString(5, product.getUserId());
			// io_date 는 값이 없고 현재시간이 들어갈 거라 객체로 안 불러와도 됨
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("상품 입 출고 등록시 예외 발생...");
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * Read
	 * 상품 입출고 조회
	 * @return
	 */
	public List<Product> read(Product product) {
		List<Product> productList = new ArrayList<>();
		String SQL = " SELECT * FROM " + table();
		
		if(product.getUserId() != null) {
			SQL += " WHERE user_id = ? ";
		}
		else if(product.getProductId() != null) {
			SQL += " WHERE product_id = ? ";
		}
		else if(product.getOrderNo() > 0) {
			SQL += " WHERE order_no = ? ";
		}
		
		try {	
				psmt = con.prepareStatement(SQL);
				if(product.getUserId() != null) {
					psmt.setString(1, product.getUserId());
				}
				else if(product.getProductId() != null) {
					psmt.setString(1, product.getProductId());
				}
				else if(product.getOrderNo() > 0) {
					psmt.setInt(1, product.getOrderNo());
				}
				rs = psmt.executeQuery();
				
				
			while (rs.next()) {
				Product pro = new Product();
				pro.setProductId(rs.getString("product_id"));
				pro.setDescription(rs.getString("description"));
				pro.setManufacturer(rs.getString("manufacturer"));
				pro.setCategory(rs.getString("category"));
				productList.add(pro);
			}
			
		} catch (Exception e) {
			System.err.println("상품 목록 검색 중 예외 발생...");
			e.printStackTrace();
		}
		
		return productList;
	}
	

	/**
	 * 입 출고 상품 수정 
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		
		String SQL = " UPDATE " + table() + " "         
				   + " SET amount = ?, type = ? "
				   + " WHERE product_id = ? AND order_no = ? "
				   ;
		
		try {	
				psmt = con.prepareStatement(SQL);
				psmt.setInt(1, product.getAmount());
				psmt.setString(2, product.getType());
				psmt.setString(3, product.getProductId());
				psmt.setInt(4, product.getOrderNo());
				
				result = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.err.println("상품 목록 수정 시 예외 발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	/**
	 * 입출고 삭제
	 * @param product
	 * @return
	 */
	public int delete(Product product) {
		int result = 0;
		
		String SQL = " DELETE FROM " + table()         
				   + " WHERE product_id = ? AND order_no = ? "
				   ;
		
		try {	
				psmt = con.prepareStatement(SQL);
				psmt.setString(3, product.getProductId());
				psmt.setInt(4, product.getOrderNo());
				
				result = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.err.println("상품 목록 삭제 시 예외 발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	
	

}