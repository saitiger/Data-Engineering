- OLTP : Mostly utilized by Software Engineers for fast performance. Data is normalized and is mostly recent data
- OLAP : Used by data engineers, data scientists. Data is not normalized. 
         Optimized for queries including group by and aggregations
- Master Data : Sits between OLAP and OLTP. Data is deduplicated but not highly normalized

Cumulative Table Design 
- Advantages : 
1) Efficient historical analysis
2) Easy transition analysis ex - days since last activity, last inactivity etc.

- Disadvantages:
1) Backfilling is very expensive, since it has to be done sequentially
2) Handling PII can be messy since inactive,deleted users need to handled 

Struct vs Array vs Map 
Struct : 
1) Good compression 
2) Keys are rigidly defined i.e.
3) Values are heterogenous i.e can be of any type 

Map :
1) Compression is okay 
2) Keys are lossely defined
3) Values are homogenous i.e all have to be of the same type

Array:
1) List of values that are homogenous
2) Ordinal : Good for ordered dataset 
Arrays can contain other data structures for example an array of maps or an array of struct 

- *Run Length Encoding* 
1) Compresses data by storing the value and the count of consecutive duplicates, which is particularly 
   useful for temporal data

* Maintaining the order of data during joins is crucial for effective compression. If sorting is disrupted, it can lead 
to larger data sets than expected
Potential Fixes - 
1) Using arrays can help preserve sorting during joins 
2) Sorting after join to regain the order

- Parquet File Format 
