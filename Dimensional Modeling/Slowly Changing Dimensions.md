- Idempotent pipelines are those that produce the same result no matter how many times, at what time they are executed. 

Common causes of failure :
1. Insert Into : Creates duplicate, instead use MERGE or INSERT OVERWRITE or INSERT INTO with TRUNCATE
2. Using start_date> without a corresponding end_date< condition i.e need to bound the range
3. Not using a full set of partition sensors
4. Relying on the latest partition of a not properly mananged SCD table

**__Slowly Changing Dimension__**
SCD is an attribute that drifts/changes over time Example- age,weight

Type 0 : Value doesn't change example - Birthdate. Is idempotent

Type 1 : Only stores the latest value. Problem arises when backfilling as we lose historical values

Type 2 : Dimension values between START_DATE and END_DATE, boolean IS_CURRENT column to identify the latest/current value

Type 3 : Holds only two values, original and current/latest.

How to decide if to model as SCD??

If the attribute is significantly slowly changing (depends on the business scenario) but anything over 15/20 days in general 
then modeling as SCD has optimizes space and time complexity.
