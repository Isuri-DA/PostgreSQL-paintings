-- 3) How many paintings have an asking price of more than their regular price? 

select * from product_size 
where sale_price > regular_price



-- 4) Identify the paintings whose asking price is less than 50% of its regular price

select * from product_size 
where sale_price < (regular_price*0.5)


-- 5) Which canva size costs the most?

-- with 'max' 
select cs.label as canva, ps.sale_price 
from (select * from product_size 
     where sale_price = (select max(sale_price) 
						 from product_size )) ps
join canvas_size cs on ps.size_id=cs.size_id::text;

-- with 'rank' 
select cs.label as canva, ps.sale_price
from (select *
	  , rank() over(order by sale_price desc) as rnk 
	  from product_size) ps
join canvas_size cs on cs.size_id::text=ps.size_id
where ps.rnk=1;	




