create table tbl_product (
product_id number,              -- 상품번호
product_name varchar2(50),      -- 상품이름
product_price number default 0, -- 상품 가격
product_desc varchar2(500),     -- 상품 상세설명
picture_url varchar2(500),      -- 상품 사진
primary key(product_id)
);
select * from tbl_cart;
delete from tbl_cart;
create sequence seq_product start with 1 increment by 1;

create table tbl_cart(
cart_id number not null primary key,
userid varchar2(50) not null,
product_id number not null,
amount number default 0
);

select count(*) from tbl_product where product_name like '%%';
select * from tbl_product;


select * from(select rownum as rn, A.* from
(SELECT rownum, product_id, product_name, product_price, product_desc, picture_url  
FROM TBL_PRODUCT where product_name like '%%')A order by product_id desc) where rn between 1 and 50;

select count(*) from tbl_product where product_name like '%%';
commit;

select * from( select rownum as rn, A.* from ( select rownum, product_id, product_name, product_price, 
product_desc, picture_url from tbl_product where product_name like '%%' order by product_id 
desc )A ) where rn between 1 and 10;

SELECT * FROM TBL_cart;
update tbl_product set product_name='', product_price=100, product_desc='',picture_url='' where product_id=21;



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



select cart_id, m.userid, name,
		p.product_id, product_name, p.picture_url, amount, product_price,
		product_price*amount money
		from member m, tbl_cart c, tbl_product p
		where m.userid=c.userid and p.product_id=c.product_id
		and m.userid='kjsfk';
