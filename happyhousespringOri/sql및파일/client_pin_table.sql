use ssafydb;

drop table client;

create table client (
	id varchar(50) primary key,
    password varchar(100),
    name varchar(30)
);

create table pin (
	pin_no int primary key auto_increment,
    pin_clientid varchar(50) not null,
    pin_houseno int not null,
	foreign key (pin_clientid) 
        references client(id) 
        on update cascade on delete cascade,
	foreign key(pin_houseno)
        references housedeal(no)
        on update cascade on delete cascade
);