package com.example.spring02.model.board.dto;

import java.util.Arrays;

public class BoardDTO {
	private int bno;
	private String title;
	private String content;
	private String writer; // 작성자 id
	private String user_name;
	//private Date regdate;
	private String regdate;
	private int viewcnt;
	private int cnt; // 댓글 개수
	private String[] files;
	private String[] fileSize;
	private String notice;
	
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public String[] getFileSize() {
		return fileSize;
	}
	public void setFileSize(String[] fileSize) {
		this.fileSize = fileSize;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", user_name=" + user_name + ", regdate=" + regdate + ", viewcnt=" + viewcnt + ", cnt=" + cnt
				+ ", files=" + Arrays.toString(files) + ", fileSize=" + Arrays.toString(fileSize) + ", notice=" + notice
				+ "]";
	}
}
