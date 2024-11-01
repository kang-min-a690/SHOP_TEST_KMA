package shop.dao;

import java.sql.SQLException;
import java.util.UUID;

import shop.dto.PersistentLogin;
import shop.dto.Product;
import shop.dto.User;

public class UserRepository extends JDBConnection {
	
	
	
	public String table() {
		
		return "user";
	}
	
	/**
	 * 회원 등록
	 * @param user
	 * @return
	 */
	public int insert(User user) {
		int result = 0;	
		String sql = "INSERT INTO " + table() + " ( "
				   + " id "
				   + " ,password "
				   + " ,name "
				   + " ,gender "
				   + " ,birth "
				   + " ,mail "
				   + " ,phone "
				   + " ,address "
				   + " ,regist_day )"
				   + " VALUES( ? , ? , ? , ? , ? , ? , ? , ? , NOW() ) " // reg_date는 현재 날짜
				   ;
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user.getId());
			psmt.setString(2, user.getPassword());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getGender());
			psmt.setString(5, user.getBirth());
			psmt.setString(6, user.getMail());
			psmt.setString(7, user.getPhone());
			psmt.setString(8, user.getAddress());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			// 회원등록시 에외발생 코드
			System.err.println("회원 등록 시, 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 로그인을 위한 사용자 조회 (로그인)
	 * @param id
	 * @param pw
	 * @return
	 */
	public User login(String id, String pw) {
		 User user = null ; // 유저 정보를 담을 user (근데 값이 아직 없어야 하니 null)
		 
		 String SQL = " SELECT * FROM " + table()
		 			+ " WHERE id = ? AND password = ? "	//SQL에 있는 불러올 내용 적기
		 			;
		
		 try {
			 psmt = con.prepareStatement(SQL);
			 psmt.setString(1, id);		// 첫번째 ? 에 값 입력
			 psmt.setString(2, pw);		// 두번째 ? 에 값 입력
			 rs = psmt.executeQuery();
			 
			 
			 if(rs.next()) { // 위에 작성한게 next(JDBConn..그냥 DB 에 있는지 확인)
				 user = new User();	// 뉴 User객체 생성
				 user.setId(rs.getString("id"));
				 user.setPassword(rs.getString("password"));
//				 user.setName(rs.getString("name")) 이건 필요한지 아닌지 모르겠음..ㅜ
			 }
		 } catch (Exception e) {
			 System.err.println("로그인 시 예외 발생...");
			 e.printStackTrace();
		 }
		
		return user;	// user 반환 ( null 일 수도 있음)
	}
	
	
	
	
	/**
	 * 로그인을 위한 사용자 조회 SELECT
	 * @param id
	 * @return
	 */
	public User getUserById(String id) {
		User user = null;
		
		String SQL = " SELECT * FROM " + table()
				   + " WHERE id = ? "; // 회원 아이디는 아직 모르니까 ? 작성
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, id );		// 첫번째 ? 불러오기
			rs = psmt.executeQuery();
			
			if( rs.next() ) {
				user = new User(); // 뉴 User 객체 생성
				user.setId(rs.getString("id"));
			}
			
		}catch (Exception e) {
			System.err.println("사용자 조회시 예외 발생...");
			e.printStackTrace();
		}
		
		return user;
	}
	
	
	/**
	 * 회원 수정
	 * @param user
	 * @return
	 */
	public int update(User user) {
		int result = 0;
		
		// Update 테이블명 SET + -> WHERE  ? 수정할거 넣기
		String SQL = " UPDATE " + table() + " SET "
				   + " password = ? "
				   + " ,name = ? "
				   + " ,gender = ? "
				   + " ,birth = ? "
				   + " ,mail = ? "
				   + " ,phone = ? "
				   + " ,address = ? "
				   + " WHERE id = ? "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, user.getPassword());
			psmt.setString(2, user.getName());
			psmt.setString(3, user.getGender());
			psmt.setString(4, user.getBirth());
			psmt.setString(5, user.getMail());
			psmt.setString(6, user.getPhone());
			psmt.setString(7, user.getAddress());
			psmt.setString(8, user.getId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("회원 정보 수정시 예외 발생...");
			e.printStackTrace();
		}
		
		return result;
	}


	/**
	 * 회원 삭제
	 * @param id
	 * @return
	 */
	public int delete(String id) {
		int result = 0;
		
		//DELETE 작성
		String SQL = " DELETE FROM " + table()
				   + " WHERE id = ? "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, id);
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("회원 삭제 시 예외 발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 토큰 리프레쉬
	 * @param userId
	 */
	public String refreshToken(String userId) {
	    PersistentLogin persistentLogin = selectToken(userId);
	    String token = null;
	    if (persistentLogin == null) {
	        // 토큰이 없는 경우, 삽입
	    	token = insertToken(userId);
	    } else {
	        // 토큰이 있는 경우, 갱신
	    	token =  updateToken(userId);
	    }
	    return token;
	}

	
	
	/**
	 * 토큰 정보 조회
	 * @param userId
	 * @return
	 */
	public PersistentLogin selectToken(String userId) {
	    String sql = "SELECT * FROM persistent_logins WHERE user_id = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	        	persistentLogin = new PersistentLogin();
	        	persistentLogin.setpNo( rs.getInt("p_no")); 
	        	persistentLogin.setUserId( rs.getString("user_id") ); 
	        	persistentLogin.setToken( rs.getString("token") ); 
	        	persistentLogin.setDate( rs.getTimestamp("token") ); 
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}
	
	
	/**
	 * 토큰 정보 조회 - 토큰으로
	 * @param token
	 * @return
	 */
	public PersistentLogin selectTokenByToken(String token) {
	    String sql = "SELECT * FROM persistent_logins WHERE token = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	            persistentLogin = new PersistentLogin();
	            persistentLogin.setpNo(rs.getInt("p_no")); 
	            persistentLogin.setUserId(rs.getString("user_id")); 
	            persistentLogin.setToken(rs.getString("token")); 
	            persistentLogin.setDate(rs.getTimestamp("date")); // date 필드로 변경
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}


	
	
	/**
	 * 자동 로그인 토큰 생성
	 * @param userId
	 * @return
	 */
	public String insertToken(String userId) {
		 int result = 0;
	    String sql = "INSERT INTO persistent_logins (user_id, token) VALUES (?, ?)";
	    String token = UUID.randomUUID().toString();
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);
	        psmt.setString(2, token);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 등록 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 등록 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개가 등록되었습니다.");
	    return token;
	}
	
	/**
	 * 자동 로그인 토큰 갱신
	 * @param userId
	 * @return
	 */
	public String updateToken(String userId) {
	    int result = 0;
	    String sql = "UPDATE persistent_logins SET token = ?, date = now() WHERE user_id = ?";
	    String token = UUID.randomUUID().toString();
	    try {
	    	psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);
	        psmt.setString(2, userId);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 수정 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 수정 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 수정되었습니다.");
	    return token;
	}
	
	
	/**
	 * 토큰 삭제
	 * - 로그아웃 시, 자동 로그인 풀림
	 * @param userId
	 * @return
	 */
	public int deleteToken(String userId) {
	    int result = 0;
	    String sql = "DELETE FROM persistent_logins WHERE user_id = ?";
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        result = psmt.executeUpdate(); // 특정 사용자의 자동 로그인 정보 삭제 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 삭제 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 삭제되었습니다.");
	    return result;
	}


}

















