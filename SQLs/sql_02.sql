-- 2) Are there museuems without any paintings?

select * from museum 
where museum_id not in (select museum_id from work);


select * from museum m
where not exists (select 1 from work w
				 where w.museum_id=m.museum_id)
				 
-- There are no museums without any paintings