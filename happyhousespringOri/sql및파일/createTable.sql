CREATE TABLE `housedeal` (
  `no` int NOT NULL AUTO_INCREMENT,
  `dong` varchar(30) NOT NULL,
  `AptName` varchar(50) NOT NULL,
  `code` varchar(30) NOT NULL,
  `dealAmount` varchar(50) NOT NULL,
  `buildYear` varchar(30) DEFAULT NULL,
  `dealYear` varchar(30) DEFAULT NULL,
  `dealMonth` varchar(30) DEFAULT NULL,
  `dealDay` varchar(30) DEFAULT NULL,
  `area` varchar(30) DEFAULT NULL,
  `floor` varchar(30) DEFAULT NULL,
  `jibun` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `rentMoney` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ;
CREATE TABLE `houseinfo` (
  `no` int NOT NULL AUTO_INCREMENT,
  `dong` varchar(30) NOT NULL,
  `AptName` varchar(50) NOT NULL,
  `code` varchar(30) NOT NULL,
  `buildYear` varchar(30) DEFAULT NULL,
  `jibun` varchar(30) DEFAULT NULL,
  `lat` varchar(30) DEFAULT NULL,
  `lng` varchar(30) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ;
CREATE TABLE `notice` (
  `noticeno` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `regtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`noticeno`)
) ;
CREATE TABLE `client` (
  `no` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL UNIQUE,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`no`)
) ;
CREATE TABLE `favorite` (
  `no` int NOT NULL AUTO_INCREMENT,
  `clientId` varchar(50) NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  `gugun` varchar(20) DEFAULT NULL,
  `dong` varchar(20) DEFAULT NULL,
  `code` varchar(30),
  PRIMARY KEY (`no`)
);
CREATE TABLE `shop` (
  `no` int NOT NULL AUTO_INCREMENT,
  `shopname` varchar(50) NOT NULL,
  `localname` varchar(30) DEFAULT NULL,
  `code1` varchar(30) DEFAULT NULL,
  `codename1` varchar(30) DEFAULT NULL,
  `code2` varchar(30) DEFAULT NULL,
  `codename2` varchar(30) DEFAULT NULL,
  `code3` varchar(30) DEFAULT NULL,
  `codename3` varchar(30) DEFAULT NULL,
  `code4` varchar(30) DEFAULT NULL,
  `codename4` varchar(30) DEFAULT NULL,
  `citycode` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `gucode` varchar(30) DEFAULT NULL,
  `gu` varchar(30) DEFAULT NULL,
  `dongcode` varchar(30) DEFAULT NULL,
  `dong` varchar(30) DEFAULT NULL,
  `jibuaddress` varchar(30) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `oldpostcode` varchar(30) DEFAULT NULL,
  `postcode` varchar(30) DEFAULT NULL,
  `lng` varchar(30) DEFAULT NULL,
  `lat` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
);
CREATE TABLE `water` (
  `no` int NOT NULL AUTO_INCREMENT,
  `city` varchar(10) DEFAULT NULL,
  `JACHIGU` varchar(10) DEFAULT NULL,
  `GYE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no`)
);
CREATE TABLE `air` (
  `no` int NOT NULL AUTO_INCREMENT,
  `city` varchar(10) DEFAULT NULL,
  `MSRSTENAME` varchar(10) DEFAULT NULL,
  `PM10` varchar(10) DEFAULT NULL,
  `PM25` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no`)
);
CREATE TABLE `green` (
  `no` int NOT NULL AUTO_INCREMENT,
  `city` varchar(10) DEFAULT NULL,
  `JACHIGU` varchar(10) DEFAULT NULL,
  `GAESO_1` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no`)
);

create table f_house(
	 no	INT auto_increment PRIMARY KEY,
       houseno int not null,
       id VARCHAR(50) not null
);