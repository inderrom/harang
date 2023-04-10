package com.harang.vo;

public class CommentVO {
	
	private int commt_id;
	private int board_id;
	private String mem_id;
	private String mem_nick;
	private String commt_content;
	private String commt_date;
	private int target_id;
	private int depth;
	
	// 댓글 테이블 종류
	private String commt_type;
	
	
	public int getCommt_id() {
		return commt_id;
	}
	public void setCommt_id(int commt_id) {
		this.commt_id = commt_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getCommt_content() {
		return commt_content;
	}
	public void setCommt_content(String commt_content) {
		this.commt_content = commt_content;
	}
	public String getCommt_date() {
		return commt_date;
	}
	public void setCommt_date(String commt_date) {
		this.commt_date = commt_date;
	}
	public int getTarget_id() {
		return target_id;
	}
	public void setTarget_id(int target_id) {
		this.target_id = target_id;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getCommt_type() {
		return commt_type;
	}
	public void setCommt_type(String commt_type) {
		this.commt_type = commt_type;
	}
}
