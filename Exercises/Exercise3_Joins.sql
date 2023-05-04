-- Övningsuppgifter 3- Relationsdata

/*
Många gånger när någon kund eller kollega vill ha hjälp att få ut data ur en
databas så har de ingen aning om vilka specifika kolumner eller tabeller
datan är lagrad i. Då får man hjälpa till med lite detektivarbete. Om
databasen är någorlunda välstrukturerad kan man oftast, utifrån namnen,
gissa sig till vad de olika tabellerna innehåller och hur de är relaterade.
Vid det här laget har ni de flesta verktyg ni behöver för att skriva queries och
få ut den information ni letar efter. Nu är det dags att börja gräva runt bland
data i everyloop för att hitta svar på specifika frågor.
Svara på frågorna i övningarna nedan, och redovisa hur ni kommit fram till
svaret.

Med tabellerna från schema “company”, svara på följande frågor:
*/
SELECT * FROM company.customers;
SELECT * FROM company.order_details;
SELECT * FROM company.regions;
SELECT * FROM company.suppliers;
SELECT * FROM company.territories;




/*
1. Företagets totala produktkatalog består av 77 unika produkter.
Om vi kollar bland våra ordrar, hur stor andel av dessa produkter
har vi någon gång leverarat till London?
*/
-- Hitta samband mellan customers och 
SELECT 
	convert(float, (Count(distinct p.id))) / 77 AS 'Andel' -- unique products. 
FROM 
	company.products p -- unique product IDs	
	JOIN company.order_details od ON p.Id = productid
	JOIN company.orders o ON od.orderid = o.id 
WHERE
	ShipCity = 'London'
-- ändra till procent.


SELECT * FROM company.order_details;-- links between product ID and order ID

SELECT * FROM company.orders -- links between order_details and customer
WHERE shipcity = 'London'

-- SELECT * FROM company.customers; -- contains city


-- ANDREAS
DECLARE @unique_products AS INT = (SELECT COUNT(DISTINCT ID) FROM Company.Products)

SELECT
    COUNT(DISTINCT p.ID) AS 'Unique Products',
    FORMAT(CAST(COUNT(DISTINCT p.ID) AS FLOAT) / @unique_products * 100, '#.00') AS 'Amount Unique Products (%)'
FROM
    Company.Products p
    JOIN Company.Order_details od ON p.ID = od.ProductID
    JOIN Company.Orders o ON od.OrderID = o.ID
WHERE
    o.ShipCity = 'London'


/*
2. Till vilken stad har vi levererat flest unika produkter?
*/

SELECT * FROM company.products -- Product name, Id -- Product Id

SELECT * FROM company.order_details --  OrderId ** -- Product Id.. -- OrderId -- Id

SELECT * FROM company.orders -- TIME ** ORDER DETAILS.. Product id -- OrderId -- Id >>> Shipcity


SELECT
	o.ShipCity as 'City',
	count(DISTINCT p.ProductName) as 'Qty Unique Products' -- Count Unique Products.
FROM 
	company.products p 
	JOIN company.order_details od ON p.Id = od.ProductId
	JOIN company.orders o ON od.OrderId = o.Id
GROUP BY 
	o.ShipCity
ORDER BY 
	count(Distinct p.ProductName) DESC


SELECT * FROM Airports
/*
3. Av de produkter som inte längre finns I vårat sortiment,
hur mycket har vi sålt för totalt till Tyskland?
*/
-- Gruppera efter Discontinued 1
-- Summera dessa



SELECT * FROM company.products -- Discontinued -- Product Id

SELECT * FROM company.order_details --  OrderId ** -- Product Id.. -- OrderId -- Id

SELECT * FROM company.orders -- TIME ** ORDER DETAILS.. Product id -- OrderId -- Id >>> Shipcity

SELECT 
	sum(od.Quantity * od.UnitPrice) AS 'Total Sales',
	o.ShipCountry AS 'Country'
FROM company.products p 
	JOIN company.order_details od ON p.Id = od.ProductId
	JOIN company.orders o ON od.OrderId = o.Id
WHERE
	p.Discontinued = 1 AND o.ShipCountry = 'Germany' 
GROUP BY
	O.ShipCountry
/*
4. För vilken produktkategori har vi högst lagervärde?
*/
SELECT * FROM company.categories -- Categories / Product ID
SELECT * FROM company.products -- Category ID

SELECT 
	c.CategoryName AS 'Category Name',
	SUM(p.UnitsInStock) AS 'Sum of Units in Stock'
FROM 
	company.products p 
	JOIN company.categories c ON p.CategoryId = c.Id
GROUP BY
	c.CategoryName

