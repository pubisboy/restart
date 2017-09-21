package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		String auth = (String)session.getAttribute("auth");
		if(auth != null){
			chain.doFilter(req, resp);
		}else{
			String uri = req.getRequestURI();
			System.out.println("uri : "+uri);
<<<<<<< HEAD
			if(uri.startsWith("/member/join") || uri.startsWith("/member/check") || uri.startsWith("/member/login_rst")){ 
				chain.doFilter(req, resp); 
=======
			if(uri.startsWith("/member/join") || uri.startsWith("/member/joinajax.j") || uri.startsWith("/member/check") || uri.startsWith("/member/emailaccredit") ||  uri.startsWith("/member/result") || uri.startsWith("/member/login_rst")){ 
				chain.doFilter(req, resp);
>>>>>>> branch 'ukiki2' of https://github.com/pubisboy/restart.git
			}else{
				session.setAttribute("goLogin", "goLogin");
				req.setAttribute("goLogin", "goLogin");
				resp.sendRedirect("/?goLogin=goLogin");
			}
		}
	}

}
