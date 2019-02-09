create table member (
userid varchar2(30) not null unique,
passwd varchar2(30) not null,
name varchar2(30) not null,
email varchar2(50) not null,
join_date date default sysdate);

commit;
select * from member;
alter table member modify join_date date default sysdate;
alter table member add address1 varchar2(50);
alter table member add address2 varchar2(20);
alter table member add updatesys date default sysdate;
alter table member drop column updatesys;
alter table member modify address1 varchar2(100);
alter table member add zipcode varchar2(20);
select * from member where userid='kjsfk';
update member set updatesys=sysdate where userid = 'power123';
delete from member where userid='qwefk123';
select count(*) from member where userid='kjsfk';
alter table member modify passwd varchar2(100);
select passwd from member where userid = 'kjsfk12';
delete from member;
select * from board;

select bno,title,(select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate,content,viewcnt,user_name,writer 
		from board b, member m, admin a
		where (b.writer=m.userid or b.writer=a.userid) and b.bno=461;
    
    select bno,title,(select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate,content,viewcnt,name,writer 
		from board b, admin a
		where b.writer=a.userid and bno=461;
select count(*)
		from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid)
				and (b.user_name like '%%'
				or b.title like '%%'
				or b.content like '%%');
        
select count(*) from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid) 
and b.title like '%%';        
        
select count(*) from board b, member m, admin a where b.bno in (select distinct bno from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid) 
and b.title like '%%');

select bno from board b, admin a where a.name=b.user_name;

select distinct bno, title from board b, member m, admin a where (b.writer=m.userid or b.writer=a.userid) 
and b.title like '%%' order by bno desc;

select * from board;
select * from attach;

select sum(C.cnt) from
(select count(*) cnt from board b, admin a where b.writer=a.userid and b.title like '%%'
union all
select count(*) cnt from board b, member m where b.writer=m.userid and b.title like '%%')C;

SELECT a3.* FROM (
        SELECT ROWNUM AS rn, a2.* from (
        SELECT A.* FROM (
        SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, 
			viewcnt,(select count(*) from reply where bno=b.bno) cnt
        	FROM board b, admin a
          where b.writer=a.userid and b.title like '%%' order by bno desc)A
          
    union
      
      SELECT B.* FROM (
        SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, 
			viewcnt,(select count(*) from reply where bno=b.bno) cnt
        	FROM board b, member m
          where b.writer=m.userid and b.title like '%%' order by bno desc)B
      )a2
    )a3 WHERE rn BETWEEN 1 AND 10 ORDER BY bno desc;
    
    
    SELECT * FROM (
    SELECT ROWNUM AS rn, B.* FROM (
        SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, 
			viewcnt,(select count(*) from reply where bno=b.bno) cnt
        	FROM board b, admin a
          where b.writer=a.userid and b.title like '%%'
        ) B
    ) WHERE rn BETWEEN 1 AND 10 ORDER BY bno desc;
    
    
    SELECT * FROM (
        SELECT ROWNUM AS rn, A.* FROM (
        SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, 
			viewcnt,
			(select count(*) from reply 
			where bno=b.bno) cnt
        	FROM board b, admin a
          where b.writer=a.userid
				and
				b.bno like '%%') A
        
        union
        SELECT ROWNUM AS rn, B.* FROM (
        SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, 
			viewcnt,
			(select count(*) from reply 
			where bno=b.bno) cnt
        	FROM board b, member m
          where b.writer=m.userid
				and
				b.bno like '%%') B
    ) WHERE rn BETWEEN 1 AND 10 order by bno desc;
    
    select * from board where rn BETWEEN 1 AND 50 order by bno desc;
    
    select bno,title,(select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate,content,viewcnt,user_name,writer 
		from board b, member m
		where b.writer=m.userid and b.bno=461
		union all
		select bno,title,(select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate,content,viewcnt,user_name,writer 
		from board b, admin a
		where b.writer=a.userid and b.bno=461;
    
    select * from reply;
    
    select * from (
		select rownum as rn, A.* from (
    select r.rno, bno, r.replytext, r.replyer, 
				r.secret_reply, r.regdate, r.updatedate, r.user_name,
				(select b.writer from board b where b.bno = r.bno) as writer
			from reply r, member m
			where
				r.replyer = m.userid
				and bno = 463
			order by rno
      ) A
		) where rn between 1 and 3;
    union all
        select * from (
		select rownum as rn, A.* from (
    select r.rno, bno, r.replytext, r.replyer, 
				r.secret_reply, r.regdate, r.updatedate, r.user_name,
				(select b.writer from board b where b.bno = r.bno) as writer
			from reply r, admin a
			where
				r.replyer = a.userid
				and bno = 463
			order by rno
      ) A
		) where rn between 1 and 3;
    

create table admin (
userid varchar2(30) not null unique,
passwd varchar2(100) not null,
name varchar2(30) not null,
email varchar2(100) not null,
join_date  date default sysdate,
address1 varchar2(100) not null,
address2 varchar2(100) not null,
updatesys date default sysdate,
zipcode varchar2(20));

select * from admin;

SELECT * FROM (
        SELECT ROWNUM AS rn, A.* FROM (
SELECT rownum, bno, title, user_name, regdate, viewcnt,
			(select count(*) from reply 
			where bno=b.bno) cnt
        	FROM board b, member m, admin a
          where b.writer=m.userid or b.writer=a.userid
				and (b.user_name like '%%'
				or b.title like '%%' 
				or b.content like '%%')
        order by bno desc,regdate desc  
        ) A
    ) WHERE rn BETWEEN 1 AND 10;
        
select bno,title,regdate,content,viewcnt,user_name,writer 
		from board b, member m, admin a
		where (b.writer=m.userid or b.writer=a.userid) and b.bno='423';


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
select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno = 143;

SELECT rownum, bno, title, user_name, (select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno = 143) regdate, 
			viewcnt, (select count(*) from reply where bno=b.bno) cnt
        	FROM board b;

select to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board;
insert into board(bno,title,writer,viewcnt) values(1,'제목','kjsfk',1);
select * from board;



delete from board where user_name='관리자';
select viewcnt from board where bno=20;
select bno, title, writer, regdate, viewcnt  from board;
select m.name from board b, member m;

alter table board add user_name varchar2(50);
alter table board add cnt number;
ALTER table board add notice varchar2(20);
select * from board order by bno;

SELECT * FROM ( SELECT ROWNUM AS rn, A.* FROM ( SELECT rownum, bno, title, user_name, (select 
to_char(regdate, 'yyyy-mm-dd hh12:mi:ss') from board where bno=b.bno) regdate, viewcnt, (select 
count(*) from reply where bno=b.bno) cnt, notice FROM board b, admin a where b.writer=a.userid and 
notice is null and title like '%%' order by bno desc ) A ) WHERE rn BETWEEN 1 AND 10;

alter table attach add constraint fk_board_attch foreign key(bno) references board(bno);
commit;
select * from attach;
alter table member add constraint fk_board foreign key(name) references board(user_name);

create sequence seq_board start with 1 increment by 1;
create sequence seq_notice start with 1 increment by 1;

select count(*) from board b, member m where writer like '%';

insert into board(bno, title, content, writer) values(seq_board.NEXTVAL, '아잉', '뿌잉', '김진석');
SELECT NVL(MAX(bno)+1, 1)from board);
drop table attach;
drop table admin;

delete from member where userid='admin';

select * from admin;
select * from member;
select * from board;
select count(*) from board b, member m, admin a where (b.writer = m.userid or b.writer = a.userid) and b.user_name like '관리자';

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
select * from board;

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
