Deduplication or any job can be done in 2 ways 

- Streaming 
1. In streaming the window size/windowing matters
2. 15 Minutes to hourly windows is the *sweet spot* because a large amount of duplicates usually happens within a short time
   of first event
3. Entire day duplicates can be harder for streaming because it needs to hold onto such a big window of memory

- Microbatch : Instead of running the script continously or the end of the data collection we run the ETL job
  after waiting for a certain amount of raw data to "pile up". Typically this between an hour to few days. Batch ETL jobs
  are generally run on a set schedule say 1 hour.

  Can think of this as mergesort. For example using the same deduplication example as streaming what can be done is take
  the data for one hour run the script for deduplication on it. Repeat till hour 24. Merge hour 1 & 2, 3 & 4 and so on.
  Now merge 1-2 with 3-4 to create 1-4 recursively do it for 5-6,7-8 for 5-8.... until 1-24 is obtained.

  When to use batch processing : 1. Data freshness is not a mission-critical issue
  2. When joining tables in relational databases 3. Have access to the data in batches rather than in streams
  3. When working with large datasets and require access to the entire batch 

  When to lean towards streaming : 1. Data is being generated in a continous stream and arriving at high velocity
  2. Sub-second latency is crucial
