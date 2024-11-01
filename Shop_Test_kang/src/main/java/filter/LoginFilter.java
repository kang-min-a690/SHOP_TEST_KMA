package filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/*") // 모든 요청에 대해 필터 적용
public class LoginFilter extends HttpFilter implements Filter {
	
	private UserRepository userRepository;

	public void init(FilterConfig fConfig) throws ServletException {
		userRepository = new UserRepository();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
	
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = "";		// 자동 로그인 여부
		String token = "";			// 인증 토큰
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
				if ("rememberMe".equals(cookieName)) {
					rememberMe = cookieValue;
				} else if ("token".equals(cookieName)) {
					token = cookieValue;
				}
			}
		}
		
		System.out.println("LoginFilter...");
		System.out.println("rememberMe : " + rememberMe);
		System.out.println("token : " + token);
		
		// 세션에서 loginUser 가져오기
		HttpSession session = httpRequest.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 로그인이 되어 있는 경우
		if (loginUser != null) {
			chain.doFilter(httpRequest, response);
			System.out.println("로그인된 사용자 : " + loginUser.getName());
			return;
		}
		
		// 쿠키 정보 "rememberMe", "token" 가 모두 존재하는 경우, 자동 로그인
		if (!rememberMe.isEmpty() && !token.isEmpty()) {
			PersistentLogin persistentLogins = userRepository.selectTokenByToken(token);
			
			if (persistentLogins != null) {
				String loginId = persistentLogins.getUserId();
				loginUser = userRepository.getUserById(loginId);
				
				if (loginUser != null) {
					session.setAttribute("loginId", loginId);
					session.setAttribute("loginUser", loginUser);
					System.out.println("자동 로그인 성공 : " + loginUser);
				}
			}
		}
		
		chain.doFilter(request, response);
	} 
	
	public void destroy () {

	
	}
}
