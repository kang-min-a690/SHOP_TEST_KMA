package utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {
	
	//Bcrypt 암호화 알고리즘으로 암호화
	public static String encoded(String password) {
		// SALT : 임의의 데이터, 암호화 결과를 달라지게 하는 임의의 데이터 
		return BCrypt.hashpw(password, BCrypt.gensalt());
		// BCrypt : class 명
	}	
	
	// 비밀번호 검증
	public static boolean check(String password, String encodedPassword) {
		return BCrypt.checkpw(password, encodedPassword);
		// checkpw : pw 체크하는 메소드 
	}

}
