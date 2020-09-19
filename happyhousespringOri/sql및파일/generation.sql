create table generation(
  `no` int auto_increment,
  `gugun` varchar(30),
  `dong` varchar(30),
  `guguncode` varchar(30),
  `dongcode` varchar(30),
  `code` varchar(30),
  `generation` int,
  PRIMARY KEY (`no`)
);

UPDATE generation join guguncode
ON generation.gugun = guguncode.gugun_name
SET generation.guguncode = guguncode.gugun_code;

UPDATE generation join dongcode
ON generation.gugun = dongcode.gugun and generation.dong = dongcode.dong
SET generation.dongcode = dongcode.dongcode,
generation.code = dongcode.code;