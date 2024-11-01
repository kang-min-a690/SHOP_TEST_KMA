package shop.service;

import shop.dto.User;

public interface UserService {
	
	//회원가입
	public int signup(User user);
	
	//로그인
	public User login(User user);
	
	//회원 조회 (번호)
	public User select(int no);
	
	//회원 조회 (아이디)
	public User select(String id);

}
