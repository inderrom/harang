package com.harang.util;

import java.io.Reader;
import java.nio.charset.Charset;

import com.ibatis.common.resources.Resources;

public class TicketMailFormLoader {

	private static String ticketMailForm = "";
	private static Reader rd;
	
	static {
		
		try {
			
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			
			rd = Resources.getResourceAsReader("com/harang/util/settings/ticketMailForm.html");
			
			char[] buf = new char[512];
			int len;
			
			while((len = rd.read(buf)) > 0) {
				ticketMailForm += String.valueOf(buf).substring(0, len);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getTicketMailForm() {
		return ticketMailForm;
	}
}
