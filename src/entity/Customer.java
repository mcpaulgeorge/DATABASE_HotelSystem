package entity;

import java.util.Date;

public class Customer {
private String cid;
private String cname;
private String csex;
private String cage;
private String caddress;
private String cwork;
private String chome;
private String ckind;
private int cno;
private String rno;
private String hname;
private String checkin_date;
private String support_date;
private String checkout_date=null;
private double plege;
private int cost=0;

public Customer()
{
	
}
public Customer(String cid, String cname, String csex, String cage, String caddress, String cwork, String chome,
		String ckind, int cno, String rno, String hname, String checkin_date, String support_date, String checkout_date,
		double plege) {
	super();
	this.cid = cid;
	this.cname = cname;
	this.csex = csex;
	this.cage = cage;
	this.caddress = caddress;
	this.cwork = cwork;
	this.chome = chome;
	this.ckind = ckind;
	this.cno = cno;
	this.rno = rno;
	this.hname = hname;
	this.checkin_date = checkin_date;
	this.support_date = support_date;
	this.checkout_date = checkout_date;
	this.plege = plege;
}
public Customer(String cid, String cname, String csex, String cage, String caddress, String cwork, String chome,
		String ckind, int cno, String rno, String hname, String checkin_date, String support_date, 
		double plege) {
	super();
	this.cid = cid;
	this.cname = cname;
	this.csex = csex;
	this.cage = cage;
	this.caddress = caddress;
	this.cwork = cwork;
	this.chome = chome;
	this.ckind = ckind;
	this.cno = cno;
	this.rno = rno;
	this.hname = hname;
	this.checkin_date = checkin_date;
	this.support_date = support_date;
	this.plege = plege;
}

public String getCid() {
	return cid;
}

public void setCid(String cid) {
	this.cid = cid;
}

public String getCname() {
	return cname;
}

public void setCname(String cname) {
	this.cname = cname;
}

public String getCsex() {
	return csex;
}

public void setCsex(String csex) {
	this.csex = csex;
}

public String getCage() {
	return cage;
}

public void setCage(String cage) {
	this.cage = cage;
}

public String getCaddress() {
	return caddress;
}

public void setCaddress(String caddress) {
	this.caddress = caddress;
}

public String getCwork() {
	return cwork;
}

public void setCwork(String cwork) {
	this.cwork = cwork;
}

public String getChome() {
	return chome;
}

public void setChome(String chome) {
	this.chome = chome;
}

public String getCkind() {
	return ckind;
}

public void setCkind(String ckind) {
	this.ckind = ckind;
}

public int getCno() {
	return cno;
}

public void setCno(int cno) {
	this.cno = cno;
}

public String getRno() {
	return rno;
}

public void setRno(String rno) {
	this.rno = rno;
}

public String getHname() {
	return hname;
}

public void setHname(String hname) {
	this.hname = hname;
}

public String getCheckin_date() {
	return checkin_date;
}

public void setCheckin_date(String checkin_date) {
	this.checkin_date = checkin_date;
}

public String getSupport_date() {
	return support_date;
}

public void setSupport_date(String support_date) {
	this.support_date = support_date;
}

public String getCheckout_date() {
	return checkout_date;
}

public void setCheckout_date(String checkout_date) {
	this.checkout_date = checkout_date;
}

public double getPlege() {
	return plege;
}

public void setPlege(double plege) {
	this.plege = plege;
}

public int getCost() {
	return cost;
}

public void setCost(int cost) {
	this.cost = cost;
}

}
