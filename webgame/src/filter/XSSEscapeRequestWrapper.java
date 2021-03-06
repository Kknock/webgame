package filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class XSSEscapeRequestWrapper extends HttpServletRequestWrapper {
	
	public XSSEscapeRequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);
	}
 
	public String[] getParameterValues(String parameter) {
 
		String[] values = super.getParameterValues(parameter);
		if (values==null)  {
			return null;
		}
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++) {
			encodedValues[i] = cleanXSS(values[i]);
		}
		return encodedValues;
	}
 
	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
		if (value == null) {
			return null;
		}
		return cleanXSS(value);
	}
 
	public String getHeader(String name) {
		String value = super.getHeader(name);
		if (value == null)
			return null;
		return cleanXSS(value);
	}
 
	private String cleanXSS(String value) {
		//You'll need to remove the spaces from the html entities below
		value = value.replaceAll("<s", "&lt;s").replaceAll("t>", "t&gt;");
		value = value.replaceAll("<S", "&lt;s").replaceAll("T>", "t&gt;");
		value = value.replaceAll("</s", "&lt;s").replaceAll("</S", "&lt;S");
		
		//value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
		//value = value.replaceAll("'", "& #39;");
		value = value.replaceAll("\n", "</br>");
		value = value.replaceAll("eval\\((.*)\\)", "");
		//value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		//value = value.replaceAll("script", "");
		return value;
	}
}