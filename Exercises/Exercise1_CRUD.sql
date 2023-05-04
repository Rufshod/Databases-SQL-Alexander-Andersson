/*
F�r de �vningsuppgifter som kr�ver att ni �ndrar i en tabell (insert, update,
delete) se f�rst till att kopiera orginaltabellen i everyloop till en ny tabell, som ni
sedan kan modifiera. P� s� vis har ni alltid orginalet kvar of�r�ndrat.
Exempel: select * into Users2 from Users;
Om ni r�kat �ndra orginalet och vill ha tillbaks det s� kan ni �terst�lla databasen
fr�n backupfilen. Ni kan antingen �terst�lla backupen och skriva �ver den
databasen ni redan har (d� f�rsvinner alla �ndringar ni gjort), eller s� kan ni
�terst�lla den till en ny databas, t.ex. everyloop2.
*/


/*
a) 
Ta ut data (select) fr�n tabellen GameOfThrones p� s�dant s�tt att ni f�r ut
en kolumn �Title� med titeln samt en kolumn �Episode� som visar episoder
och s�songer i formatet �S01E01�, �S01E02�, osv.
Tips: kolla upp funktionen format()
*/

--SELECT * INTO GAT2 FROM GameOfThrones 


SELECT title, CONCAT('S', FORMAT(Season, '0#'), 'E', FORMAT(EpisodeInSeason, '0#')) AS 'Season And Episode'
FROM GAT2;


/*
b) Uppdatera (kopia p�) tabellen user och s�tt username f�r alla anv�ndare s�
den blir de 2 f�rsta bokst�verna i f�rnamnet, och de 2 f�rsta i efternamnet
(ist�llet f�r 3+3 som det �r i orginalet). Hela anv�ndarnamnet ska vara i sm�
bokst�ver.
*/

Update Users2
	SET UserName = lower(left(FirstName, 2) + left(LastName,2));

select Username FROM Users;
select Username From users2;


/*
c) Uppdatera (kopia p�) tabellen airports s� att alla null-v�rden i kolumnerna
Time och DST byts ut mot �-�
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
d) Ta bort de rader fr�n (kopia p�) tabellen Elements d�r �Name� �r n�gon av
f�ljande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', samt alla
rader d�r �Name� b�rjar p� n�gon av bokst�verna d, k, m, o, eller u.
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
e) Skapa en ny tabell med alla rader fr�n tabellen Elements. Den nya tabellen
ska inneh�lla �Symbol� och �Name� fr�n orginalet, samt en tredje kolumn
med v�rdet �Yes� f�r de rader d�r �Name� b�rjar med bokst�verna i
�Symbol�, och �No� f�r de rader d�r de inte g�r det.
Ex: �He� -> �Helium� -> �Yes�, �Mg� -> �Magnesium� -> �No�.
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
f) Kopiera tabellen Colors till Colors2, men skippa kolumnen �Code�. G�r
sedan en select fr�n Colors2 som ger samma resultat som du skulle f�tt fr�n
select * from Colors; (Dvs, �terskapa den saknade kolumnen fr�n RGB-
v�rdena i resultatet).
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
g) Kopiera kolumnerna �Integer� och �String� fr�n tabellen �Types� till en ny
tabell. G�r sedan en select fr�n den nya tabellen som ger samma resultat
som du skulle f�tt fr�n select * from types;
*/

SELECT * FROM Types; 

SELECT Integer, String FROM Types2;


-- L�gg till FLOAT-kolumnen
ALTER TABLE Types2 ADD FLOAT AS (CAST(Integer AS FLOAT)/100.0);

-- L�gg till DATETIME-kolumnen
ALTER TABLE Types2 ADD DATETIME AS (CONVERT(Integer, '19000101', 112) + CONVERT(TIME, String));

-- L�gg till BOOL-kolumnen
ALTER TABLE Types2 ADD BOOL AS (CASE WHEN [Integer] = 1 THEN 'TRUE' ELSE 'FALSE' END);

SELECT * FROM Types2