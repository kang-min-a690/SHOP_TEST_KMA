package shop.dao;

import java.sql.SQLException;
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
	
	public int insert(Product product) {
		
		int result = 0; //초기화
		
		String SQL = " INSERT INTO " + table() + " ( "
				   + " product_id "
				   + " ,order_no "
				   + " ,amount "
				   + " ,type "
				   + " ,io_date "
				   + " ,user_id ) "
				   + " VALUES( ? , ? , ? , ? , DEFAULT , ? ) "
				   ;
		
		try {
			
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setInt(3, product.getQuantity());	// amount랑 같은 뜻
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
	

}