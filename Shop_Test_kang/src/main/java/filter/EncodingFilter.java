package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter {
	
	
	// 초기 파라미터
	private String encoding;
	
	@Override
	public void destroy() {
		// 필터객체 제거할때 실행 메소드
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
				System.out.println("EncodingFilter doFilter 실행중");
				
				// 인코딩이 설정 되지 않았다면~
				if(request.getCharacterEncoding()== null) {
					//인코딩 설정하기 (web.xml 에 클래스명)
					request.setCharacterEncoding("UTF-8");
				}
				
				// doFilter 계속하기
				chain.doFilter(request, response);
		
	} 


	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// web.xml에 인코딩 -> UTF-8 문자열 불러오기
		encoding = filterConfig.getInitParameter("encoding");
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



	
}







