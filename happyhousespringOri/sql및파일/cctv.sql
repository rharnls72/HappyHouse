CREATE TABLE `cctv` (
  `no` int auto_increment,
  `city` varchar(30),
  `gugun` varchar(30),
  `dong` varchar(30),
  `guguncode` varchar(30),
  `dongcode` varchar(30),
  `code` varchar(30),
  `let` varchar(30),
  `lng` varchar(30),
  PRIMARY KEY (`no`)
);

UPDATE cctv join guguncode
ON cctv.gugun = guguncode.gugun_name
SET cctv.guguncode = guguncode.gugun_code;

UPDATE cctv join dongcode
ON cctv.gugun = dongcode.gugun and cctv.dong = dongcode.dong
SET cctv.dongcode = dongcode.dongcode,
cctv.code = dongcode.code;