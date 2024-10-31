package filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.dto.PersistentLogin;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(description = "자동 로그인 등, 인증 처리 필터", urlPatterns = {"/*"})
public class LoginFilter extends HttpFilter implements Filter {
	
	PersistentLogi서비스객체 생성
	
	
	@Override
	public void init() throws ServletException {
		//
		super.init();
	}
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}
	
	@Override
	protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		super.doFilter(req, res, chain);
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		super.doFilter(req, res, chain);
	}
	

	@Override
	public FilterConfig getFilterConfig() {
		// TODO Auto-generated method stub
		return super.getFilterConfig();
	}

	@Override
	public String getFilterName() {
		// TODO Auto-generated method stub
		return super.getFilterName();
	}

	@Override
	public String getInitParameter(String name) {
		// TODO Auto-generated method stub
		return super.getInitParameter(name);
	}

	@Override
	public Enumeration<String> getInitParameterNames() {
		// TODO Auto-generated method stub
		return super.getInitParameterNames();
	}

	@Override
	public ServletContext getServletContext() {
		// TODO Auto-generated method stub
		return super.getServletContext();
	}


	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return super.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		return super.equals(obj);
	}

	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}

	@Override
	protected void finalize() throws Throwable {
		// TODO Auto-generated method stub
		super.finalize();
	}

	
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}

	
}
