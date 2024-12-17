Data Quality : 
1. Discoverable : Data discovery refers to the ability to find relevant data sets across your data platform and understand their context.
2. Quality checks
3. Duplicates
4. Nulls


- *Write Audit Publish (WAP)*
The idea is to have the data in the staging area, i.e., Have the pipeline write to the data stored in the staging table, which has the same schema as the production table. All the data quality checks are performed on this table. If the checks are passed 
the staging and production partitions are exchanged else we need to manually troubleshoot the data quality issue.
Note - Even if the data check is failed and the check is not blocking the partitions are exchanged. By blocking it means issues 
that impact downstream data or can cause big issues. Outliers and weird data are examples of checks which is not blocking.

- *Signal Table*
Instead of having a staging table in this pattern the pipeline writes to the production table. If all quality checks are passed then the data is written to a signal table else we need to manually troubleshoot the issue. Similar to the WAP pattern non blocking checks are not an issue in Signal table as well.
