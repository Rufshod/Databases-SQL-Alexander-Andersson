	SELECT * FROM MoonMissions

-- SPACE, Excercise 1
SELECT 
	[Spacecraft], 
	[Launch date],
	[Carrier rocket],
	[Operator],
	[Mission type]
INTO 
	SuccessfulMissions
FROM 
	MoonMissions
WHERE [Outcome] = 'Successful'

GO

UPDATE 
	SuccessfulMissions 
SET 
	Operator = TRIM('   ' FROM [Operator]) FROM SuccessfulMissions;

GO

Update SuccessfulMissions
SET Spacecraft = LEFT(Spacecraft, Charindex('(' , Spacecraft) -1)
Where Charindex('(', Spacecraft) > 0
--https://stackoverflow.com/questions/1668014/sql-server-replace-remove-all-after-certain-characterGO

GO

-- Skriv en select, Som tar ut och grupperar, samt sorterar på kollumnerna
-- Operator, Mission type FRÅN Succesful Missions

SELECT 
	[Operator], 
	[Mission type],
	Count(Operator) AS 'Mission Count'
FROM 
	SuccessfulMissions
GROUP BY 
	[Operator],[Mission type]
HAVING
	Count(*) > 1
ORDER BY
	[Operator],[Mission type]

GO

-- USERS, Exercise 2
Select * from Users
SELECT 
	[ID],
	[UserName],
	[Password],
	CONCAT([Firstname],' ', [Lastname]) AS 'Name',
CASE
	WHEN 
		SUBSTRING(ID, 10, 1) % 2 = 0 THEN 'Female'
	ELSE 
		'Male'
	END AS 'Gender',
	[Email],
	[Phone]
INTO 
	NewUsers
FROM 
	Users

GO

SELECT 
	[Username] AS 'Duplicates',
	Count([Username]) AS 'Count'
FROM NewUsers
GROUP BY UserName
Having Count([Username]) > 1

GO

ALTER TABLE NewUsers ALTER COLUMN Username NVARCHAR(7);

WITH CTE AS 

(
    SELECT 
		UserName, 
		ID,
		ROW_NUMBER() OVER (PARTITION BY UserName ORDER BY ID) AS RowNum
    FROM 
		NewUsers
)

UPDATE 
	CTE
SET 
	UserName = UserName + CONVERT(nvarchar(7),RowNum)
WHERE 
	RowNum > 1;

GO

-- Remove women born before 1970

DELETE FROM
	NewUsers
Where Left(ID,2) < 70 AND Gender = 'Female'

GO

-- Add a new user

INSERT INTO NewUsers
VALUES
(
	'930111-7534', 
	'alebal', 
	'2194506fc6ef7a2048f03a0f4e694209', 
	'Alex Balner', 
	'Male', 
	'alex.balner@gmail.com', 
	0707-694200
)

GO

SELECT
	Gender,
	avg(DATEDIFF(DAY, substring(ID, 1, 6), getdate()) / 365) AS 'Average Age'
FROM 
	NewUsers
Group by 
	Gender

GO

-- COMPANY Exercise 3
-- Joins

SELECT 
	p.Id AS 'Id',
	p.ProductName AS 'Product',
	s.CompanyName AS 'Supplier',
	c.CategoryName AS 'Category'
FROM 
	company.products p 
	JOIN company.suppliers s ON p.SupplierId = s.Id
	JOIN company.categories c ON p.CategoryId = c.Id

GO

SELECT
	r.RegionDescription AS 'Region',
	COUNT(DISTINCT e.Id) AS 'Number of Employees'
FROM
	company.regions r
	JOIN company.territories t ON r.Id = t.RegionId
	JOIN company.employee_territory et ON t.Id = et.TerritoryId
	JOIN company.employees e ON et.EmployeeId = e.Id
GROUP BY 
	r.Id, r.RegionDescription

GO


SELECT * FROM company.employees
		
SELECT 
	e.Id, 
	e.TitleOfCourtesy + e.FirstName +' ' + e.LastName AS 'Name',
	ISNULL(Boss.Title + ', ' + Boss.TitleOfCourtesy + Boss.FirstName +  ' ' + Boss.LastName, 'Nobody!') AS 'Reports to'
FROM
	company.employees e
	LEFT JOIN company.employees Boss 
	ON e.ReportsTo = Boss.ID

GO
