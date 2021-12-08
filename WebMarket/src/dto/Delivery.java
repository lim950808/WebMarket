package dto;

import java.io.Serializable;

public class Delivery implements Serializable{
  private static final long serialVersionUID = 1L;

  private int seq;
  private String name;
  private String country;
  private String zipcode;
  private String roadAddress;
  private String jibunAddress;
  private String detailAddress;
  private String extraAddress;
  
public Delivery() {}

public Delivery(int seq, String name, String country, String zipcode, String roadAddress, String jibunAddress,
		String detailAddress, String extraAddress) {
	this.seq = seq;
	this.name = name;
	this.country = country;
	this.zipcode = zipcode;
	this.roadAddress = roadAddress;
	this.jibunAddress = jibunAddress;
	this.detailAddress = detailAddress;
	this.extraAddress = extraAddress;
}

public int getSeq() {
	return seq;
}
public void setSeq(int seq) {
	this.seq = seq;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getCountry() {
	return country;
}
public void setCountry(String country) {
	this.country = country;
}
public String getZipcode() {
	return zipcode;
}
public void setZipcode(String zipcode) {
	this.zipcode = zipcode;
}
public String getRoadAddress() {
	return roadAddress;
}
public void setRoadAddress(String roadAddress) {
	this.roadAddress = roadAddress;
}
public String getJibunAddress() {
	return jibunAddress;
}
public void setJibunAddress(String jibunAddress) {
	this.jibunAddress = jibunAddress;
}
public String getDetailAddress() {
	return detailAddress;
}
public void setDetailAddress(String detailAddress) {
	this.detailAddress = detailAddress;
}
public String getExtraAddress() {
	return extraAddress;
}
public void setExtraAddress(String extraAddress) {
	this.extraAddress = extraAddress;
}

  
  
}