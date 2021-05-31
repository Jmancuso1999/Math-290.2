# Assignment 5 

## James Mancuso, Michael Valez, Christian G.

### Note: We are using the 2018 yellow taxi fare dataset

### 1. Download and install PowerBI Desktop and create an AWS account.

<p>Completed. </p>

### 2. 

<!--
- #2
- CTE
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
-->

<p>Question: Calculate the number of trips by vendorID by hour(based on drop_off_date) in 2018.</p>
<p>Answer:</p>
<p>
|hour|vendorid|number_of_trips| <br>
|----|--------|---------------| <br>
|0.0|1|1545168| <br>
|0.0|2|2301456|<br>
|0.0|4|17896|<br>
|1.0|1|1077232|<br>
|1.0|2|1564124|<br>
|1.0|4|13213|<br>
|2.0|1|768638|<br>
|2.0|2|1078835|<br>
|2.0|4|9295|<br>
|3.0|1|553990|<br>
|3.0|2|756240|<br>
|3.0|4|6345|<br>
|4.0|1|453980|<br>
|4.0|2|590829|<br>
|4.0|4|4609|<br>
|5.0|1|450733|<br>
|5.0|2|560614|<br>
|5.0|4|4134|<br>
|6.0|1|978066|<br>
|6.0|2|1246595|<br>
|6.0|4|9719|<br>
|7.0|1|1585030|<br>
|7.0|2|2170587|<br>
|7.0|4|16522|<br>
|8.0|1|2023211|<br>
|8.0|2|2844738|<br>
|8.0|4|20759|<br>
|9.0|1|2149925|<br>
|9.0|2|3062495|<br>
|9.0|4|22225|<br>
|10.0|1|2148227|<br>
|10.0|2|3057874|<br>
|10.0|4|22762|<br>
|11.0|1|2209009|<br>
|11.0|2|3107069|<br>
|11.0|4|23546|<br>
|12.0|1|2410538|<br>
|12.0|2|3297580|<br>
|12.0|4|25257|<br>
|13.0|1|2482789|<br>
|13.0|2|3275742|<br>
|13.0|4|25403|<br>
|14.0|1|2579429|<br>
|14.0|2|3358793|<br>
|14.0|4|26955|<br>
|15.0|1|2681643|<br>
|15.0|2|3412157|<br>
|15.0|4|26826|<br>
|16.0|1|2525026|<br>
|16.0|2|3196613|<br>
|16.0|4|23386|
|17.0|1|2660184|<br>
|17.0|2|3476928|<br>
|17.0|4|25787|<br>
|18.0|1|3020239|<br>
|18.0|2|4161958|<br>
|18.0|4|30537|<br>
|19.0|1|2976105|<br>
|19.0|2|4197505|<br>
|19.0|4|31275|<br>
|20.0|1|2645477|
|20.0|2|3736868|<br>
|20.0|4|28327|<br>
|21.0|1|2560348|<br>
|21.0|2|3655976|<br>
|21.0|4|27219|<br>
|22.0|1|2465289|<br>
|22.0|2|3563531|<br>
|22.0|4|26648|<br>
|23.0|1|2076064|<br>
|23.0|2|3041428|<br>
|23.0|4|23106|<br>
</p>

<p>Question: What was the daily(based on drop_off_date) mean, median, minimum, and maximum number of trips by vendorID in 2018? </p>

<p>Answer: Sample of the data" <br>
|drop_off_date|vendor_id|min_cnt_trip|mean_cnt_trip|median_cnt_trip|max_cnt_trip| <br>
|-------------|---------|------------|-------------|---------------|------------| <br>
|2018-01-01 00:00:00|1|1388|3988.0416666666666667|4296.5|8359| <br>
|2018-01-01 00:00:00|2|1969|5828.0416666666666667|6306.0|10894| <br>
|2018-01-02 00:00:00|1|375|4309.9166666666666667|5304.5|7611| <br>
|2018-01-02 00:00:00|2|579|5612.6666666666666667|6973.0|10024| <br>
|2018-01-03 00:00:00|1|561|4925.4166666666666667|5983.0|8194| <br>
|2018-01-03 00:00:00|2|633|6189.4583333333333333|7575.5|10851| <br>
|2018-01-04 00:00:00|1|634|2046.8333333333333333|2244.5|2933| <br>
|2018-01-04 00:00:00|2|676|3078.7916666666666667|3345.5|4383|<br>
|2018-01-05 00:00:00|1|391|4662.0833333333333333|5462.5|8229|<br>
|2018-01-05 00:00:00|2|649|6289.7500000000000000|7542.5|11123|<br> 
|2018-01-06 00:00:00|1|962|5023.9166666666666667|5610.5|8107|<br>
</p>

