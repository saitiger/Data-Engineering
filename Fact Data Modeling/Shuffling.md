Shuffling is a big bottleneck for parrallelism in processing big data. So it is important to reduce shuffling.

Classification of SQL commands :

- Extremely Parallel: SELECT,FROM,WHERE
- In the Middle : GROUP BY, JOIN, HAVING
{We need to have all data to be present at one machine for join, aggregation using GROUP BY
which is the reason for low parallelism}
- Painfully not Parallel : ORDER BY

How to make GROUP BY more efficient 
1. Give GROUP BY some buckets and guarantees
2. Reduce the Data Volumes as much as possible

How to reduce the Data Volume 
1. Aggregate on a daily level
2. Monthly/Yearly aggregate : 
Aggregate on a monthly/ year level and instead of having 30/365 rows for each day have one list of list/ map of
list that stores the value from the starting date to the end date. Starting and end date are columns in each row.

Refer to [Datelist](https://www.linkedin.com/pulse/datelist-int-efficient-data-structure-user-growth-max-sung/) for the list/map of list 
