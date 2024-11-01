package shop.dao;

import java.security.PublicKey;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록 ok
	 * @param user
	 * @return
	 */
	// 테이블 명 반환 메소드
	// SQL 작성시 가독성을 높이기 위해
	
	
	// 메소드 선언
	// public : 전역
	// String : 문자열 객체 ( 반환 값이자 반화 객체형식 -> retuen 할떄 똑같은 형식으로 해줘야함)
	// table() : 메소드 명
	public String table() {
		// " " 이걸로 감싸면 문자열
		return "`order`"; // `` 겹치니까 필수
	}
	
	public int insert(Order order) { 
		int result = 0; // 반환할 변수 선언
		
		String SQL = "INSERT INTO " + table() + " ( "			//SQL 작성문
				   + " ship_name "
				   + " ,zip_code "
				   + " ,country "
				   + " ,address "
				   + " ,date "
				   + " ,order_pw "
				   + " ,user_id "
				   + " ,total_price "
				   + " ,phone ) "
				   + " VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? ) " // 테이블 명 만큼 ? 작성
				   ;
		
		// try ~ catch 문
		// try 안에서 실행한 결과가 오류(Exception:예외처리) 발생시 catch 부분에 선언한 실행문이 실행된다
		try {
			
			psmt = con.prepareStatement(SQL);				// psmt : preparedStatement 객체
			psmt.setString(1, order.getShipName());			// ? 에 순서 대로 변수 대입
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());
			psmt.setString(6, order.getOrderPw());
			psmt.setString(7, order.getUserId());
			psmt.setInt(8, order.getTotalPrice());
			psmt.setString(9, order.getPhone());
			
			result = psmt.executeUpdate(); // Update는 0,1로만 결과값,  result 변수에 쿼리 실행 결과값 입력
			
			// 0 : 실패
			// 0 > : 성공
			
		} catch (Exception e) {
			System.err.println( table() + "테이블에 insert시 에러발생.. ");	// 실행중 오류 발생시 출력문
			e.printStackTrace();										// 잔체 에러 구문
		}
		
		return result;	// 결과 값 반환
	}

	/**
	 * 최근 등록한 orderNo OK
	 * @return
	 */
	// SELECT 
	// MAX() 함수 사용
	// : 해당값 보통 int 의 최댓값을 불러 온다
	// 그리고 보통 "SELECT MAX ( user_id ) as max_no FROM" + 테이블명
	//					- as : 변수명 짓는거랑 같다 -> 임의로 작명하는 거다 내마음대로~
	// getUserId -> max_no 로 이름을 바꿔서 -> getMaxNo 해야 나온다..
	// int max = SELECT MAX (user_id) as max_no FROM 테이블 명
	// max = 100
	public int lastOrderNo(Order order) {
		int result = 0;
		
		String SQL = " SELECT MAX ( order_no ) as max_no FROM " + table() + " ( "
				   + " ) "
				   ;
		
		try {
			stmt = con.createStatement();	// ? 가 없을때 쓰는 stmt , 뒤 creat...는 짝꿍
			rs = stmt.executeQuery(SQL);	// SQL을 실행시켜라, 앞으로 rs로 쓸거니까
			result = rs.getInt("max_no");  // 쿼리문을 배경으로 최대값을 resurt로 
			
		} catch (Exception e) {
			System.err.println("마지막 주문 조회시 예외 발생..");
			e.printStackTrace();
		}
		
		return result;
	}
		
	
	/**
	 * 주문 내역 조회 - 회원 ok
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> userOrderList = new ArrayList<>(); //배열 생성
		
		String SQL = " SELECT o.order_no "
			       + " ,p.name "
			       + " ,p.unit_price "
			       + " ,io.amount "
			       + " FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
			                      + " JOIN product p ON io.product_id = p.product_id "
			       + " WHERE o.user_id = ? "; // 아직 회원이 누군지 모르니까 ? 작성
			
		
		try {	psmt = con.prepareStatement(SQL);
				psmt.setString(1, userId);
				rs = psmt.executeQuery(); // rs으로 설정한 SQL 실행 하겠다.
				
			while (rs.next()) {	// Bool 타입으로 리턴되는 값
				Product product = new Product();	 //product.java에도 있는내용
				product.setOrderNo(rs.getInt("order_no")); // 주문번호
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setQuantity(rs.getInt("amount"));	//양
				userOrderList.add(product);
			}
				
		} catch (Exception e) {
			System.err.println("주문 내역 조회 시 예외 발생...");
			e.printStackTrace();
		}
		
		return userOrderList;

	}
	
	/**
	 * 주문 내역 조회 - 비회원 ok
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> nonUserOrderList = new ArrayList<>(); // 비회원 그릇 제작
		// 이름이 괜찮은지 잘모르겠음 .. 너무긴가 싶기도 하고
		
		
		String SQL = " SELECT o.order_no "
			       + " ,p.name "
			       + " ,p.unit_price "
			       + " ,io.amount "
			       + " FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
			                      + " JOIN product p ON io.product_id = p.product_id "
				   + " WHERE o.phone = ? AND o.order_pw = ? ";
		
		// 비회원이니까 WHERE은 폰번호, 패스워드 입력 요청
		
		try {	psmt = con.prepareStatement(SQL);
				psmt.setString(1, phone);
				psmt.setString(2, orderPw);
				rs = psmt.executeQuery(); // rs으로 설정한 SQL 실행 하겠다.
				
			while (rs.next()) {	// Bool 타입으로 리턴되는 값
				Product product = new Product();	 //product.java에도 있는내용
				product.setOrderNo(rs.getInt("order_no"));	//상품 아이디가 필요한가??
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setQuantity(rs.getInt("amount"));
				nonUserOrderList.add(product);
			}
				
		} catch (Exception e) {
			System.err.println("주문 내역 조회 시 예외 발생...");
			e.printStackTrace();
		}
		
		return nonUserOrderList;

	}
		
	
}






























