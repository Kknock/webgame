package filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinFilter implements Filter {
	
	Pattern regex;

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		regex = Pattern.compile("^[a-zA-Z0-9_°¡-ÆR]+$");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		String value;
		
		JoinRequestWrapper requestWrapper = new JoinRequestWrapper((HttpServletRequest)request);
		
		Enumeration<String> header_names = requestWrapper.getHeaderNames();
		Enumeration<String> param_names = requestWrapper.getParameterNames();
		
		while( header_names.hasMoreElements() ) {
			String name = header_names.nextElement();
			Enumeration<String> header = requestWrapper.getHeaders(name);
			
			if(header == null ) continue;
			
			while( header.hasMoreElements() ) {
				value = header.nextElement();
				if ( this.check_malice(value) ) {
					break;
					//System.out.println("val: " + value);
					//System.out.println("Bye :)");
					//((HttpServletResponse)response).sendRedirect("index.jsp");
					//return ;
				}
			}
		}
		
		while( param_names.hasMoreElements() ) {
			String name = param_names.nextElement();
			String[] params = requestWrapper.getParameterValues(name);
			
			for(int i=0; i<params.length; i++) {
				if( params[i] == null)
					continue;
				if ( (name.equals("id") || name.equals("name")) && this.check_malice(params[i]) ) {
					((HttpServletResponse)response).sendRedirect("index.jsp");
					return ;
				}
			}	
		}
		chain.doFilter(request, response);
	}
	
	// Çã¿ëµÇÁö ¾ÊÀº ¹®ÀÚ¿­ÀÌ ¹ß°ßµÇ¸é True¸¦ ¹ÝÈ¯ÇÑ´Ù.
	public boolean check_malice(String value) {
		Matcher matcher;
		matcher = this.regex.matcher(value);
		return !matcher.find();
	}
}
