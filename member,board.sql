create table member (
userid varchar2(30) not null unique,
passwd varchar2(30) not null,
name varchar2(30) not null,
email varchar2(50) not null,
join_date date default sysdate);

select * from member;
alter table member modify join_date date default sysdate;


select * from board;
delete from board where writer='ehrmaks';
create table board (
bno number not null,
title varchar2(200) not null,
content varchar2(4000),
writer varchar2(50) not null,
regdate date default sysdate,
viewcnt number default 0,
primary key(bno)
);


alter table board add user_name varchar2(50);
alter table board add cnt number;

alter table attach add constraint fk_board_attch foreign key(bno) references board(bno);

select * from attach;
alter table member add constraint fk_board foreign key(name) references board(user_name);

create sequence seq_board start with 1 increment by 1;


select count(*) from board b, member m where writer like '%';

SELECT NVL(MAX(bno)+1, 1)from board);


SELECT * FROM BOARD;
create table attach (
fullName varchar2(100) not null,
bno number not null,
regdate date default sysdate,
primary key(fullName)
);


create table reply (
rno number not null,
bno number not null,
replytext varchar2(1000) not null,
replyer varchar2(50) not null,
user_name varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate,
secret_reply varchar2(1) default ('n'),
primary key(bno)
);
select * from reply;


delete from reply where replyer='kjsfk';

select r.secret_reply as secretReply from reply r;
select r.rno, bno, r.replyer, (select b.writer from board b reply r where b.bno=r.bno) as writer from reply r, member m;

delete from reply where secret_reply is null;

alter table reply modify secret_reply varchar(1) default (null);
alter table reply drop primary key;
alter table reply add constraint rno primary key(rno);

alter table reply drop column name;
alter table reply add user_name varchar2(50);
insert into reply(rno, bno, replytext, replyer) values (reply_seq.nextval, 64, 'asdf', 'admin');
insert into reply(secret_reply as secretReply) values('n');
create sequence reply_seq start with 1 increment by 1;
alter table reply add constraint fk_board2 foreign key(bno) references board(bno);
alter table reply drop constraint fk_board2;
