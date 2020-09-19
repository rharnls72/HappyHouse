drop table housesell;
CREATE TABLE `housesell` (
  `no` int NOT NULL AUTO_INCREMENT,
  `dong` varchar(30) DEFAULT NULL,
  `AptName` varchar(30) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `dealAmount` varchar(30) DEFAULT NULL,
  `buildYear` varchar(30) DEFAULT NULL,
  `regYear` varchar(30),
  `regMonth` varchar(30),
  `regDay` varchar(30),
  `area` varchar(30) DEFAULT NULL,
  `floor` varchar(30),
  `jibun` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `rentMoney` varchar(30),
  `phone` varchar(30) DEFAULT NULL,
  `seller` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
);
INSERT INTO housesell(dong, AptName, code, dealAmount, buildYear, regYear, regMonth, regDay, area, floor, jibun, type, rentMoney) 
SELECT dong, AptName, code, dealAmount, buildYear, dealYear as regYear, dealMonth as regMonth, dealDay as regDay, area, floor, jibun, type, rentMoney
FROM housedeal;
update housesell set phone='010-1234-5678' , seller='admin';
commit;