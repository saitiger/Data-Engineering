How to fix Skew and Out of Memory 
1. Upgrade to Spark 3 and enable adaptive execution {[Read More](https://medium.com/@diehardankush/what-is-understanding-adaptive-query-execution-in-spark-3-1fcc0aa7ab9e)}
2. Increase the executor memory
3. Skew Join Salt {[Read More](https://medium.com/curious-data-catalog/sparks-salting-a-step-towards-mitigating-skew-problem-5b2e66791620)}

Missing Data/ Schema Change 
1. Prechecking upstream data : Prevents running the pipeline if it's missing data {Run quality checks before running the pipeline}
2. Track down the upstream owner : Raise a ticket to have the third party fix the issue {Required when the api/service is owned by a third party}

**__Backfill Do's and Dont's__**

For smaller migration 
- Do a parallel backfill into table_backfill
- If everything looks good execute swap
  a. Rename production to production_old
  b. Rename table_backfill to production

For bigger migration 
- Build a parallel pipeline that populates table_v2 while production gets migrated
- After all references to production have been updated, drop production and rename table_v2, all it's references to production
