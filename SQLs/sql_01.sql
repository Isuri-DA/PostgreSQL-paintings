-- 1) Fetch all the paintings which are not displayed on any museums?

select * from work where museum_id is null;

-- 10223 paintings aren't displaed in any museums

-- 1.A) Group them in style 

select style , count(*) from work 
where museum_id is null
group by style
order by count(*) desc;

-- they are in 24 styles max = "Impressionism"  & min = "Japanese Art"

-- 1.B) % of them

with paintings_displayed as
	(select  coalesce(style ,'Other') as new_style ,count(work_id) as no_of_paintings,
	 sum(case when museum_id is null then 1 else 0 end) as not_displayed_count,
	 sum(case when museum_id is not null then 1 else 0 end) as displayed_count
	from work group by style)
select new_style,no_of_paintings ,displayed_count
,round ((not_displayed_count*100)/no_of_paintings::numeric ,2) as not_displayed_presentage
--,(not_displayed_count*100)/no_of_paintings::numeric(6,0) as not_displayed_presentage
from paintings_displayed 
order by not_displayed_presentage desc;


--- QA SQLs

select 1/3; -- 0

select 1/3.0; -- 0.33333333333333333333

select 1/3::float; -- 0.3333333333333333

select (1/3)::float; --0

select 1/3*100::float; --0

select 1*100/3::float; -- 33.333333333333336


select 1/3::numeric; -- 0.33333333333333333333

select 1/3::numeric(5,2); -- 0.33333333333333333333 ???

select round(33.33333 ,2 ); --33.33

select round((1*100/3::numeric) ,2 ); --33.33 