package filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.sun.org.apache.xpath.internal.operations.Bool;

public class JoinRequestWrapper extends HttpServletRequestWrapper {
	
	public JoinRequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);
	}
 
	public String[] getParameterValues(String parameter) {
 
		String[] values = super.getParameterValues(parameter);
		boolean flag = false;
		
		if (values==null)  {
			return null;
		}
				
		int count = values.length;
		for (int i = 0; i < count && flag == false; i++) {
			flag = check_malice(values[i]);
		}
		if (flag) {
			// set redirection
		}
		return values;
	}
 
	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
		boolean flag = false;
		
		if (value == null) {
			return null;
		}
		flag = check_malice(value);
		if (flag) {
			// set redirection
		}
		return value;
	}
 
	public String getHeader(String name) {
		String value = super.getHeader(name);
		boolean flag = false;
		
		if (value == null)
			return null;
		
		flag = check_malice(value);
		if (flag) {
			// set redirection
		}
		return value;
	}
 
	private String cleanXSS(String v) {
		return v;
	}
	
	public boolean check_malice(String value) {
		//You'll need to remove the spaces from the html entities below
		
		value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
		value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
		value = value.replaceAll("'", "& #39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		System.out.println(value);
		return true;
	}
}