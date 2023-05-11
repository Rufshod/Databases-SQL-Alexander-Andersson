- # [[IT-Högskolan/course/databases]] [[lecture]] [[8]] - [[Design]] and [[Administration]]
  #databases
	- what is data integrity #card
		- ensuring the database is correct, without errors, gaps, or contradictions
		- ensured by using constraints
	- TODO datatypes
		- ASCII (1 byte per char)
			- char -- fixed size
			- varchar -- variable size (floating point precision?)
		- Unicode (at leas 2 bytes per char)
			- nchar -- fixed size
			- nvarchar -- variable size (floating point precision?)
	- when to use the constraint unique #card
		- a table can only have one primary key, if more are wanted they can be set as unique and not null
		- if you want something like a primary key while allowing null values
	- can a primary key be set on multiple columns at once #card
		- there can only be one primary key per table, but that primary key can include multiple columns, in which case it requires a unique combination of the values in those columns where none of the values are allowed to be null
	- what datatype cannot be used as primary key #card
		- nvarchar(max) and varchar(max)
	- how to make a composite key #card
		- add the following code when creating a table, below the column names
		- ```SQL
		  CONSTRAINT PK_TableName PRIMARY KEY (Col1, Col2)
		  ```
	- how to make a foreign key #card
		- add the following code when creating a table, below the column names
		- ```SQL
		  CONSTRAINT FK_Table1_Table2 FOREIGN KEY (ID) REFERENCES Table2(ID)
		  ```
	- does PK and FK allow null by default #card
		- PK does not allow null
		- FK does allow null (can be changed by setting notnull)
	- TODO update rules and delete rules
		- No Action, Cascade, Set Null, Set Default
		- cascade updates tables pointed to
			- for example updating primary key will update all connected foreign keys, other way true as well?
		- update and delete rule to null
			- when updating PK all FK connected to it will be set to null
		- pros and cons of cascade rules
			- easier to update connected tables
			- easier to accidentally deleting/changing more than intended
	- how to add a custom constraints to a column #card
		- using the check function either after declaring the column, or below the columns under CONSTRAINT
		- ```SQL
		  Name nvarchar(max) CHECK(LEN(Name) > 5) -- in same line as declaring column
		  CONSTRAINT Age CHECK(Age >= 0) -- under constraint below all columns
		  ```
	- how to set default column values #card
		- using the default keyword when declaring column
		- ```SQL
		  Date DATETIME DEFAULT(GETDATE()) -- by default set date to current date
		  ```
	- what are views #card
		- works like a table but does not contain any data of its own, instead fetches the queried data from a table
		- found under views subfolder of database
	- what are 3 pros of using views over tables #card
		- avoid writing the same query multiple times
		- avoid storing same data multiple times
		- view results are changed when table data is changed and vice versa
	- important to keep in mind when using views #card
		- updating data in a view updates data in the table it fetches from
	- can CRUD operations be used in views #card
		- if view columns are the same as table columns all operations can be used
		- if view columns differ from table columns only read operations can be used
			- delete can be used if a view column is created from table columns as it can work backwards to understand which rows to delete by deconstructing the view column value into the original column values
	- how to change an existing table, view, or database #card
		- using alter
	- base rule when designing databases #card
		- one type of item per table and one of those items per row
		- for example, books:
			- a table contains books (not books and authors) and each row contains information about one book
			- the table should only contain information **directly** connected to the books
	- what is normalization #card
		- the process of adapting talbes to normal forms
		- normal forms are conditions a table can fulfill
		- the first and most simple normal form is called 1NF, then 2NF, 3NF etc
	- why should you use normal forms #card
		- the main reason of normalizing tables is to remove redundant data that affects the database's integrity and performance
	- what is the first [[normal form]] #card
		- 1NF = the table contains atomic values - one value per cell
	- what is functional dependence #card
		- if the value of one (or multiple) attribute A singlehandedly decides the value of a different attribute B, then B is functionally dependent of A (A -> B)
		- for example, books:
			- | Title | Type | Pages | Price |
			  | --- | --- | --- | --- |
			  | Book1 | Bound | 100 | 299 |
			  | Book1 | Pocket | 100 | 199 |
			  | Book2 | Bound | 250 | 249 |
			  | Book2 | Pocket | 250 | 149 |
			- Pages is functionally dependent of Title (Pages -> Title), which is to say that if we have the title we know the number of pages
			- functional dependencies:
				- Title -> Pages
				- (Title, Type) -> Price
	- what is the second [[normal form]] #card
		- 2NF = 1NF + no partial dependence
			- no (non-key) values depend on the entirety of each candidate key
			- TODO what is a candidate key
			- TODO partial dependence = functional dependence?
	- what is the third [[normal form]] #card
		- 3NF = 2NF + no non-key attribute can be dependent of any other non-key attribute
	- a good consideration about [[normal form]]s when designing databases #card
		- every attribute should represent one fact about the key, the entire key, and nothing but the key