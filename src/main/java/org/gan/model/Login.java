package org.gan.model;

import java.util.Date;

public class Login {
	
	private int loginid;
	private int sno;
	private String account;
	private String passwd;
	private String recorder;
	private Date recordtime;
	private Date modifytime;
	private char freezeflag;
	
	public int getLoginid() {
		return loginid;
	}
	public void setLoginid(int loginid) {
		this.loginid = loginid;
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getRecorder() {
		return recorder;
	}
	public void setRecorder(String recorder) {
		this.recorder = recorder;
	}
	public Date getRecordtime() {
		return recordtime;
	}
	public void setRecordtime(Date recordtime) {
		this.recordtime = recordtime;
	}
	public Date getModifytime() {
		return modifytime;
	}
	public void setModifytime(Date modifytime) {
		this.modifytime = modifytime;
	}
	public char getFreezeflag() {
		return freezeflag;
	}
	public void setFreezeflag(char freezeflag) {
		this.freezeflag = freezeflag;
	}
	
	@Override
	public String toString() {
		return "Login [loginid=" + loginid + ", sno=" + sno + ", account=" + account + ", passwd=" + passwd
				+ ", recorder=" + recorder + ", recordtime=" + recordtime + ", modifytime=" + modifytime
				+ ", freezeflag=" + freezeflag + "]";
	}
	
	
	
}
