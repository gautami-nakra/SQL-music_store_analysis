show tables;
select * from track;
select * from album2;

# artist with the most albums
with most_album as (select a.artist_id as id, a.artist_name , al.title as title
from artist a 
join album2 al on a.artist_id=al.artist_id order by id)

select artist_name, count(title)
from most_album
group by artist_name
order by count(title) desc limit 3;

#album with the most songs
#artist with the most songs
with most_songs as (select al.album_id, al.title as album, t.track_name, a.artist_name, a.artist_id
from album2 al
join track t on al.album_id=t.album_id
join artist a on al.artist_id=a.artist_id)
select album, count(track_name) as tracks, artist_name
from most_songs
group by album, artist_name
order by tracks desc limit 3;

#artist with the largest album
with join1 as (select a.artist_name, a.artist_id, al.title, al.album_id, t.track_name
from artist a 
join album2 al on a.artist_id=al.artist_id
join track t on al.album_id=t.album_id)
select artist_name , count(track_name) as tracks, al.title as album
from join1
group by title
order by count(track_name) desc limit 3;

#avg duration of songs in minutes
select round (avg (milliseconds)/60000,2) as Average_duration
from track t
join track t on al.album_id=t.album_id
join artist a on al.artist_id=a.artist_id
where a.artist_name= 'Led Zeppelin';

#artist with longest songs
select composer, round(avg(milliseconds)/60000,2) as average_duration 
from track
where composer is not null
group by composer
order by average_duration desc limit 3;

#track names that have a song length longer than the average song length
SELECT track_name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

#most popular genre           
with abc as (select a.artist_name as artist, al.album_id as album_id, al.title as album,
t.track_name as track, g.name as genre, m.name as mediatype from album2 al
left join track t on al.album_id=t.album_id
inner join artist a on al.artist_id=a.artist_id
inner join genre g on t.genre_id=g.genre_id
inner join media_type m on t.media_type_id= m.media_type_id)
select genre, count(genre) as count
from abc
group by genre
order by count desc;


with bcd as (select  t.track_name as track, 
g.name as genre from genre g
inner join track t on g.genre_id=t.genre_id)
select genre, count(genre) as count
from bcd
group by genre
order by count desc limit 3;

#most valuable customer
select c.customer_id, c.first_name, c.last_name, round(sum(total),2) as total_spending
from customer c
join invoice i on c.customer_id= i.customer_id
group by 1,2,3
order by total_spending desc limit 3;

#artist with the most rock music
with most_rock as (select a.artist_id, a.artist_name, al.album_id, al.title, t.track_id, g.genre_id, g.name as genre
from artist a
join album2 al on al.artist_id=a.artist_id
join track t on al.album_id=t.album_id
join genre g on t.genre_id=g.genre_id)
select artist_name, count(artist_name) as no_of_songs
from most_rock
where genre= 'rock'
group by artist_name
order by no_of_songs ;

#amount spent by each customer on artists
with best_selling_artist as
(SELECT artist.artist_id AS artist_id, artist.artist_name AS artist_name,
 SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
JOIN track ON track.track_id = invoice_line.track_id
	JOIN album2 ON album2.album_id = track.album_id
	JOIN artist ON artist.artist_id = album2.artist_id
	GROUP BY 1,2
	ORDER BY 3 DESC limit 1)

SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album2 alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5;

select * from employee;

#employee with most sales
with most_sales as (select e.employee_id, e.first_name, e.last_name, c.support_rep_id, c.customer_id, i.total
from employee e
join customer c on e.employee_id= c.support_rep_id
join invoice i on c.customer_id= i.customer_id)
select first_name, last_name, round(sum(total),2) as sales_total
from most_sales
group by 1,2
order by 3 desc limit 3;

#country with the most invoice
select count(total), billing_country
from invoice
group by billing_country
order by count(total) desc;

# a query that returns each genre, with the number of tracks sold in the France
Select g.name genre, COUNT(il.track_id) tracks_sold 
from genre g 
join track t ON t.genre_id = g.genre_id 
Join invoice_line il ON il.track_id = t.track_id
Join invoice inv ON inv.invoice_id = il.invoice_id
join customer c On c.customer_id = inv.customer_id
Where c.country = "France"
Group by 1 Order by 2 Desc;

#employee sales performance
Select e.first_name, e.last_name, e.hire_date, 
        SUM(inv.total) total_sales from employee e
        left join customer c
        ON c.support_rep_id = e.employee_id 
        Inner Join invoice inv
        On inv.customer_id = c.customer_id
        Group by 1,2,3;

#customer that has spent the most on music for each country
WITH RECURSIVE 
	customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),

	country_max_spending AS(
		SELECT billing_country,MAX(total_spending) AS max_spending
		FROM customter_with_country
		GROUP BY billing_country)

SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customter_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;

#average duration of songs by artist Iron Maiden	
 select round (avg (milliseconds)/60000,2) as Average_duration, a.artist_name as artist
from track t
join album2 al on al.album_id= t.track_id
join artist a on a.artist_id= al.artist_id
where a.artist_name= 'Iron Maiden'
group by artist;









