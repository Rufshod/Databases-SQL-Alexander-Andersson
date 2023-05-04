-- git init

/*
a) Ta ut (select) en rad f�r varje (unik) period i tabellen �Elements� med
f�ljande kolumner: �period�, �from� med l�gsta atomnumret i perioden,
�to� med h�gsta atomnumret i perioden, �average isotopes� med
genomsnittligt antal isotoper visat med 2 decimaler, �symbols� med en
kommaseparerad lista av alla �mnen i perioden.
*/

SELECT
    [Period],
    MIN([Number]) AS 'From',
    MAX([Number]) AS 'To',
	format(avg(CAST(stableisotopes AS FLOAT)),'#.00' )  as 'Average isotopes',
	string_agg(Symbol, ', ') as 'Symbols'
FROM 
	[Elements]

GROUP BY
	[Period]
	


/*
b) F�r varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
(select) f�ljande kolumner: �Region�, �Country�, �City�, samt
�Customers� som anger hur m�nga kunder som finns i staden
*/
SELECT 
	Region, 
	Country, 
	City,
	count(*) as 'Customer'
	
FROM 
	company.customers

GROUP BY Region, Country, City
HAVING count(*) >= 2;



/*
c) Skapa en varchar-variabel och skriv en select-sats som s�tter v�rdet:

�S�song 1 s�ndes fr�n april till juni 2011. Totalt
s�ndes 10 avsnitt, som i genomsnitt s�gs av 2.5
miljoner m�nniskor i USA.�, f�ljt av radbyte/char(13), f�ljt av
�S�song 2 s�ndes ...� osv.

N�r du sedan skriver (print) variabeln till messages ska du allts� f� en rad
f�r varje s�song enligt ovan, med data sammanst�llt fr�n tabellen
GameOfThrones.

Tips: Ange �sv� som tredje parameter i format() f�r svenska m�nader.
*/

DECLARE @got_info as varchar(max) = '';

 SELECT
	@got_info += 
	concat(
	'Season ',Season, -- SEASON
	' aired from ',DATENAME(MONTH, min([Original air date])), -- FIRST
	' to ',DATENAME(MONTH, max([Original air date])),' ',  YEAR(max([Original air date])),'.', --LAST 
	' Total episodes aired were ',max(EpisodeInSeason), -- EPISODE
	' that an average ', format(avg([U.S. viewers(millions)]), '0.##'), ' saw the episodes in USA.' -- AVG
	, char(13), char(13)) -- New line
	From GameOfThrones 
Group by 
	Season
print @got_info


/*
d) Ta ut (select) alla anv�ndare i tabellen �Users� s� du f�r tre kolumner:
�Namn� som har fulla namnet; ��lder� som visar hur m�nga �r personen
�r idag (ex. �45 �r�); �K�n� som visar om det �r en man eller kvinna.
Sortera raderna efter f�r- och efternamn.
*/
SELECT
	concat(FirstName, ' ', LastName) as 'Name',
	DATEDIFF(year, substring(ID, 1, 6), getdate()) AS 'AGE',
	CASE 
		WHEN SUBSTRING(ID, 10, 1) % 2 = 0 THEN 'Female'
		ELSE 'Male'
	END AS 'Gender'
FROM
	Users
ORDER BY
	FirstName,
	LastName
	-- ta f�rsta tv� siffrorna och formatera till �r. �LDER
	-- ta ut n�st sista siffran och kolla ifall det �r j�mt eller inte, K�N
	-- SOrtera rader efter f�r, Efternamn.


/*
e) Ta ut en lista �ver regioner i tabellen �Countries� d�r det f�r varje region
framg�r regionens namn, antal l�nder i regionen, totalt antal inv�nare,
total area, befolkningst�theten med 2 decimaler, samt
sp�dbarnsd�dligheten per 100.000 f�dslar avrundat till heltal.
*/
-- ANDREAS
SELECT
    Region,
    COUNT(Country) AS 'Countries',
    SUM(CAST([Population] AS BIGINT)) AS 'Population', -- Arithmetic overflow if you do CAST as BIGINT
    SUM([Area (sq# mi#)]) AS 'Area (square miles)',
    FORMAT(SUM(CAST([Population] AS FLOAT)) / SUM([Area (sq# mi#)]), '#.##') AS 'Population Density (per square mile)',
    ROUND(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',', '.') AS FLOAT)) * 100, 0) AS 'Infant Mortality (per 100.000)'
FROM
    Countries
GROUP BY
    Region;

-- CYRILLE
select 
	Region, 
	count(country) as 'Country count', 
	sum(convert(numeric,Population)) as 'Total Pop', 
	sum(convert(numeric, [Area (sq# mi#)])) as 'Total area',
	 format(avg(convert(float, replace([Pop# Density (per sq# mi#)], ',','.'))), '#####.##') as 'Average pop desity',
	convert(int,avg(convert(float, replace([Infant mortality (per 1000 births)], ',','.'))) / 100)  as 'Aveage IMDR (per 100 000 births)' 
from 
	Countries 
group by 
	Region

/*
f) Fr�n tabellen �Airports�, gruppera per land och ta ut kolumner som visar:
land, antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur
m�nga procent av flygplatserna i varje land som saknar ICAO-kod.
*/