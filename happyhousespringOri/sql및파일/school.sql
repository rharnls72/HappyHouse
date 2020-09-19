CREATE TABLE `school` (
  `no` int auto_increment,
  `name` varchar(30),
  `grade` varchar(30),
  `city` varchar(30),
  `gugun` varchar(30),
  `dong` varchar(30),
  `guguncode` varchar(30),
  `dongcode` varchar(30),
  `code` varchar(30),
  `address` varchar(50),
  `lat` varchar(30),
  `lng` varchar(30),
  PRIMARY KEY (`no`)
);
select * from school;

UPDATE school join guguncode
ON school.gugun = guguncode.gugun_name
SET school.guguncode = guguncode.gugun_code;

UPDATE school join dongcode
ON school.gugun = dongcode.gugun and school.dong = dongcode.dong
SET school.dongcode = dongcode.dongcode,
school.code = dongcode.code
;
