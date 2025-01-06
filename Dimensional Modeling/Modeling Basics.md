- OLTP : Mostly utilized by Software Engineers for fast performance. Data is normalized and is mostly recent data
- OLAP : Used by data engineers, data scientists. Data is not normalized. 
         Optimized for queries including group by and aggregations
- Master Data : Sits between OLAP and OLTP. Data is deduplicated but not highly normalized

Cumulative Table Design 

Two core dataframes : 
1. Today 2. Yesterday {Full outer join the two tables to capture all information. Coalesce to retain data}

**__Note__**
a. Coalesce Id's and unchanging dimensions 

b. Compute cumulation metrics (Days since.., Last online.. etc.)

c. Combine arrays and changing values 

d. Have a filter and termination condition : For example retain data for 180 days/ 1 Year based on the business needs 

- Advantages : 
1) Efficient historical analysis
   
2) Easy transition analysis ex - days since last activity, last inactivity etc.

- Disadvantages:
1) Backfilling is very expensive since it has to be done sequentially i.e. fill day before yesterday, yesterday, today and so on.. 
   
2) Handling PII can be messy since inactive, deleted users need to be handled 

Struct vs Array vs Map 
Struct : 
1) Good compression 
2) Keys are rigidly defined i.e. Need to be the same number and data type in each row
3) Values are heterogenous i.e can be of any type 

Map :
1) Compression is okay 
2) Keys are lossely defined i.e. Can vary on each row 
3) Values are homogenous i.e all have to be of the same type

Array:
1) List of values that are homogenous
2) Ordinal : Good for ordered dataset 
Arrays can contain other data structures for example an array of maps or an array of struct

[Reference](https://stackoverflow.com/questions/73426292/what-is-the-difference-of-struct-and-maptype-and-how-to-add-fields-on-a-struct) 

- *Run Length Encoding* 
1) Compresses data by storing the value and the count of consecutive duplicates, which is particularly 
   useful for temporal data

* Maintaining the order of data during joins is crucial for effective compression. If sorting is disrupted, it can lead 
to larger data sets than expected
Potential Fixes - 
1) Using arrays can help preserve sorting during joins
   
   Before joining we store the data using an array, once the join has occurred explode the array to regain all the data.
   
2) Sorting after join to regain the order

- Parquet File Format 
[Reference Video](https://www.youtube.com/watch?v=hFFP2OYFlTA&ab_channel=DatawithZach) 
