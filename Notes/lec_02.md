- # [[IT-Högskolan/course/databases]] [[lecture]] [[2]] - [[SQL]]
  #databases
	- how to [[read]] from a [[table]] #card
		- using the [[select]] command
		- ``` SQL
		  SELECT ... FROM table_name
		  ```
	- how to add a row to an existing [[table]] #card
		- using insert into
		- ``` SQL
		  INSERT INTO table_name (column_name_1, ..., column_name_n) VALUES (value_1, ..., value_n)
		  ```
		- condition: table_name must already exist
	- how to create a new [[table]] from rows read from an existing table #card
		- using select into
		- ``` SQL
		  SELECT k1, ..., kn INTO table_new FROM table_existing
		  ```
		- condition: table_new must not already exist
	- how to add the entire result of a select expression into an existing table #card
		- using insert into select from
		- ```SQL
		  INSERT INTO Users (Username, Password)
		  SELECT Name, Age FROM People;
		  ```
		- condition: table Users must already exist
		- add values from the name and age columns into the users table under username and password respectively
		  (username will get the name value of the person, password will get the age value of the person)
	- what does not get added when copying a table using select into #card
		- keys
		- for example if an ID column has a primary key it will not be added to the copied table
	- how to add [[primary key]] to an existing [[table]] using [[Microsoft SQL Server Management Studio]] #card
		- open table in design view (right click table -> design)
		- right click column
		- select add primary key
		- refresh table for changes to appear
	- what does CRUD mean #card
		- create, read, update, delete
	- how to change the value of a row #card
		- using update (together with a where statement to select specific rows)
		- ```SQL
		  UPDATE table_name SET c1 = v1, ..., cn = vn WHERE condition
		  ```
	- how to remove rows from a table #card
		- using delete
		- ```SQL
		  DELETE FROM table_name WHERE condition
		  ```
	- how to create a new table #card
		- using create table
		- ```SQL
		  CREATE TABLE table_name (
		  	col_1 datatype,
		    	...
		    	col_n datatype
		  )
		  ```
	- how to remove all rows from a table #card
		- using truncate
		- ```SQL
		  TRUNCATE TABLE table_name
		  ```
	- how to remove a table #card
		- using drop table
		- ```SQL
		  DROP TABLE table_name
		  ```