create table member (
userid varchar2(30) not null unique,
passwd varchar2(30) not null,
name varchar2(30) not null,
email varchar2(50) not null,
join_date date default sysdate);

select * from member;
alter table member modify join_date date default sysdate;

create table admin (
userid varchar2(30) not null unique,
passwd varchar2(30) not null,
name varchar2(30) not null,
email varchar2(50) not null,
join_date timestamp);

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
insert into board(bno,title,writer,viewcnt) values(1,'力格','kjsfk',1);
select * from board;
delete from board where user_name='包府磊';
select viewcnt from board where bno=20;
select bno, title, writer, regdate, viewcnt  from board;
select m.name from board b, member m;

alter table board add user_name varchar2(50);
alter table board add cnt number;

alter table attach add constraint fk_board_attch foreign key(bno) references board(bno);

select * from attach;
alter table member add constraint fk_board foreign key(name) references board(user_name);

create sequence seq_board start with 1 increment by 1;


select count(*) from board b, member m where writer like '%';

insert into board(bno, title, content, writer) values(seq_board.NEXTVAL, '酒雷', '谎雷', '辫柳籍');
SELECT NVL(MAX(bno)+1, 1)from board);
drop table attach;
drop table admin;

delete from member where userid='admin';

select * from admin;
select * from member;
select * from board;
select count(*) from board b, member m, admin a where (b.writer = m.userid or b.writer = a.userid) and b.user_name like '包府磊';

select count(*) from member;
select count(*) from member m left outer join admin a on m.userid=a.userid;
select  from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid) and b.bno='59';

select bno, title, regdate, content, viewcnt, user_name from board b, member m, admin a where b.writer=m.userid and m.userid=a.userid and b.bno='48';

select bno, title, regdate, content, viewcnt, user_name from board where bno='26';
select bno, title, regdate, content, viewcnt, user_name from board b left join member m on b.writer=m.userid left join admin a on b.writer=a.userid where (b.writer=m.userid or b.writer=a.userid) and b.bno='26';
select bno,title,regdate,content,viewcnt,user_name,writer from board b, member m, admin a where b.writer=m.userid and b.bno='26';
select * from board b, member m where b.writer=m.userid and b.bno='48'(select * from admin a where b.writer=a.userid and b.bno='26');
select b.* from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid) and b.bno='49';

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