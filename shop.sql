create table tbl_product (
product_id number,              -- 상품번호
product_name varchar2(50),      -- 상품이름
product_price number default 0, -- 상품 가격
product_desc varchar2(500),     -- 상품 상세설명
picture_url varchar2(500),      -- 상품 사진
primary key(product_id)
);

create sequence seq_product start with 1 increment by 1;

create table tbl_cart(
cart_id number not null primary key,
userid varchar2(50) not null,
product_id number not null,
amount number default 0
);

drop sequence seq_cart;
drop table tbl_cart;
alter table tbl_cart drop constraint cart_product_fk;
alter table tbl_cart drop constraint cart_userid_fk;

create sequence seq_cart start with 10 increment by 1;

alter table tbl_cart add constraint cart_userid_fk foreign key(userid) references member(userid);
alter table tbl_cart add constraint cart_product_fk foreign key(product_id) references tbl_product(product_id);

commit;

insert into tbl_cart (cart_id, userid, product_id, amount)
		values
		(seq_cart.nextval,'admin', 1, 1);
    
delete from tbl_cart;

select * from tbl_product;
select * from tbl_cart;

