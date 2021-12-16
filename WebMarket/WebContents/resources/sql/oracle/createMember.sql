CREATE TABLE member (
  id VARCHAR(10) NOT NULL,
  password VARCHAR(10) NOT NULL,
  name VARCHAR(10) NOT NULL,
  gender VARCHAR(4) NULL,
  birth VARCHAR(10) NULL,
  mail VARCHAR(30) NULL,
  phone VARCHAR(20) NULL,
  zipcode VARCHAR(5) NULL,
  roadAddress VARCHAR(100) NULL,
  jibunAddress VARCHAR(100) NULL,
  detailAddress VARCHAR(100) NULL,
  extraAddress VARCHAR(100) NULL,
  register_day VARCHAR(50) NULL,
  PRIMARY KEY (id)
  );