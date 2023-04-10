package com.harang.vo;

public class TicketVO {
	
	private String ticket_id;
	private String fli_id;
	private String mem_id;
	private String ticket_date;
	
	private int adult; // 어른 탑승객 수
	private int child; // 미성년자 탑승객 수
	private String airline_name; // 항공사명
	
	private int start; // 페이지에서 첫번째 게시물 번호
	private int end; // 페이지에서 마지막 게시물 번호
	
	public String getTicket_id() {
		return ticket_id;
	}
	public void setTicket_id(String ticket_id) {
		this.ticket_id = ticket_id;
	}
	public String getFli_id() {
		return fli_id;
	}
	public void setFli_id(String fli_id) {
		this.fli_id = fli_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getTicket_date() {
		return ticket_date;
	}
	public void setTicket_date(String ticket_date) {
		this.ticket_date = ticket_date;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public String getAirline_name() {
		return airline_name;
	}
	public void setAirline_name(String airline_name) {
		this.airline_name = airline_name;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
}
