package com.harang.vo;

public class FlightVO {
	
	private String fli_id;
	private String airline_id;
	private String airline_name;
	private String fli_depport;
	private String fli_arrport;
	private String fli_deptime;
	private String fli_arrtime;
	private int fli_price;
	private String fli_dayofweek;
	
	private String date; // 예약한 출발날짜
	private int count; // 탑승객 인원
	
	
	public String getFli_id() {
		return fli_id;
	}
	public void setFli_id(String fli_id) {
		this.fli_id = fli_id;
	}
	public String getAirline_id() {
		return airline_id;
	}
	public void setAirline_id(String airline_id) {
		this.airline_id = airline_id;
	}
	public String getAirline_name() {
		return airline_name;
	}
	public void setAirline_name(String airline_name) {
		this.airline_name = airline_name;
	}
	public String getFli_depport() {
		return fli_depport;
	}
	public void setFli_depport(String fli_depport) {
		this.fli_depport = fli_depport;
	}
	public String getFli_arrport() {
		return fli_arrport;
	}
	public void setFli_arrport(String fli_arrport) {
		this.fli_arrport = fli_arrport;
	}
	public String getFli_deptime() {
		return fli_deptime;
	}
	public void setFli_deptime(String fli_deptime) {
		this.fli_deptime = fli_deptime;
	}
	public String getFli_arrtime() {
		return fli_arrtime;
	}
	public void setFli_arrtime(String fli_arrtime) {
		this.fli_arrtime = fli_arrtime;
	}
	public int getFli_price() {
		return fli_price;
	}
	public void setFli_price(int fli_price) {
		this.fli_price = fli_price;
	}
	public String getFli_dayofweek() {
		return fli_dayofweek;
	}
	public void setFli_dayofweek(String fli_dayofweek) {
		this.fli_dayofweek = fli_dayofweek;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
