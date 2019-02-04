
/*Insight 1 */
---- Best selling genre
WITH T1
AS (SELECT
  COUNT(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount,
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
ORDER BY Amount DESC)

SELECT
  (Amount * 100) / (SELECT
    SUM(Amount)
  FROM T1)
  AS Amount_Perc,
  GenreName
FROM T1
GROUP BY GenreName
ORDER BY Amount_Perc DESC
-----------------------------------------------------------------
/*Insight 2 */
-- Show up artist
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
ORDER BY Playlists DESC)

SELECT
  SUM(T1.Playlists) AS Play_Sum,
  T1.Name
FROM T1
GROUP BY Name
ORDER BY Play_Sum DESC
LIMIT 5
----------------------------------------------------------------


/*Insight 3 */
----How many tracks sold
--- TOP 5 Countries
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
----------------------------------------------------------------------

/*Insight 4 */
--- Leader in purchases
WITH T1
AS (SELECT
  COUNT(i.InvoiceId) Purchases,
  c.Country
FROM Invoice i
JOIN Customer c
  ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
  ON il.Invoiceid = i.InvoiceId
JOIN Track t
  ON t.TrackId = il.Trackid
JOIN Genre g
  ON t.GenreId = g.GenreId
GROUP BY c.Country,
         g.Name
ORDER BY c.Country, Purchases DESC)

SELECT
  SUM(Purchases) AS Pur_sum,
  Country
FROM T1
GROUP BY Country
ORDER BY Pur_sum DESC