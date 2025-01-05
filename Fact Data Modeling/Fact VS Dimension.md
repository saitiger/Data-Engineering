- Facts vs Dimensions

  1 Dimensions are attributes of an entity {Example favorite feature, address of the user }
  2 Facts are not slowly changing, Dimensions can be either slowly changing or fixed 
  3 Facts are usually 10-100 times in volume in comparison to dimensions
  4 Facts need a lot of context for effective analysis
  5 Duplicates are more common in facts as compared to dimensions

- Normalized vs De-normalized Facts

- Who,Where,What,When,How

1 'WHO' : To identify the entity, user etc. {Example - This user clicked the button, collected using user_id}

2 'WHERE' : Can be location, where on the page etc. Modeled out like Who with "Ids" to join

3 'HOW' : Very similar to Where but this models how was the data collected for example the user (WHO) clicked the button on     an iPhone(HOW) at the landing page(WHERE).

4 'WHAT' : Part of the nature of the fact. Example in notifications it is 'Clicked','Sent','Delivered'

5 'WHEN' : Timestamp, Date when the event occurred 

Fact Modeling should have some quality checks including but not limited to 
1) Removing the duplicates
2) Should be smaller than raw logs
3) Should parse out hard-to-understand columns

- Broadcast Join : Broadcast Join is an optimization technique used in Spark SQL engine to improve performance by reducing data shuffling between a large and smaller dataframe during traditional joins. It is utilized when one of the DataFrames is small enough to be stored in the memory of all executor node

- Logging brings in the context for the fact data. An important thing to remember is that we should only log things that we
  really need.

- Potential options when working with high volumes fact data
  1 Sampling
  Doesn't work for all use cases, but works best for metric-driven use cases where imprecision isn't an issue.
  For example, when doing an A/B test and we want to see the costs of the infrastructure for the control and treatment group
  sampling can be done to see the price difference but this would not work 
  
  2 Bucketing
  Fact data can be bucketed by one of the important dimensions (usually user)
  Bucket joins can be much faster than shuffle joins
  Sorted-merge Bucket (SMB) join can do joins without Shuffle at all  
