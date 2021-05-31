# Assignment 4

### By: James Mancuso, Michael Velez, and Christian G. 

### 1. 

<!--
select count(distinct vendorid) as vendorid , count(distinct tpep_pickup_datetime) as tpep_pickup_datetime , count(distinct tpep_dropoff_datetime) as tpep_dropoff_datetime, 
count(distinct passenger_count) as passenger_count , count(distinct trip_distance) as trip_distance , count(distinct ratecodeid) as ratecodeid, count(distinct store_and_fwd_flag) as store_and_fwd_flag ,
count(distinct pulocationid) as pulocationid, count(distinct dolocationid) as dolocationid, count(distinct payment_type) as payment_type, count(distinct fare_amount) as fare_amount, 
count(distinct extra) as extra, count(distinct mta_tax) as mta_tax, count(distinct tip_amount) as tip_amount, count(distinct tolls_amount) as total_amount, 
count(distinct improvement_surcharge) as improvement_surcharge, count(distinct total_amount) as total_amount
from qcmath290.public.yellow_taxi_trip_data yttd
-->

<p>Question: What our code is doing is it's counting the distinct values within each column of the database. We are able to perform this query as 1 instead of 17 seperate queries because we are using commas to seperate our columns. Distinct is taking each UNIQUE value from  the column and when we use a count, we are counting the total rows we just obtained. Which will return the total unique values from the column.</p>

<p>Answer: What can you deduce from the row count obtained from hw03 and the distinct record counts obtained in this exercise?</p>


### 2.

<!--
select count(*) as distinct_observation_count from (select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount
from qcmath290.public.yellow_taxi_trip_data yttd) as sub_query;

Returns 102,804,099 distinct rows
-->

<p>Question: What can you deduce from these 3 key facts? Is there any single column in the dataset that could serve as the primary key? Is there any combination of columns that can serve as the primary key?</p>

<p>Answer: Based on the results of the 3 queries we've performed (total row count, distinct count for each column, distinct count for all columns combined), we've concluded that there is no unique primary key we can use in this dataset because none of the queries performed = the total amount of rows. This means that there is duplicates within the queries we've performed and primary keys cannot contain duplicates.</p> 

### 3. 

<!--
select count(*)
from qcmath290.public.yellow_taxi_trip_data yttd 
where passenger_count = 5

-->

<p>Question: How many rows have a "passenger_count" equal to 5? </p>
<p>Answer: 5,040,905 - By using the where clause, we were able to obtain all the rows where the passenger_count is 5 </p>

<!--
select count(*) from 
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where passenger_count > 3
-->

<p>Question: How many distinct trips have a "passenger_count" greater than 3?

<p>Answer: 9,415,989 - Because we had to account for distinct trips, we had to perform the sub-query again because we discovered duplicate trips within the dataset during the previous question. Once we've obtained all the distinct trips from our dataset we were able to perform a count on all the rows after applying our where clause condition (passenger_count > 3). </p>

<!--
select count(*)
from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
where tpep_dropoff_datetime between '2018-04-01 00:00:00' and '2018-05-01 00:00:00';
-->

<p>Question: How many rows have a tpep_pickup_datetime between '2018-04-01 00:00:00' and '2018-05-01 00:00:00'? </p>

<p>Answer: 9,310,583 - By using a where clause between the given dates we were able to obtain the total number of rides between those dates. 

<!--
select count(*) from 
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where tip_amount >= 5.00;
-->

<p>Question: How many distinct trips occurred in June where the tip_amount was greater than equal to $5.00? </p>

<p>Answer: 8,094,704 - Again, because we had to account for distinct trips we've performed a sub-query that obtains all the unique trips. Once that sub-query is completed we check for all rows that have a tip_amount >= $5.00 and then we count the total rows. </p>

<!--
select count(*) from 
(select distinct vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
passenger_count, trip_distance, ratecodeid, store_and_fwd_flag, pulocationid,
dolocationid, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge,
total_amount from qcmath290.public."2018_yellow_taxi_trip_data" yttd) as sub_query
where date_part('month', tpep_pickup_datetime) = 5 and tip_amount >= 2.00 and tip_amount <= 5.00;
-->

<p>Question: How many distinct trips occurred in May where the passenger_count was greater than three and tip_amount was between $2.00 and $5.00? </p>

<p>Answer: 2,652,352 - First we obtained all the distinct trips by performing our sub-query. Then after that, we had a few conditions for our where clause. Our 1st condition date_part('month', tpep_pickup_datetime) extracts the month from the current rows date (in the format YYYY-MM-DD) and if it's equivalent to our condition, it will be selected and counted. The second where clause checks for all tip_amounts that are greater than or equal to 2.00 and less than or equal to 5.00</p>


<!--
select sum(tip_amount) 
from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
-->


<p>Question: What is the sum of tip_amount in the 2018_Yellow_Taxi_Trip_Data dataset? (Hint: use the SUM() function to find the answer)</p>

<p>Answer: $210156392.48 - By using the aggregate function sum() we were able to obtain the total tips for all the rides. </p>

<p>Question: Can you assume that the answer to your previous question is equivalent to the question of "How much tip did taxi drivers collected in total in 2018?" Explain your answer.</p>

<p>Answer: No - The reason being is because many values for the tip_amount contain 0. Meaning that the tip was either not recorded or not given. If the tip was not recorded then this is NOT an accurate account for the total amount of tips that drivers received in 2018.</p>

### 4.
<p>Question: Take note of the base and the database folder's size associated with the database where 2018_Yellow_Taxi_Trip_Data is located.</p>

<p>Answer: base - 12.7 GB ---- 16395 (qcmath290 database id) - 12.7 GB</p>


<!--
delete from qcmath290.public."2018_yellow_taxi_trip_data" 
where vendorid = 2;

select count(*) from qcmath290.public."2018_yellow_taxi_trip_data" yttd 
-->

<p>Question: Explain why the size of the base and database folders changed as a result of the delete statement.</p>

<p>Answer: 47,518,091 - After running the delete from statement with the where clause vendorid = 2, we removed all rows that had a vendorid value of 2.</p>

<p>Question: Explain why the size of the base and database folders changed as a result of the delete statement. </p>

<p>Answer: It didn't. We suspect that the reason it did not change is due to the fact the UPDATE and DELETE does NOT immediately remove the old version of the row.</p>


### 5.

<!--
VACUUM FULL;
-->

<p>Question: Inspect the size of the base and database folders. Can you explain what happened?</p>

<p>Answer: Base - 6.39 GB ---- 16395 - 5.37 GB. The rows we've deleted are now no longer claimed and the disk space that was once occupied can now be reclaimed for reuse if we want to import new rows.</p>

### 6. 
<!--
truncate table qcmath290.public."2018_yellow_taxi_trip_data" 
-->

<p>Question: Truncate the table 2018_Yellow_Taxi_Trip_Data and re-import the 2018_Yellow_Taxi_Trip_Data.</p>

<p>Answer: By truncating the table, we delete all the data inside the table but the table schema remains.</p>

