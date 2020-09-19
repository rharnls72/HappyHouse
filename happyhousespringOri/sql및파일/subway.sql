CREATE TABLE `subway` (
  `no` int NOT NULL,
  `name` varchar(30),
  `line` int,
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

UPDATE subway join guguncode
ON guguncode.gugun_name like subway.gugun
SET subway.guguncode = guguncode.gugun_code;

UPDATE subway join dongcode
ON subway.gugun = dongcode.gugun and subway.dong = dongcode.dong
SET subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
;
-- csv 수정 완료 하지 않아도 됨
UPDATE subway join dongcode
ON subway.dong = dongcode.dong
SET subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
where subway.gugun = "강남"
;

UPDATE subway join dongcode
on dongcode.dong = "봉래동2가"
SET subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
where subway.dong = "봉래동"
;

UPDATE subway join dongcode
on dongcode.dong = "동자동"
SET subway.dong = "동자동",
subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
where no = 113
;
UPDATE subway join dongcode
on dongcode.dong = "용산동4가"
SET subway.dong = "용산동4가",
subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
where no = 192
;
UPDATE subway join dongcode
on dongcode.dong = "보문동1가"
SET subway.dong = "보문동1가",
subway.dongcode = dongcode.dongcode,
subway.code = dongcode.code
where no = 201
;
