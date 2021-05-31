-- #1
-- n, min, max, avg, variance
select
	count(xtr.averagerating) as "Total",
	min(xtr.averagerating) as "Min Rating",
	max(xtr.averagerating) as "Max Rating",
	avg(xtr.averagerating) as "Average Rating",
	variance(xtr.averagerating) as "Variance Rating"
from
	imdb.public.xf_title_ratings xtr
	
-- skewness and kurtosis
with avg_CTE as (
select
	avg(xtr.averagerating) as avgRating
from
	imdb.public.xf_title_ratings xtr )
select
	(sum(power((xtr.averagerating - a.avgRating), 3))) / 
	((count(xtr.averagerating) - 1) * power(stddev(xtr.averagerating), 3)) as "Skewness"
from
	imdb.public.xf_title_ratings xtr,
	avg_CTE a
	
with avg_CTE as (
select
	avg(xtr.averagerating) as avgRating
from
	imdb.public.xf_title_ratings xtr )
select
	(sum(power((xtr.averagerating - a.avgRating), 4))) / 
	((count(xtr.averagerating) - 1) * power(stddev(xtr.averagerating), 4)) as "Kurtosis"
from
	imdb.public.xf_title_ratings xtr,
	avg_CTE a

-- relative frequency
with total_CTE as (
select
	*
from
	imdb.public.xf_title_ratings xtr )
select
	xtr.averagerating as "Rating",
	(count(xtr.averagerating) / count(t.*)) as "Relative Frequency"
from
	imdb.public.xf_title_ratings xtr,
	total_CTE as t
group by
	1
	
-- #2
-- title.basics, title.principal, name.basics, 
select
	xnb.primaryname as "Name",
	xtp.category as "Role"
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_principals xtp on
	xtb.tconst = xtp.tconst
inner join imdb.public.xf_name_basic xnb on
	xtp.nconst = xnb.nconst
where
	xtb.originaltitle = 'Lord of War'
	and xtp.category like 'act%'



-- #3
-- title.basics, title.ratings
select
	xtb.originaltitle as "Title",
	xtr.averagerating as "Rating"
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
where
	xtb.titletype = 'short'
	and xtb.startyear between 2000 and 2010
order by 2 desc 
fetch first 10 rows only;

-- #4
-- title.basics, title.ratings
select
	ROUND(avg(xtr.numvotes), 2) as "Average Votes",
	case
		when xtr.averagerating <= 1 then '0-1'
		when xtr.averagerating > 1
		and xtr.averagerating <= 2 then '1-2'
		when xtr.averagerating > 2
		and xtr.averagerating <= 3 then '2-3'
		when xtr.averagerating > 3
		and xtr.averagerating <= 4 then '3-4'
		else '4-5'
	end as ratingGrouped
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
where
	xtb.titletype = 'movie'
group by
	ratinggrouped;





