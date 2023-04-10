package com.harang.vo;

public class ParkVO {
	private String park_name;
	private String airport_id;
	private String airport_name;
	private String park_max;
	private String park_fee;
	private String park_file;
	
	public String getPark_name() {
		return park_name;
	}
	public String getAirport_name() {
		return airport_name;
	}
	public void setAirport_name(String airport_name) {
		this.airport_name = airport_name;
	}
	public void setPark_name(String park_name) {
		this.park_name = park_name;
	}
	public String getAirport_id() {
		return airport_id;
	}
	public void setAirport_id(String airport_id) {
		this.airport_id = airport_id;
	}
	public String getPark_max() {
		return park_max;
	}
	public void setPark_max(String park_max) {
		this.park_max = park_max;
	}
	public String getPark_fee() {
		return park_fee;
	}
	public void setPark_fee(String park_fee) {
		this.park_fee = park_fee;
	}
	public String getPark_file() {
		return park_file;
	}
	public void setPark_file(String park_file) {
		this.park_file = park_file;
	}
}
