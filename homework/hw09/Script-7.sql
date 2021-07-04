-- #1
select
	avg(xtb.runtimeminutes)
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
inner join imdb.public.xf_title_principals xtp on
	xtr.tconst = xtp.tconst
inner join imdb.public.xf_name_basic xnb on
	xtp.nconst = xnb.nconst
where
	primaryname = 'Nicolas Cage'
	and xtb.titletype = 'movie'

-- #2

with movie_2010_cte as (
select
	xtb.runtimeminutes as "movie"
from
	imdb.public.xf_title_basic xtb
where
	xtb.titletype = 'movie'
	and xtb.startyear = 2010 ),
cage_avg_CTE as (
select
	avg(xtb.runtimeminutes) as cageMovies
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
inner join imdb.public.xf_title_principals xtp on
	xtr.tconst = xtp.tconst
inner join imdb.public.xf_name_basic xnb on
	xtp.nconst = xnb.nconst
where
	primaryname = 'Nicolas Cage'
	and xtb.titletype = 'movie'
	and xtb.startyear = 2010 )
select
	(count(mc1."movie") * 1.0 / count(mc2."movie")) as "Percent"
from
	movie_2010_cte mc1,
	cage_avg_cte cc,
	movie_2010_cte mc2
where
	mc1."movie" > cc.cageMovies
	
	
-- #3 

	
-- #4
with max_season_CTE as (
select
	max(xte.seasonnumber) over (partition by xtb.primarytitle) as maxSeason
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
inner join imdb.public.xf_title_episode xte on
	xtr.tconst = xte.tconst
where
	xtb.titletype = 'tvEpisode'
	and xtr.averagerating > 4.2
order by
	xtb.primarytitle )
select
	avg(maxseason)
from
	max_season_CTE

	
select * from xf_title_episode xte order by xte.tconst 
	
-- #5
select
	max(xtr.averagerating) as "Max Rating",
	avg(xtr.averagerating) as "Mean Rating",
	stddev(xtr.averagerating) as "Standard Deviation"
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_akas xta on
	xtb.tconst = xta.titleid
inner join imdb.public.xf_title_ratings xtr on 
	xta.titleid = xtr.tconst 
where
	xta.region = 'HU'
	and xtb.titletype = 'movie'
	
	
-- #6
select
	xta.region as "Region",
	avg(xtr.numvotes) as "Average Votes Per Region"
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_akas xta on
	xtb.tconst = xta.titleid
inner join imdb.public.xf_title_ratings xtr on
	xta.titleid = xtr.tconst
where
	xtb.titletype = 'movie'
group by
	xta.region
order by
	2 desc 
fetch first 10 rows only


-- #7
-- title_basic, title_rating, title_crew, , name_basics
select
	xtc.directors as "Director",
	xtc.writers as "Writer",
	avg(xtr.averagerating) as "Overall Rating"
from
	imdb.public.xf_title_basic xtb
inner join imdb.public.xf_title_ratings xtr on
	xtb.tconst = xtr.tconst
inner join imdb.public.xf_title_crew xtc on
	xtr.tconst = xtc.tconst
where
	xtb.startyear between 2000 and 2020
group by
	xtc.directors, xtc.writers 
order by 3 desc
fetch first 10 rows only;