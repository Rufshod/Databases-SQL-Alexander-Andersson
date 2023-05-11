- # [[IT-Högskolan/course/databases]] [[lecture]] [[5]] - [[SQL]]
  #databases
	- how to use a subquery in a query #card
		- write the subquery in parentheses within the query
		- ```SQL
		  SELECT
		  	something,
		      (SELECT something_else FROM table_B)
		  FROM
		  	table_A
		  ```
	- what datatype does the format function return #card
		- string
		- the format function always casts to a string
	- what datatype is the same as real #card
		- float(24)
	- what sets decimal and float datatypes apart #card
		- decimal has fixed point precision while float has floating point precision
		- decimal can be specified to have a specific number of digits, both to the left and right of the decimal point
		- decimal is typically faster but loses the dynamic nature of a float
	- when writing a date like 'yyyy-mm-dd' what is the time #card
		- 00:00:00
	- how to get the quarter of a date #card
		- using datepart
		- ```SQL
		  DATEPART(QUARTER, Your_Date) --> 1, 2, 3, 4
		  ```
	- how to get the ascii value of a character #card
		- ascii(character)
	- how to get the character of an ascii value #card
		- char(value)
	- how to access data from multiple databases at once #card
		- ```SQL
		  [Database].[Schema].[Table]
		  ```
		- defaults:
			- database = active database
			- schema = dbo
	- how to change the active database #card
		- ```SQL
		  USE Database_name;
		  ```
		- selected database remains as the active database until changed
	- what is collation #card
		- setting for language, sorting, sensitivity
		- for example case sensitive or not, sorting on characters from a specific language, date formats
	- what is a global variable #card
		- a variable set automatically by the server
		- typically current or latest value of something
		- for example amount of rows in the last expression
	- how to disable showing rows affected in messages #card
		- ```SQL
		  SET NOCOUNT ON;
		  ```
	- when to print instead of select #card
		- when you want debug or information messages in a separate window from selected tables
		- for example if selecting multiple tables, a small informational selection might be easy to miss, in that case it is better to use print to get the message in a separate window
	- what are some configuration variables #card
		- TODO finish card info
		- nocount
		- statistics -
		- showplan - does not execute but instead shows analysis of how
		- ```SQL
		  SET NOCOUNT { ON | OFF };
		  SET STATISTICS TIME { ON | OFF };
		  SET SHOWPLAN_XML { ON | OFF };
		  ```
	- system databases contains #card
		- tempdb
		- master
		- model
		- msdb
	- what is tempdb in system databases #card
		- contains temporary tables
	- what is master in system databases #card
		- holds information about what databases exist, and all server configuration
	- what is model in system databases #card
		- contains default template for new databases
		- can for example create folders or functions to be included in every new database by default
	- what is msdb in system databases #card
		- used for 2 processes:
			- TODO what was the other one
			- SQL Server Agent
	- what is SQL Server Agent #card
		- used for scheduling jobs to the server
		- for example run this script once an hour
	- TODO what is XML
	- TODO what is FTP