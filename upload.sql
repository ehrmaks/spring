create table attach (
fullname varchar2(150) not null,
bno number not null,
regdate date default sysdate,
filesize varchar2(100),
primary key(fullname)
);

alter table attach drop filesize;

alter table attach add filesize varchar2(100);
alter table attach modify filesize varchar2(1000);
alter table attach modify fullname varchar2(1000);

INSERT INTO ATTACH (FULLNAME, BNO) VALUES('1.png', seq_board.currval);

select * from attach;

select filesize from attach where bno=77 order by regdate desc;

delete from attach;

alter table attach add constraint fk_board_attach foreign key(bno) references board(bno) on delete cascade;

create sequence seq_board start with 1 increment by 1;

drop table attach;
drop sequence seq_board;
alter table attach drop constraint fk_board_attach;
