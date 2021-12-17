CREATE TABLE board (
  num int NOT NULL,
  id varchar(45) NOT NULL,
  name varchar(45) NOT NULL,
  subject varchar(100) NOT NULL,
  content varchar(2048) NOT NULL,
  regist_day varchar(45) DEFAULT NULL,
  hit int DEFAULT NULL,
  ip varchar(45) DEFAULT NULL,
  PRIMARY KEY (num)
)
;

alter table board add attachFile varchar2(200);