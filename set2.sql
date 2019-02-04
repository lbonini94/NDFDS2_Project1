/*
Question 1
Use your query to return the email, 
first name, last name, and Genre of 
all Rock Music listeners. Return your 
list ordered alphabetically by email 
address starting with A. Can you find 
a way to deal with duplicate email 
addresses so no one receives multiple emails?

I chose to link information from the 
Customer, Invoice, InvoiceLine, Track,
and Genre tables, but you may be able 
to find another way to get at the information.
*/

SELECT Customer.Email, 
        Customer.FirstName,
        Customer.LastName,
        Genre.Name AS 'Name'
FROM Customer
JOIN Invoice
ON Invoice.CustomerId = Customer.CustomerId
JOIN InvoiceLine
ON  InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre
ON Track.GenreId = Genre.GenreId
WHERE Genre.Name IN ('Rock')
GROUP by Customer.Email
ORDER BY Customer.Email

/*
Question 2: Who is writing the rock music?
Now that we know that our customers love rock music,
 we can decide which musicians to invite to play at the concert.

Let's invite the artists who have written the most
 rock music in our dataset. Write a query that returns
  the Artist name and total track count of the top 10 rock bands.

You will need to use the Genre, Track , Album, and Artist tables.
*/

-- SELECT Artist.Name AS 'Name', 
--         COUNT(Genre.Name) AS 'Songs'
-- FROM Genre, Track, Album, Artist
-- WHERE Track.GenreId = Genre.GenreId 
-- AND Track.AlbumId = Album.AlbumId
-- AND Album.ArtistId = Artist.ArtistId
-- AND Genre.Name = 'Rock'
-- GROUP BY Artist.Name
-- ORDER BY Songs DESC
-- LIMIT 10;

SELECT Artist.Name AS 'Name',
        COUNT(Track.Name) AS 'Songs'
FROM Track
JOIN Genre
ON Track.GenreId = Genre.GenreId
JOIN Album
ON Track.AlbumId = Album.AlbumId
JOIN Artist
ON Album.ArtistId = Artist.ArtistId
WHERE Genre.Name = 'Rock'
GROUP BY Artist.Name
ORDER BY Songs DESC
LIMIT 10;


/*
Question 3
First, find which artist has earned the most according to the InvoiceLines?
Now use this artist to find which customer spent the most on this artist.
For this query, you will need to use the Invoice, InvoiceLine, Track, 
Customer, Album, and Artist tables.

Notice, this one is tricky because the Total spent in the Invoice 
table might not be on a single product, so you need to use the InvoiceLine
table to find out how many of each product was purchased, and then multiply
this by the price for each artist.
*/

-- Iron Maiden sold 138.6
SELECT Artist.Name, 
        count(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount     
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
ORDER BY Amount DESC
-------

SELECT Artist.Name, count(InvoiceLine.TrackId) * InvoiceLine.UnitPrice AS Amount,
        Customer.FirstName, Customer.LastName
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
ORDER BY Amount DESC

