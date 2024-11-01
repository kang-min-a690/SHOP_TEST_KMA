package filter;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shop.dto.PersistentLogin;
import shop.dto.User;
import shop.service.PersistentLoginService;
import shop.service.PersistentLoginServiceImpl;
import shop.service.UserService;
import shop.service.UserServiceImpl;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(description = "자동 로그인 등, 인증 처리 필터", urlPatterns = {"/*"})
public class LoginFilter extends HttpFilter implements Filter {
	
	PersistentLoginService loginService;
	UserService userservice;
	
	public void LoginFilter() {
		
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		loginService = new PersistentLoginServiceImpl();
		userservice = new UserServiceImpl();
	}

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//쿠키 확인
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = null;	// 자동 로그인 여부
		String token = null;		// 인증 토큰
		
		if( cookies != null ) {
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookievalue = URLDecoder.decode( cookie.getValue(),"UTF-8");
				switch (cookieName) {
					case "rememberMe"	: rememberMe = cookievalue; break;
					case "token"	: token = cookievalue; break;
				}
			}
		}
		//로그인여부 확인
		HttpSession session = httpRequest.getSession();
		String loginID = (String) session.getAttribute("loginID");
		User loginUser = (User) session.getAttribute("loginUser");
		System.out.println("Loginfilter...");	
		System.out.println("rememberMe :" + rememberMe);
		System.out.println("token : " + token);
		
		//이미 로그인이 됨
		if( loginID != null && loginUser != null ) {
			chain.doFilter(request, response);
			System.out.println("로그인 된 사용자 : " + loginID);
			return;
		}
		//자동 로그인, 토큰 확인했을 경우
		if( rememberMe != null && token != null ) {
			// DTO PersistentLogin에서 토큰 조회 객체 생성
			PersistentLogin plogin = loginService.selectByToken(token);
			
			//토큰이 존재하고 유효한지 확인
			if( plogin != null && loginService.isValid(token) ) {
				int userNo= plogin.getpNo();
				loginUser = userservice.select(userNo);
				
				session.setAttribute("loginID", loginUser.getId());
				session.setAttribute("loginUser", loginUser );
			}
		}
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		
	}
	
	
	
	
	
}
