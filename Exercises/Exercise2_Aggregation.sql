-- git init

/*
a) Ta ut (select) en rad för varje (unik) period i tabellen ”Elements” med
följande kolumner: ”period”, ”from” med lägsta atomnumret i perioden,
”to” med högsta atomnumret i perioden, ”average isotopes” med
genomsnittligt antal isotoper visat med 2 decimaler, ”symbols” med en
kommaseparerad lista av alla ämnen i perioden.
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
b) För varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
(select) följande kolumner: ”Region”, ”Country”, ”City”, samt
”Customers” som anger hur många kunder som finns i staden
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
c) Skapa en varchar-variabel och skriv en select-sats som sätter värdet:

”Säsong 1 sändes från april till juni 2011. Totalt
sändes 10 avsnitt, som i genomsnitt sågs av 2.5
miljoner människor i USA.”, följt av radbyte/char(13), följt av
”Säsong 2 sändes ...” osv.

När du sedan skriver (print) variabeln till messages ska du alltså få en rad
för varje säsong enligt ovan, med data sammanställt från tabellen
GameOfThrones.

Tips: Ange ’sv’ som tredje parameter i format() för svenska månader.
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
d) Ta ut (select) alla användare i tabellen ”Users” så du får tre kolumner:
”Namn” som har fulla namnet; ”Ålder” som visar hur många år personen
är idag (ex. ’45 år’); ”Kön” som visar om det är en man eller kvinna.
Sortera raderna efter för- och efternamn.
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
	-- ta första två siffrorna och formatera till år. ÅLDER
	-- ta ut näst sista siffran och kolla ifall det är jämt eller inte, KÖN
	-- SOrtera rader efter för, Efternamn.


/*
e) Ta ut en lista över regioner i tabellen ”Countries” där det för varje region
framgår regionens namn, antal länder i regionen, totalt antal invånare,
total area, befolkningstätheten med 2 decimaler, samt
spädbarnsdödligheten per 100.000 födslar avrundat till heltal.
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
f) Från tabellen ”Airports”, gruppera per land och ta ut kolumner som visar:
land, antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur
många procent av flygplatserna i varje land som saknar ICAO-kod.
*/