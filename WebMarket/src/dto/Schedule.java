package dto;

import java.util.Date;

public class Schedule {
  private Date date;
  private int seq;
  private String fromTime;
  private String toTime;
  private String toDo;
  
  
 public Schedule() {}

public Schedule(Date date, int seq, String fromTime, String toTime, String toDo) {
	this.date = date;
	this.seq = seq;
	this.fromTime = fromTime;
	this.toTime = toTime;
	this.toDo = toDo;
}

public Date getDate() {
	return date;
}

public void setDate(Date date) {
	this.date = date;
}

public int getSeq() {
	return seq;
}

public void setSeq(int seq) {
	this.seq = seq;
}

public String getFromTime() {
	return fromTime;
}

public void setFromTime(String fromTime) {
	this.fromTime = fromTime;
}

public String getToTime() {
	return toTime;
}

public void setToTime(String toTime) {
	this.toTime = toTime;
}

public String getToDo() {
	return toDo;
}

public void setToDo(String toDo) {
	this.toDo = toDo;
}
  
  
}