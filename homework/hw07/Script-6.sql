-- #1 step 1 and 2

-- title_basics table
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where  table_schema = 'public' and table_name = 'title_basics';

create view imdb.public.etl_title_basic_v
as
select 
 tb.tconst
,tb.titletype
,tb.primarytitle
,tb.originaltitle
,cast(tb.isadult as boolean) as isadult
,cast(tb.startyear as integer) as startyear
,cast(tb.endyear as integer) as endyear
,cast(tb.runtimeminutes as integer) as runtimeminutes
,regexp_split_to_array(tb.genres,',')::varchar[] as genres       
from imdb.public.title_basics tb;


-- name_basics table
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where  table_schema = 'public' and table_name = 'name_basics';

create view imdb.public.etl_name_basics_v
as 
select 
  nb.nconst,
  nb.primaryname,
  cast(birthyear as integer) as birthyear,
  cast(deathyear as integer) as deathyear,
  regexp_split_to_array(nb.primaryprofession ,',')::varchar[] as primaryprofession, 
  regexp_split_to_array(nb.knownfortitles ,',')::varchar[] as knownfortitles 
from imdb.public.name_basics nb 


-- title_akas
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where  table_schema = 'public' and table_name = 'title_akas';


create view imdb.public.etl_title_akas_v
as 
select *
from imdb.public.title_akas ta 


-- title_crew
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where table_schema = 'public' and table_name = 'title_crew';

create view imdb.public.etl_title_crew_v
as 
select 
  tc.tconst,
  regexp_split_to_array(tc.directors,',')::varchar[] as directors, -- Make the datatype based on the array type that is listed on the site (array of tconst which is a string)
  regexp_split_to_array(tc.writers,',')::varchar[] as writers
from imdb.public.title_crew tc 


-- title_episode
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where table_schema = 'public' and table_name = 'title_episode';

create view imdb.public.etl_title_episode_v
as 
select 
  te.tconst,
  te.parenttconst,
  cast(te.seasonnumber as integer) as seasonnumber,
  cast(te.episodenumber as integer) as episodenumber 
from imdb.public.title_episode te 


-- title_principals
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where table_schema = 'public' and table_name = 'title_principals';

create view imdb.public.etl_title_principals_v
as 
select 
  tp.tconst,
  cast(tp."ordering" as integer) as "ordering",
  tp.nconst,
  tp.category,
  tp.job,
  tp."characters" 
from imdb.public.title_principals tp 


-- title_ratings
select table_name, column_name, data_type 
from IMDB.information_schema.columns
where table_schema = 'public' and table_name = 'title_ratings';

create view 
as 
select 
  tr.tconst,
  cast(tr.averagerating as decimal) as averagerating,
  cast(tr.numvotes as integer) as numvotes 
from imdb.public.title_ratings tr 

-- #1 step 3
create table imdb.public.xf_name_basic
as
select * from imdb.public.etl_name_basics_v;

create table imdb.public.xf_title_akas
as
select * from imdb.public.etl_title_akas_v;

create table imdb.public.xf_title_basic
as
select * from imdb.public.etl_title_basic_v;

create table imdb.public.xf_title_crew
as
select * from imdb.public.etl_title_crew_v;

create table imdb.public.xf_title_episode
as
select * from imdb.public.etl_title_episode_v;

create table imdb.public.xf_title_principals
as
select * from imdb.public.etl_title_principals_v;

create table imdb.public.xf_title_ratings
as
select * from imdb.public.etl_title_ratings_v;


-- #1 step 4
alter table imdb.public.xf_name_basic
add primary key (nconst);

alter table imdb.public.xf_title_basic
add primary key (tconst);

alter table imdb.public.xf_title_crew
add primary key (tconst);

alter table imdb.public.xf_title_episode
add primary key (tconst);


/* some nconst values do not exist in name_basics
alter table imdb.public.xf_title_principals
add constraint FK_nconst
foreign key (nconst) references imdb.public.xf_name_basic(nconst)
*/

alter table imdb.public.xf_title_ratings
add primary key (tconst)

alter table imdb.public.xf_title_ratings
add constraint FK_tconst_ratings
foreign key(tconst) references imdb.public.xf_title_basic(tconst)


-- # 2 question #1
select count(*)
from imdb.public.xf_title_basic
where runtimeminutes between 42 and 77

-- #2 question #2
select avg(runtimeminutes)
from imdb.public.xf_title_basic
where isadult = true

-- #2 question #3
select count(*) from (
select xtb_a.runtimeminutes, xtb_b.runtimeminutes
from imdb.public.xf_title_basic xtb_a, imdb.public.xf_title_basic xtb_b
)x;

-- #2 question #4
select round(avg(runtimeminutes)), count(*) as total_action_movies
from imdb.public.xf_title_basic
where genres[1] = 'Action'

select count(*) as total_action_movies
from imdb.public.xf_title_basic
where round(runtimeminutes) = 
	(select round(avg(runtimeminutes))
		from imdb.public.xf_title_basic
		where isadult = true)
		
-- #2 question 5
select "genres", count(*) as genre_combinations
from imdb.public.xf_title_basic
group by "genres"


-- #3 step 1
select * 
from imdb.public.xf_title_basic xtb
full outer join imdb.public.xf_title_crew xtc
on xtb.tconst = xtc.tconst 

-- #3 step 2
select xtb.tconst, count(xtc.tconst)
from imdb.public.xf_title_basic xtb 
full outer join imdb.public.xf_title_crew xtc
on xtb.tconst = xtc.tconst 
group by xtb.tconst 

-- #3 step 3
with count_CTE as (
	select xtb.tconst, count(xtc.tconst) as countTconst
	from imdb.public.xf_title_basic xtb 
	full outer join imdb.public.xf_title_crew xtc
	on xtb.tconst = xtc.tconst 
	group by xtb.tconst 
) select min(countTconst) as min_tconst, max(counttconst) as max_tconst from count_CTE

-- #4 
with count_CTE as (
	select xtb.tconst, count(xte.tconst) as countTconst
	from imdb.public.xf_title_basic xtb 
	full outer join imdb.public.xf_title_episode xte
	on xtb.tconst = xte.tconst 
	group by xtb.tconst 
) select min(countTconst) as min_tconst, max(counttconst) as max_tconst from count_CTE

with count_CTE as (
	select xtb.tconst, count(xtp.tconst) as countTconst
	from imdb.public.xf_title_basic xtb 
	full outer join imdb.public.xf_title_principals xtp 
	on xtb.tconst = xtp.tconst 
	group by xtb.tconst 
) select min(countTconst) as min_tconst, max(counttconst) as max_tconst from count_CTE

with count_CTE as (
	select xtb.tconst, count(xtr.tconst) as countTconst
	from imdb.public.xf_title_basic xtb 
	full outer join imdb.public.xf_title_ratings xtr 
	on xtb.tconst = xtr.tconst 
	group by xtb.tconst 
) select min(countTconst) as min_tconst, max(counttconst) as max_tconst from count_CTE

