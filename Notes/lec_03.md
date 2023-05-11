- # [[IT-Högskolan/course/databases]] [[lectures]] [[3]] - [[SQL]]
  #databases
	- what is grouping #card
		- combining rows based on common values of the column used to group by
		- for example GROUP BY Country will group data on each separate country
		- aggregation functions can then be used to get combined data for each group
	- what is aggregation #card
		- combining multiple datapoints to get an overview of data
		- not just grouping data, but getting measurements such as mean, total, etc
	- what is an aggregation funcion #card
		- a function that:
			- 1. takes a list of values
			  2. makes a calculation
			  3. returns a value
	- what are some aggregation functions #card
		- SUM()
		- AVG()
		- MIN()
		- MAX()
		- COUNT()
		- STDEV()
		- STRING_AGG()
	- does the count() function include NULL values #card
		- no
		- using count on a column with 100 rows where 10 values are null will return 90
	- what does the function string_agg() do #card
		- aggregates strings with a given separator
		- example:
			- ```SQL
			  string_agg(letters, ', ') -- > 'A, B, C, D, E ...'
			  ```
			- takes all values in the selected column
			- combines them into a single string using the specified separator
			- in this case values of the column named 'letters' separated by comma and space
	- when is having used #card
		- when a condition is used on a group
		- where cannot be used since it is used to filter rows before grouping
		- having is used instead of where to allow for both types of filtering
		- example:
			- ```SQL
			  SELECT Country,
			  	count(City),
			      sum(Population)
			  FROM
			  	MyTable
			  WHERE
			  	Population > 1000000
			  GROUP BY
			  	Country
			  HAVING
			  	count(City) > 3
			  ```
	- what is identity seed #card
		- what identity starts counting from
	- what is identity increment #card
		- how much identity adds to every new number
	- how to create an id column which is a primary key with identity #card
		- ```SQL
		  id int primary key identity(1, 1) -- 1, 1 is for increment and seed respectively
		  ```
	- how to declare a variable #card
		- ```SQL
		  DECLARE @variable_name as datatype = value
		  ```