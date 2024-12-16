- Facts are where all the things can exist many times, dimensions are where they only exist once and are described.

Example (Credits r/PowerBI) : 
A product can exist many times in a (sales) fact table, but only once in the product dimension. 
A customer can appear many times in a fact table, but only once in the customer dimension table.

- Facts can be aggregated and turned into dimensions.
- Can use Case When to bucketize aggregated facts to reduce the cardinality.

Buckets should be informed from statistical distributions that percentiles, quantiles, most important i.e. Top most using
some filter and not random values.

 Dimensions 
 1. Usually show up in Group by when doing analytics
 2. Can be either high or low cardinality
 3. Generally come from a snapshot of a state

Facts
1. Usually aggregated when doing analytics using COUNT,SUM,AVG
2. Generated from events and logs most of the time
3. Almost always higher volume than dimensions

Example from Dataexpert.io {Credits : Zach Wilson}

Price of a night on Airbnb : 1. The host can set the price which sounds like an event 
2. It can easily be SUM,AVG, COUNT like regular facts 3. Prices on Airbnb are doubles, therefore extremely high cardinality 
4. The fact in this case is the host changing the setting the impacted price.
Note : Think fact has to be *logged*, a dimension comes from *state of things*. Price being derived from settings is a dimension

[DateList Int](https://www.linkedin.com/pulse/datelist-int-efficient-data-structure-user-growth-max-sung/)

Final Question : What should I model my data using : Fact or Dimension 
It depends on the situation, latency and the computing resources.