<p>Question: What is the mean, median, minimum, and maximum trip_distance by vendor between 5:00 and 6:00 AM (not including 6:00 AM)?</p>

<p>Answer: </p>
<p>
|vendor_id|min_cnt_trip|mean_cnt_trip|median_cnt_trip|max_cnt_trip| <br>
|---------|------------|-------------|---------------|------------| <br>
    1	       330	   1234.88	  1145.0	3926 <br>
    2	       481	   1535.85	  1431.0	5040 <br>
    4	        1	   26.50          30.0	        58</p>

<p>Question: What day in 2018 had the least / most amount of unique trips?</p>

<p>Answer: Answer: Least: 2018-01-04 00:00:00- 122,222 ---- Most: 2018-03-16 00:00:00- 349,840</p>

### 3.

<!--
with tip_percentage_CTE as (
	select (avg(tip_amount/total_amount)*100) as average_tip_percentage from
	(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
	passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
	dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
	total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
	where total_amount > 0
	), 
	tip_percentage_hourly_CTE as (
	select extract (hour from tpep_dropoff_datetime) as drop_off_hour_of_day, (avg(tip_amount/total_amount)*100) as average_tip_percentage from
	(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
	passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
	dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
	total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
	where total_amount > 0
	group by extract (hour from tpep_dropoff_datetime)
	order by extract (hour from tpep_dropoff_datetime) asc)

    select * from tip_percentage_CTE;
    --select * from tip_percentage_hourly_CTE;
-->

<p>Question: What was the average tip percentage (tip_amount/total_amount) 

<p>Answer: 10.6% - First we had to account for the distinct trips, so we removed the duplicates first. Then once we completed that we were able to use the aggregate function average to calculate the average tip percentage.</p>

<p>Question: What was the average tip percentage by drop off hour for unique trips in 2018?</p>

<p>Answer:</p>
- 00:00 - 10.75% <br>
- 01:00 - 10.55%<br>
- 02:00 - 10.29%<br>
- 03:00 - 9.70%<br>
- 04:00 - 8.52%<br>
- 05:00 - 8.89%<br>
- 06:00 - 10.00%<br>
- 07:00 - 11.05%<br>
- 08:00 - 11.43%<br>
- 09:00 - 11.18%<br>
- 10:00 - 10.60%<br>
- 11:00 - 10.32%<br>
- 12:00 - 10.29%<br>
- 13:00 - 10.17%<br>
- 14:00 - 10.17%<br>
- 15:00 - 10.15%<br>
- 16:00 - 10.15%<br>
- 17:00 - 10.46%<br>
- 18:00 - 10.79%<br>
- 19:00 - 10.97%<br>
- 20:00 - 11.20%<br>
- 21:00 - 11.30%<br>
- 22:00 - 11.27%<br>
- 23:00 - 11.04%<br>

<!--HAVING avg(tip_amount/total_amount) > 0 -->

### 4.

<!-- 
select ROUND(trip_distance) as trip_distance, (avg(tip_amount/total_amount)*100) as average_tip_percentage from
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where total_amount > 0
group by ROUND(trip_distance) 
order by ROUND(trip_distance) desc;
-->

<p>Question: Do longer trips have higher tip percentages?</p>

<p>Answer: No. There is no correlation between the distance of the trips and tips that the taxi drivers receive. </p>

<!--
create view daily_tip_percentage_by_distance
as
SELECT tpep_dropoff_datetime as "date",trip_distance as trip_mileage_band, (avg(tip_amount/total_amount)*100) as tip_percentage, 
	   CASE WHEN trip_distance >= 0 and trip_distance < 1 then '0-1 mile'
            WHEN trip_distance >= 1 and trip_distance < 2 then '1-2 mile'
            WHEN trip_distance >= 2 and trip_distance < 3 then '2-3 mile'
            WHEN trip_distance >= 3 and trip_distance < 4 then '3-4 mile'
            WHEN trip_distance >= 4 and trip_distance < 5 then '4-5 mile'
            WHEN trip_distance >= 5 then '5+ mile'
            END as trip_distance
from qcmath290.public."2018_yellow_taxi_trip_data" yttd
where total_amount > 0
group by tpep_dropoff_datetime, trip_distance 
order by tpep_dropoff_datetime, trip_distance asc;

select * from daily_tip_percentage_by_distance 
-->

<p>Question: Create a view called daily_tip_percentage_by_distance</p>

<p>Answer: SQL code in .sql file.</p>

