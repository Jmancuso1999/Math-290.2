-- #1
select SUM(xtb.runtimeminutes) as "Nicolas Cage Movie Total Runtime"
from imdb.public.xf_title_basic xtb  
inner join imdb.public.xf_title_principals xtp 
on xtb.tconst = xtp.tconst 
inner join imdb.public.xf_name_basic xnb 
on xtp.nconst = xnb.nconst 
where primaryname ='Nicolas Cage' and xtb.titletype = 'movie'

-- #2
-- title.basics contains title 
-- title.principal contains titleID and the actors who were in that movie
-- name_basic contains actor name
  
select xnb.primaryname as "Name", count(*) as "Total Movies"
from imdb.public.xf_title_basic xtb  
inner join imdb.public.xf_title_principals xtp 
on xtb.tconst = xtp.tconst 
inner join imdb.public.xf_name_basic xnb 
on xtp.nconst = xnb.nconst
where xtb.endyear = 2012
group by xnb.nconst
order by 2 desc

-- #3
-- title.basics contains the movie title
-- title.ratings contains the ratings of movies
-- title.principal contains titleID and the actors who were in that movie
-- name_basic contains actor name

select xtb.primarytitle, xtr.averagerating 
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
inner join imdb.public.xf_title_principals xtp 
on xtr.tconst = xtp.tconst 
inner join imdb.public.xf_name_basic xnb 
on xtp.nconst = xnb.nconst
where primaryname ='Nicolas Cage' and xtb.titletype = 'movie'
order by xtr.averagerating desc
limit 1

-- #4
-- title.basic contains the titleID and title name
-- title.rating contains titleID, title rating and Genre

select xtb.primarytitle as "Title", xtr.averagerating as "Rating"
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
where xtb.titletype = 'short' and xtb.startyear = 2009
order by xtr.averagerating desc
limit 1

-- #5
-- title.basic contains the titleID and runtime
-- title.principals contains the titleID and actors within that movie
-- name.basics contains the actorID and the actor's name

select xnb.primaryname as "Name", count(xnb.primaryname) as "Number of Appearances"
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_principals xtp 
on xtb.tconst = xtp.tconst 
inner join imdb.public.xf_name_basic xnb 
on xtp.nconst = xnb.nconst
where xtb.titletype = 'movie'
and (xtb.runtimeminutes between 45 and 60) 
and (xtb.startyear between 2000 and 2010)
group by xnb.primaryname
order by 2 desc 
limit 10

-- #6
-- title.basic contains titleID and title
-- title.rating contains titleID and rating

select xtb.primarytitle as "Title", xtr.averagerating as "Rating"
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
where xtb.titletype = 'movie' and length(xtb.primarytitle) = 3
order by xtr.averagerating desc
limit 10

-- #7
-- title.basic contains titleID and title
-- title.rating contains titleID and rating

select length(xtb.primarytitle) as "Length", avg(xtr.averagerating) as "Rating"
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
where xtb.titletype = 'movie' 
and (length(xtb.primarytitle) = 2 or length(xtb.primarytitle) = 3)
group by 1
order by 2 desc

-- #8
select xtb.startyear as "Year", length(xtb.primarytitle) as "Length", avg(xtr.averagerating) as "Rating"
from imdb.public.xf_title_basic xtb 
inner join imdb.public.xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
where xtb.titletype = 'movie' 
and (length(xtb.primarytitle) = 2 or length(xtb.primarytitle) = 3)
group by 1, 2
order by 1 desc

