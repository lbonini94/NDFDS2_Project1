

-- Top 5 paises do artista mais vendido

SELECT Artist.Name, count(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount,
        Customer.FirstName, Customer.LastName, Customer.Country
FROM Invoice  
JOIN InvoiceLine
ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
ON InvoiceLine.TrackId = Track.TrackId
JOIN Album
ON Track.AlbumId = Album.AlbumId
JOIN Artist
ON Album.ArtistId = Artist.ArtistId
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
WHERE Artist.Name = 'Iron Maiden'
GROUP BY Invoice.CustomerId
ORDER BY Amount DESC;

---- O genero que mais vendeu
SELECT
        count(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount,
        Genre.Name AS GenreName
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre
  ON Track.GenreId = Genre.GenreId
JOIN Customer
  ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Genre.Name
ORDER BY 1 DESC

/*Insight 1 - Queries used for the first insight */
----How many tracks sold
SELECT
  Artist.Name,
  COUNT(InvoiceLine.TrackId) AS Amt_track_sold
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
GROUP BY Artist.Name
ORDER BY Amt_track_sold DESC;
--- TOP 5
SELECT
  Artist.Name,
  Customer.Country,
  COUNT(InvoiceLine.TrackId) AS Amt_track_sold
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
JOIN Customer
  ON Invoice.CustomerId = Customer.CustomerId
WHERE Artist.Name IN ('Iron Maiden')
GROUP BY Customer.Country
ORDER BY Amt_track_sold DESC
LIMIT 5;



/*Insight 2 - Queries used for the second insight */
----5 Albuns that made more money
SELECT
  Album.Title AS album,
  Artist.Name AS artist,
  COUNT(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS amount
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
GROUP BY Album.Title
ORDER BY amount DESC


---- O genero que mais vendeu
SELECT
        count(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount,
        Genre.Name AS GenreName
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre
  ON Track.GenreId = Genre.GenreId
JOIN Customer
  ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Genre.Name
ORDER BY 1 DESC

---funcionario
SELECT Invoice.InvoiceId,
        count(*),
        Employee.FirstName || ' ' || Employee.LastName AS Empl
FROM Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId 
JOIN Employee
on Customer.SupportRepId = Employee.EmployeeId
GROUP BY Empl


WITH t1 AS 
(
	SELECT c.Country, SUM(i.Total) TotalSpent, c.FirstName, c.LastName, c.CustomerId
	FROM 
		Customer c
		JOIN Invoice i ON c.CustomerId = i.CustomerId
	GROUP BY c.CustomerId
)

SELECT t1.*
FROM t1
JOIN(
	SELECT Country, MAX(TotalSpent) AS MaxTotalSpent, FirstName, LastName, CustomerId
	FROM t1
	GROUP BY Country
)t2
ON t1.Country = t2.Country
WHERE t1.TotalSpent = t2.MaxTotalSpent
ORDER BY Country;




---PAÍS LIDER EM COMPRAS
WITH T1 AS(
SELECT
		COUNT(i.InvoiceId) Purchases, c.Country
	FROM Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN InvoiceLine il ON il.Invoiceid = i.InvoiceId
		JOIN Track t ON t.TrackId = il.Trackid
		JOIN Genre g ON t.GenreId = g.GenreId
	GROUP BY c.Country, g.Name
	ORDER BY c.Country, Purchases DESC)

SELECT SUM(Purchases), Country
    FROM T1
    GROUP BY 2
    ORDER BY 1 DESC



SELECT  count(PlaylistTrack.TrackId), PlaylistTrack.TrackId,
   Playlist.PlaylistId, Playlist.Name
FROM PlaylistTrack
JOIN Playlist
ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY Playlist.Name



SELECT Name, 
      Milliseconds 
FROM (
	    SELECT t.Name,
           t.Milliseconds, (SELECT AVG(Milliseconds) 
                              FROM Track) AS AvgLenght
	FROM Track t
	--WHERE AvgLenght < t.Milliseconds
	ORDER BY t.Milliseconds DESC );


  SELECT Track.Milliseconds, Track.Name
  FROM Track
  JOIN PlaylistTrack
    ON PlaylistTrack.TrackId = Track.TrackId
  ORDER by 1 DESC;





-- Artista que mais aparece em playlists
WITH T1
AS (SELECT
  COUNT(PlaylistTrack.PlaylistId) AS Playlists,
  PlaylistTrack.TrackId,
  Artist.Name
FROM PlaylistTrack
JOIN Track
  ON PlaylistTrack.TrackId = Track.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
GROUP BY PlaylistTrack.TrackId
ORDER BY 1 DESC)

SELECT
  SUM(T1.Playlists),
  T1.Name
FROM T1
GROUP BY Name
ORDER BY 1 DESC
LIMIT 5


SELECT COUNT(PlaylistTrack.PlaylistId), PlaylistTrack.PlaylistId
FROM PlaylistTrack
GROUP BY PlaylistTrack.PlaylistId