/*
5. Från vilken leverantör har vi sålt flest produkter totalt under sommaren
2013?
*/

SELECT * FROM company.suppliers  -- Company name / ID **Products -

SELECT * FROM company.products -- Supplier ID **Suppliers -

SELECT * FROM company.order_details -- Quantity / OrderID ** Product ID -

SELECT * FROM company.orders -- TIME ** ORDER DETAILS





SELECT 
	s.CompanyName AS 'Supplier', -- Name of company
	SUM(od.Quantity) AS 'Amount of Products' -- Sums the quantity of products


FROM company.suppliers			s
	JOIN company.products		p	ON s.Id = p.SupplierId
	JOIN company.order_details od	ON p.Id = ProductId
	JOIN company.orders			o	ON od.OrderId = o.Id
WHERE
	o.OrderDate	BETWEEN '2013-06-01' AND '2013-08-31' -- Set dates

GROUP BY
	s.CompanyName 
ORDER BY SUM(od.Quantity) Desc;


	--COUNT(od.OrderId)
-- WHERE year == 2013 SUMMER


-- MUSIC EXERCISES.

SELECT * FROM music.albums	-- ArtistId, AlbmId, Title
SELECT * FROM music.playlists -- PlaylstId
SELECT * FROM music.genres
SELECT * FROM music.albums -- Album / ArtistId
SELECT * FROM music.artists

DECLARE @Playlist varchar(max) = 'Heavy Metal Classic'

	
SELECT
	--p.Name AS 'Playlist',
	g.Name AS 'Genre',
	ar.Name AS 'Artist',
	al.Title AS 'Album',
	t.Name AS 'TrackId',
	FORMAT(DATEADD(ms, t.Milliseconds, '00:00'), 'mm:ss') AS 'Length',
	--CONCAT(t.Milliseconds / 1000 /60 % 60, ':', t.Milliseconds / 100 % 60) AS 'Length 2',
	CONCAT(FORMAT(t.Bytes / power(1024.0, 2), '#.0'), ' MiB') AS 'Size',
	ISNULL(Composer, '-') AS 'Composer'
FROM 
	music.tracks t
	JOIN music.genres g ON g.GenreId = t.GenreId
	JOIN music.albums al ON al.AlbumId = t.AlbumId
	JOIN music.artists ar on ar.ArtistId = al.ArtistId
	JOIN music.playlist_track pt ON pt.TrackId = t.TrackId
	JOIN music.playlists p ON p.PlaylistId = pt.PlaylistId

WHERE 
	p.Name = @playlist

ORDER BY
	--NEWID() -- Suffle Function
	Artist, Album, TrackId

-- Five Questions.


-- Av alla Audio spår har längst speltid.
SELECT * FROM music.media_types 
GO 
SELECT 
	ar.Name AS 'Artist',
	SUM(t.Milliseconds) AS 'Total Lenght',
	AVG(t.Milliseconds) AS 'Average Length'
FROM 
	music.tracks t
	JOIN music.albums al ON al.AlbumId = t.AlbumId
	JOIN music.artists ar ON ar.ArtistId = al.AlbumId
WHERE
	MediaTypeId != 3
GROUP BY
	ar.Name
ORDER BY
	'Total Lenght' desc

-- SUM of Filesize of all Video
SELECT
	SUM(CAST(Bytes as bigint)) / power(1024, 3) as 'Total' -- Total GB of filesizes.
FROM
	music.tracks
WHERE MediaTypeId = 3

-- What are the highest amount of artists that are in a separeta playlist
-- Average amount of artists per playlist
SELECT
	AVG(subquery.[Number of artists])
FROM
(
	SELECT
		p.PlaylistId,
		p.Name AS 'Playlist',
		COUNT(DISTINCT ar.ArtistId) AS 'Number of artists'
	FROM
		music.playlist_track pt
		JOIN music.tracks t ON t.TrackId = pt.TrackId
		JOIN music.albums al ON al.AlbumId = t.AlbumId
		JOIN music.artists ar ON ar.ArtistId = al.ArtistId
		RIGHT JOIN music.playlists p ON p.PlaylistId = pt.PlaylistId
	GROUP BY
		p.PlaylistId, p.Name
-- CAN NOT USE ORDER BY IN SUBQUERY
) subquery
	ORDER BY 
		'Number of artists' desc -- 2 Music in Because there is a copy of Music in music.playlists.


	--Milliseconds / 1000 % 60 as 'Seconds',
	--Milliseconds / 1000 / 60 % 60  as 'Minutes',
	--Milliseconds / 1000 / 60 / 60 as 'Hour',
	--kb = 1024 bytes ELLER 1000
	--KiB = 1024 Kibibytes (KiloBinaryBite)

