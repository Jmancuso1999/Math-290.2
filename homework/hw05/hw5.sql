-- #2
-- CTE
with numberTrips_CTE as (
		select date_trunc('hour', tpep_dropoff_datetime) as drop_off_date, vendorid as vendor_id, count(vendorid) as number_of_trips
		from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
		where extract (year from tpep_dropoff_datetime) = 2018
		group by 1, vendorid
		order by 1 asc
	),
	
	dailyNumbers_CTE as (
		select date_trunc('day', drop_off_date) as drop_off_date, vendor_id, min(number_of_trips) as min_cnt_trip, avg(number_of_trips) as mean_cnt_trip, 
		percentile_cont(0.5) WITHIN GROUP (ORDER BY number_of_trips) as median_cnt_trip, max(number_of_trips) as max_cnt_trip 
		from numberTrips_CTE
		group by 1, vendor_id 
		order by 1 asc
	),
	
	betweenTime_CTE as (
		select vendor_id, min(number_of_trips) as min_cnt_trip, avg(number_of_trips) as mean_cnt_trip, 
		percentile_cont(0.5) WITHIN GROUP (ORDER BY number_of_trips) as median_cnt_trip, max(number_of_trips) as max_cnt_trip  
		from numberTrips_CTE
		where extract(hour from drop_off_date) = 5 
		group by 1
	)
	
	select * from betweenTime_CTE


with distinct_CTE as (
		select distinct * 
		from qcmath290.public."2018_yellow_taxi_trip_data" yttd
		where extract (year from tpep_pickup_datetime) = 2018
	),
	distinct_day_CTE as (
		select date_trunc('day', tpep_pickup_datetime) as "day", count(*) as unique_trips
		from distinct_CTE
		group by 1
	),
	least_CTE as (
		select "day" as "Lowest Day", unique_trips as min_trips_2018
		from distinct_day_CTE
		where unique_trips in
			(select min(unique_trips) 
			from distinct_day_CTE)
		order by 1 asc 
		fetch first row only
	),
	
	most_CTE as (
		select "day" as "Largest Day", unique_trips as max_trips_2018
		from distinct_day_CTE
		where unique_trips in
			(select max(unique_trips) 
			from distinct_day_CTE)
		order by 1 asc 
		fetch first row only
	)
	
	select * from most_CTE
	


-- #3
-- CTE
with tip_percentage_CTE as (
		select (avg(tip_amount/total_amount)*100) as average_tip_percentage from
			(select distinct * 
			from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
		where total_amount > 0
	), 
	
	tip_percentage_hourly_CTE as (
		select extract (hour from tpep_dropoff_datetime) as drop_off_hour_of_day, (avg(tip_amount/total_amount)*100) as average_tip_percentage from
			(select distinct * 
			from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
		where total_amount > 0
		group by extract (hour from tpep_dropoff_datetime)
		order by extract (hour from tpep_dropoff_datetime) asc
	)
	
    select * from tip_percentage_CTE;
    --select * from tip_percentage_hourly_CTE;


-- #4
select ROUND(trip_distance) as trip_distance, (avg(tip_amount/total_amount)*100) as average_tip_percentage from
	(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
	passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
	dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
	total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where total_amount > 0
group by ROUND(trip_distance) 
order by ROUND(trip_distance) desc;


create view daily_tip_percentage_by_distance
as
SELECT trip_distance as trip_mileage_band, (avg(tip_amount/total_amount)*100) as tip_percentage, 
	   CASE WHEN trip_distance >= 0 and trip_distance < 1 then '0-1 mile'
            WHEN trip_distance >= 1 and trip_distance < 2 then '1-2 mile'
            WHEN trip_distance >= 2 and trip_distance < 3 then '2-3 mile'
            WHEN trip_distance >= 3 and trip_distance < 4 then '3-4 mile'
            WHEN trip_distance >= 4 and trip_distance < 5 then '4-5 mile'
            WHEN trip_distance >= 5 then '5+ mile'
            END as trip_distance
from qcmath290.public."2018_yellow_taxi_trip_data" yttd
where total_amount > 0
group by trip_mileage_band 
order by trip_mileage_band asc;

select * from daily_tip_percentage_by_distance 
