package shop.dao;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.x.protobuf.MysqlxExpect.Open.Condition;
import com.mysql.cj.xdevapi.PreparableStatement;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	
	public String table() {
		
		return "product";	//테이블 명
	}
	
	//----------------★ 잘 썼는지 물어보기 ★-------------------
	
	// 상품 정보를 불러오는거! SELECT 사용
	public List<Product> list() {	
		List<Product> productList = new ArrayList<>(); // Product를 담을 그릇 생성
		
		String SQL = "SELECT"			//SQL문 작성 시작!!
				+ " product_id "
				+ " ,unit_price "
				+ " ,manufacturer "
				+ " ,category "
				+ " ,units_in_stock "
				+ " ,quantity FROM "
				+ table();
		
		try  { psmt = con.prepareStatement(SQL);	//SQL에서 가져오기!
			    rs = psmt.executeQuery();			//JDBConne 에서 선언한 rs
			
				//while 문 이용 해서 반복 하기
			while (rs.next()) {					// Int String 구분 잘 하기
				Product product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getInt("units_in_stock"));
				product.setQuantity(rs.getInt("quantity"));
				productList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("상품 목록 조회시 예외 발생..");
			e.printStackTrace();
		} 
		
		return productList; //상품 목록 반환
	}
	
	
	/**
	 * 상품 목록 검색 ok
	 * @param keyword
	 * @return
	 */
	// 전혀 모르겠음..
	public List<Product> list(String keyword) {
		List<Product> productListSearch = new ArrayList<>();
		
		String SQL = " SELECT * FROM product "
				   + " WHERE product_id LIKE CONCAT('%', ? , '%')"
				   + " OR description LIKE CONCAT('%', ? , '%') "
				   + " OR manufacturers Like CONCAT('%', ? , '%') "
				   + " OR category Like CONCAT('%', ? , '%')";
			
				//  각 조건에 대한 키워드를 작성 키워드는 ? 이니까..
		try {	psmt = con.prepareStatement(SQL);
				psmt.setString(1, keyword);
				psmt.setString(2, keyword);
				psmt.setString(3, keyword);
				psmt.setString(4, keyword);
				rs = psmt.executeQuery();
				
				
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				productListSearch.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("상품 목록 검색 중 예외 발생...");
			e.printStackTrace();
		}
		
		return productListSearch;
		
	}
	
	/**
	 * 상품 조회 ok
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		//객체 정보 생성
		Product product = null;
		
		String SQL = " SELECT * FROM " + table()
		           + " WHERE product_id = ? ";		//특정 상품명 조회하려고 ? 씀
		
		try {	psmt = con.prepareStatement(SQL);
				psmt.setString(1, productId );	// 특정 상품명 불러오기
				rs = psmt.executeQuery();
				
				if( rs.next() ) { // Bool 타입으로 리턴 하는 거 
					product = new Product();
					product.setProductId(rs.getString("product_id"));
					product.setName(rs.getString("name"));
					product.setUnitPrice(rs.getInt("unit_price"));
					product.setDescription(rs.getString("description"));
					product.setManufacturer(rs.getString("manufacturer"));
					product.setCategory(rs.getString("category"));
					product.setUnitsInStock(rs.getInt("units_in_stock"));
					product.setCondition(rs.getString("condition"));
					product.setFile(rs.getString("file"));
					product.setQuantity(rs.getInt("quantity"));	
				}	
				
		} catch (Exception e) {
			System.err.println(" 상품 조회 시, 예외 발생");
			e.printStackTrace();
		}
				
		return product;
		
	}
	
	
	/**
	 * 상품 등록 ok
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0; 
		
		String SQL = " INSERT INTO " + table() + " ( "
				   + " product_id "
				   + " ,name "
				   + " ,unit_price "
				   + " ,description "
				   + " ,manufacturer "
				   + " ,category "
				   + " ,units_in_stock "
				   + " ,`condition` " // 예약어라 겹침~~~
				   + " ,file "
				   + " ,quantity ) "
				   + " VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) "
				   ;
		
		try {
			//SQL 시작
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println( table() + " 상품 목록 등록 시 예외 발생... " );
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	/**
	 * 상품 수정 ok
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		
		// Update는 수정할거 ? 넣고, WHERE로 마무리
		String SQL = " UPDATE " + table() +  " SET " 
				   + " product_id = ? "
				   + " ,name = ? "
				   + " ,unit_price = ? "
				   + " ,description = ? "
				   + " ,manufacturer = ? "
				   + " ,category = ? "
				   + " ,units_in_stock = ? "
				   + " ,`condition` = ? "
				   + " ,file = ? "
				   + " ,quantity = ? "
				   + " WHERE product_id  = ? "
				   ; 
		
		try {
			// SQL문 시작 
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());
			psmt.setString(11, product.getProductId()); // where의 product_id를 다시 설정
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println( table() + " 상품 목록 수정 시 예외 발생... " );
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	/**
	 * 상품 삭제 ok
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
	    int result = 0;

	    // DELETE 는 WHERE과 같이 씀
	    // 특정 부분만 삭제 하기
	    String SQL = "DELETE FROM " + table() 
	    		   + " WHERE product_id = ?"
	    		   ;

	    try {
	        psmt = con.prepareStatement(SQL);
	        
	        // productId가 물음표니까 psmt로 1번째 설정
	        psmt.setString(1, productId);
	        
	        // 쿼리 시작
	        result = psmt.executeUpdate();

	    } catch (Exception e) {
	        System.err.println(table() + " 상품 삭제 중 예외 발생... ");
	        e.printStackTrace();
	    }

	    return result;
	}
}






























