-- #1
select count(distinct vendorid) as vendorid , count(distinct tpep_pickup_datetime) as tpep_pickup_datetime , count(distinct tpep_dropoff_datetime) as tpep_dropoff_datetime, 
count(distinct passenger_count) as passenger_count , count(distinct trip_distance) as trip_distance , count(distinct ratecodeid) as ratecodeid, count(distinct store_and_fwd_flag) as store_and_fwd_flag ,
count(distinct pulocationid) as pulocationid, count(distinct dolocationid) as dolocationid, count(distinct payment_type) as payment_type, count(distinct fare_amount) as fare_amount, 
count(distinct extra) as extra, count(distinct mta_tax) as mta_tax, count(distinct tip_amount) as tip_amount, count(distinct tolls_amount) as total_amount, 
count(distinct improvement_surcharge) as improvement_surcharge, count(distinct total_amount) as total_amount
from qcmath290.public."2018_yellow_taxi_trip_data" yttd


-- #2
select count(*) as distinct_observation_count 
from (select distinct *
      from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query;

-- #3
select count(*)
from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
where passenger_count = 5

-- Gives us all UNIQUE trips (the ENTIRE row has to be unique)
select count(*) from 
(select distinct * 
  from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where passenger_count > 3


select count(*)
from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
where tpep_dropoff_datetime between '2018-04-01 00:00:00' and '2018-05-01 00:00:00';

select count(*) from 
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where tip_amount >= 5.00;

select count(*) from 
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where date_part('month', tpep_pickup_datetime) = 5 and tip_amount >= 2.00 and tip_amount <= 5.00;

select sum(tip_amount) 
from qcmath290.public."2018_yellow_taxi_trip_data" yttd 

-- #4
show data_directory;
select * from pg_catalog.pg_stat_database;

delete from qcmath290.public."2018_yellow_taxi_trip_data" 
where vendorid = 2;

select count(*) from qcmath290.public."2018_yellow_taxi_trip_data" yttd 

-- #5
VACUUM FULL;

-- #6
truncate table qcmath290.public."2018_yellow_taxi_trip_data" 

copy "2018_yellow_taxi_trip_data"(
vendorid, 
tpep_pickup_datetime, 
tpep_dropoff_datetime, 
passenger_count, 
trip_distance, 
ratecodeid, 
store_and_fwd_flag, 
pulocationid, 
dolocationid, 
payment_type, 
fare_amount, 
extra, 
mta_tax, 
tip_amount, 
tolls_amount, 
improvement_surcharge, 
total_amount)
from program 'cmd /c "type D:\Downloads\2018_Yellow_Taxi_Trip_Data.csv"' delimiter ',' csv header;
