*Aggregation Based Analysis*

  - Upstream data should be/ is often on a daily grain that is aggregated on "daily metrics"
    - Helps with experimentation as it allows to split users into groups of treatment,control and more
    - Better performance as shuffles are less and optimized
  - Don't include a lot of dimension since that essentially is fact data again
  - Small groups don't matter a lot in most cases (Think the pareto principle)
  - Along with percentage look at the raw counts
  - For time based analysis look at weekly, monthly data to reduce the cardinality

*Cumulation-based Patterns*
- Full outer joins is handy for this pattern
- Common use cases : 1. State change tracking 2. Survival Analysis

*Growth Accounting*
One of the use cases is monitoring health of the machine learning model

1. New : Didn't exist yesterday, Active today 
2. Retained : Active yesterday, Active today
3. Churned : Active yesterday, Inactive today
4. Resurrected : Inactive yesterday, Active today
5. Stale : Inactive yesterday, Inactive today 
6. Deleted : User who has deleted the account

   
