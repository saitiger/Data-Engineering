Used along with group by the following three help in making the analysis faster and easier when aggregation needs to be done on 
multiple groups 

*Grouping Sets* 
Helps us group sets based on our choices, can use multiple grouping items per set and multiple sets. 
Example 
GROUP BY 
grouping sets((Continent,Country),(City),(Country,City))

*Cube*
Gives all the combinations for the columns mentioned 
Example - (Continent, Country, City) 
We get 3! = 6 combinations 

*Rollup*
Gives combinations in the order of the columns
Example - (Continent, Country, City)
Groups :
Continent
Continent,Country
Continent,Country,City 
None
