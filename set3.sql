/*
Question 1
We want to find out the most popular music Genre
for each country. We determine the most popular
genre as the genre with the highest amount of
purchases. Write a query that returns each 
country along with the top Genre. For countries
where the maximum number of purchases is shared
return all Genres.
For this query, you will need to use the Invoice,
InvoiceLine, Customer, Track, and Genre tables.
*/
WITH t1 AS (
	SELECT
		COUNT(i.InvoiceId) Purchases, c.Country, g.Name, g.GenreId
	FROM Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN InvoiceLine il ON il.Invoiceid = i.InvoiceId
		JOIN Track t ON t.TrackId = il.Trackid
		JOIN Genre g ON t.GenreId = g.GenreId
	GROUP BY c.Country, g.Name
	ORDER BY c.Country, Purchases DESC
	)

SELECT t1.*
FROM t1
JOIN (
	SELECT MAX(Purchases) AS MaxPurchases, Country, Name, GenreId
	FROM t1
	GROUP BY Country
	)t2
ON t1.Country = t2.Country
WHERE t1.Purchases = t2.MaxPurchases;












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


