1. Pre-aggregate the data : Grouping Sets come in handy here
2. Avoid Joins on the FLY : Can be done if JOIN is tiny, even if one side is tiny else should be avoided
3. Use a low-latency storage like Druid instead of directly querying from a higher-latency storage like S3

Dashboard Best Practices : 
1. Have one story to tell
2. Always remember who is the customer/end user

   a. Execs : Should be easy to understand, no to low interactivity

   b. Analysts : More charts, more density, ability to slice and dice
   
3. Questions to answer

   a. Top-line Questions
   
   b. Trends

   c. Composition
