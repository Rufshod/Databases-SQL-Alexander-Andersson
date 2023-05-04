/*
För de övningsuppgifter som kräver att ni ändrar i en tabell (insert, update,
delete) se först till att kopiera orginaltabellen i everyloop till en ny tabell, som ni
sedan kan modifiera. På så vis har ni alltid orginalet kvar oförändrat.
Exempel: select * into Users2 from Users;
Om ni råkat ändra orginalet och vill ha tillbaks det så kan ni återställa databasen
från backupfilen. Ni kan antingen återställa backupen och skriva över den
databasen ni redan har (då försvinner alla ändringar ni gjort), eller så kan ni
återställa den till en ny databas, t.ex. everyloop2.
*/


/*
a) 
Ta ut data (select) från tabellen GameOfThrones på sådant sätt att ni får ut
en kolumn ’Title’ med titeln samt en kolumn ’Episode’ som visar episoder
och säsonger i formatet ”S01E01”, ”S01E02”, osv.
Tips: kolla upp funktionen format()
*/

--SELECT * INTO GAT2 FROM GameOfThrones 


SELECT title, CONCAT('S', FORMAT(Season, '0#'), 'E', FORMAT(EpisodeInSeason, '0#')) AS 'Season And Episode'
FROM GAT2;


/*
b) Uppdatera (kopia på) tabellen user och sätt username för alla användare så
den blir de 2 första bokstäverna i förnamnet, och de 2 första i efternamnet
(istället för 3+3 som det är i orginalet). Hela användarnamnet ska vara i små
bokstäver.
*/

Update Users2
	SET UserName = lower(left(FirstName, 2) + left(LastName,2));

select Username FROM Users;
select Username From users2;


/*
c) Uppdatera (kopia på) tabellen airports så att alla null-värden i kolumnerna
Time och DST byts ut mot ’-’
*/
select * into airportscopy from airports;

UPDATE airportscopy
	SET DST = '-'
	WHERE DST is NULL;

UPDATE airportscopy
	SET Time = '='
	WHERE Time is NULL;

select * from airportscopy;
/*
d) Ta bort de rader från (kopia på) tabellen Elements där ”Name” är någon av
följande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', samt alla
rader där ”Name” börjar på någon av bokstäverna d, k, m, o, eller u.
*/

SELECT * INTO ElementsCopy
	FROM Elements;


DELETE FROM ElementsCopy
	WHERE [Name] IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
	OR [Name] LIKE 'd%'
	OR [Name] LIKE 'k%'
	OR [Name] LIKE 'm%'
	OR [Name] LIKE 'o%'
	OR [Name] LIKE 'u%';

SELECT * FROM Elements
SELECT * FROM ElementsCopy

	

/*
e) Skapa en ny tabell med alla rader från tabellen Elements. Den nya tabellen
ska innehålla ”Symbol” och ”Name” från orginalet, samt en tredje kolumn
med värdet ’Yes’ för de rader där ”Name” börjar med bokstäverna i
”Symbol”, och ’No’ för de rader där de inte gör det.
Ex: ’He’ -> ’Helium’ -> ’Yes’, ’Mg’ -> ’Magnesium’ -> ’No’.
*/

CREATE TABLE ElementsReduced (
  Symbol TEXT,
  Name TEXT,
  Match TEXT
);

INSERT INTO ElementsReduced (Symbol, Name, Match)
SELECT Symbol, Name, CASE WHEN Name LIKE CONCAT(Symbol, '%') THEN 'Yes' ELSE 'No' END AS Match
FROM Elements;

SELECT * FROM ElementsReduced

/*
f) Kopiera tabellen Colors till Colors2, men skippa kolumnen ”Code”. Gör
sedan en select från Colors2 som ger samma resultat som du skulle fått från
select * from Colors; (Dvs, återskapa den saknade kolumnen från RGB-
värdena i resultatet).
*/


SELECT 
	concat
(
	Convert(varbinary(16), colors.RED),
	Convert(varbinary(16), colors.Blue),
	Convert(varbinary(16), colors.Green)
)
FROM colors
Select 
	* 
FROM 
	Colors

DECLARE
	@hex_table varchar(16) = '0123456789abcdef';

SELECT
	[Name], 
	Code,
	concat('#'



SELECT '#' +
   RIGHT('0' + 
         CASE WHEN Red <= 15 THEN '0' + CONVERT(VARCHAR(1), CONVERT(VARBINARY(1), Red), 2)
              ELSE CONVERT(VARCHAR(2), CONVERT(VARBINARY(1), Red), 2) END, 2) +
   RIGHT('0' + 
         CASE WHEN Green <= 15 THEN '0' + CONVERT(VARCHAR(1), CONVERT(VARBINARY(1), Green), 2)
              ELSE CONVERT(VARCHAR(2), CONVERT(VARBINARY(1), Green), 2) END, 2) +
   RIGHT('0' + 
         CASE WHEN Blue <= 15 THEN '0' + CONVERT(VARCHAR(1), CONVERT(VARBINARY(1), Blue), 2)
              ELSE CONVERT(VARCHAR(2), CONVERT(VARBINARY(1), Blue), 2) END, 2) AS 'New Code',
    Code
FROM 
   Colors

/*
g) Kopiera kolumnerna ”Integer” och ”String” från tabellen ”Types” till en ny
tabell. Gör sedan en select från den nya tabellen som ger samma resultat
som du skulle fått från select * from types;
*/

SELECT * FROM Types; 

SELECT Integer, String FROM Types2;


-- Lägg till FLOAT-kolumnen
ALTER TABLE Types2 ADD FLOAT AS (CAST(Integer AS FLOAT)/100.0);

-- Lägg till DATETIME-kolumnen
ALTER TABLE Types2 ADD DATETIME AS (CONVERT(Integer, '19000101', 112) + CONVERT(TIME, String));

-- Lägg till BOOL-kolumnen
ALTER TABLE Types2 ADD BOOL AS (CASE WHEN [Integer] = 1 THEN 'TRUE' ELSE 'FALSE' END);

SELECT * FROM Types2