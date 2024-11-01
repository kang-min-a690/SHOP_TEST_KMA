package shop.service;

import shop.dao.UserRepository;
import shop.dto.User;
import utils.PasswordUtils;

public class UserServiceImpl implements UserService {
    
    private UserRepository userDAO = new UserRepository();
    
    @Override
    public int signup(User user) {
        // 비밀번호 암호화
        String encodedPassword = PasswordUtils.encoded(user.getPassword());
        user.setPassword(encodedPassword);
        
        int result = userDAO.insert(user);
        if (result > 0) {
            System.out.println("회원가입 성공");
        } else {
            System.out.println("회원가입 실패");
        }
    
        return result;
    }
    
    @Override
    public User login(User user) {
        String id = user.getId();  // 아이디를 사용하도록 수정
        User selectedUser = userDAO.getUserById(id);
        
        // 회원 가입이 안된 아이디
        if (selectedUser == null) {
            System.out.println("해당 아이디는 등록되지 않았습니다.");
            return null;
        }
        
        // 비밀번호 일치 여부 확인
        String password = selectedUser.getPassword();
        String loginPassword = user.getPassword();
        
        // BCrypt.checkpw (로그인 비밀번호, 암호화된 비밀번호);
        boolean check = PasswordUtils.check(loginPassword, password);
        
        // 비밀번호 불일치
        if (!check) {
            System.out.println("비밀번호가 일치하지 않습니다.");
            return null;
        }
        
        // 로그인 성공
        System.out.println("로그인 성공");
        return selectedUser;
    }

    @Override
    public User select(String id) {
        User user = userDAO.getUserById(id);
        return user;
    }

	@Override
	public User select(int no) {
		// TODO Auto-generated method stub
		return null;
	}

}
