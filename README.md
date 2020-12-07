# maven-ssm
useing springmvc、mybatis、bootstrap to completed a simple student crud

# 数据库 MySql 5.6
CREATE TABLE student(
	sno INT PRIMARY KEY NOT NULL,
	sname VARCHAR(300),
	project VARCHAR(300),
	score FLOAT
)

create table login(
	loginid int primary key not null,
  acount varchar(300) not null,
  passwd varchar(300) not null,
	recorder varchar(300),
	recordtime datetime,
	modifier varchar(300),
	modifytime datetime,
	freezeflag char default 0 not null
)
