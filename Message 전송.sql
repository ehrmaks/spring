1. 사용자 테이블 생성
create table tbl_user(
userid varchar2(50) not null,
userpw varchar2(50) not null,
uname varchar2(50) not null,
upoint number default 0,
primary key(userid)
);

2. 메시지 저장 테이블 생성
create table tbl_message (
mid number not null,
targetid varchar2(50) not null,
sender varchar2(50) not null,
message varchar2(4000) not null,
opendate date,
senddate date default sysdate,
primary key(mid)
);


drop sequence message_seq;
alter table tbl_message drop constraint fk_usertarget;
alter table tbl_message drop constraint fk_usersender;
drop table tbl_user;
drop table tbl_message;

3. 시퀀스 생성
create sequence message_seq start with 1 increment by 1;

4. 제약조건
alter table tbl_message add constraint fk_usersender 
foreign key (sender) references tbl_user(userid);
alter table tbl_message add constraint fk_usertarget
foreign key (targetid) references tbl_user(userid);

insert into tbl_user (userid, userpw, uname) values ('user01', '1234','kim');
insert into tbl_user (userid, userpw, uname) values ('user02', '1234','lee');
insert into tbl_user (userid, userpw, uname) values ('user03', '1234','min');
insert into tbl_user (userid, userpw, uname) values ('user04', '1234','cha');
insert into tbl_user (userid, userpw, uname) values ('user05', '1234','choi');
insert into tbl_user (userid, userpw, uname) values ('user06', '1234','all');
insert into tbl_message(mid, targetid,sender,message) values 
(message_seq.nextval,'user02', 'user01', 'hello');

commit;

select * from tbl_user;
select * from tbl_message;
