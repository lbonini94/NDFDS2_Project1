/* Question 1: Which countries have the most Invoices?
Use the Invoice table to determine 
the countries that have the most invoices.
 Provide a table of BillingCountry and 
 Invoices ordered by the number of invoices
 for each country. The country with the most 
 invoices should appear first.
*/
SELECT BillingCountry, count(*) as 'Invoices'
FROM Invoice
GROUP BY BillingCountry 
ORDER BY Invoices DESC;

/*
Question 2: Which city has the best customers?
We would like to throw a promotional 
Music Festival in the city we made the most money.
Write a query that returns the 1 city that has 
the highest sum of invoice totals.
Return both the city name and the sum of 
all invoice totals.
*/

SELECT BillingCity, sum(total) as 'Invoices'
FROM Invoice
GROUP BY BillingCity
ORDER BY Invoices DESC;

/*
Question 3: Who is the best customer?
The customer who has spent the most money 
will be declared the best customer. 
Build a query that returns the person who
has spent the most money. I found the solution
by linking the following three: Invoice, 
InvoiceLine, and Customer tables to retrieve
this information, but you can probably do it with fewer!
*/

SELECT Customer.CustomerId AS 'ID',
    Customer.FirstName AS 'BEST CUSTOMER',
     sum(Invoice.Total) AS 'Amount'
FROM Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Invoice.CustomerId
ORDER BY Amount DESC


