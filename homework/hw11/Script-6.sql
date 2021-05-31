-- #1
-- kurtosis 
create or replace function kurtosis()
returns decimal 
language plpgsql
as
$$
declare
   k decimal;
begin
	with avg_CTE as (
	select
		avg(xtr.averagerating) as avgRating
	from
		imdb.public.xf_title_ratings xtr )
	select
		(sum(power((xtr.averagerating - a.avgRating), 3))) / 
		((count(xtr.averagerating) - 1) * power(stddev(xtr.averagerating), 3)) as "Skewness"
	into k
	from
		imdb.public.xf_title_ratings xtr,
		avg_CTE a;
   
   return k;
end;
$$;

select kurtosis()


-- skewness
create or replace function skewness()
returns decimal 
language plpgsql
as
$$
declare
   s decimal;
begin
	with avg_CTE as (
	select
		avg(xtr.averagerating) as avgRating
	from
		imdb.public.xf_title_ratings xtr )
	select
		(sum(power((xtr.averagerating - a.avgRating), 4))) / 
		((count(xtr.averagerating) - 1) * power(stddev(xtr.averagerating), 4)) as "Kurtosis"
	into s
	from
		imdb.public.xf_title_ratings xtr,
		avg_CTE a;
   
   return s;
end;
$$;

select skewness()


-- #2
CREATE EXTENSION tsm_system_rows;

select *
from imdb.public.xf_title_ratings xtr 
TABLESAMPLE SYSTEM_ROWS(50);