Data Quality : 
1. Discoverable

Write Audit Publish (WAP) 
The idea is to have the data in the staging area, i.e., Have the pipeline write to the data stored in the staging table, which has the same schema as the production table. All the data quality checks are performed on this table. If the checks are passed 
the staging and production partitions are exchanged else we need to manually troubleshoot the data quality issue.
Note - Even if the data check is failed and the check is not blocking the partitions are exchanged. By blocking it means issues 
that have an impact on downstream data or can cause big issues. Outliers and weird data are examples of checks which is not blocking.
