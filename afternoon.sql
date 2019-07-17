-- CONJOINED
-- 1.1
SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- 1.2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON (i.customer_id = c.customer_id);

-- 1.3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON (c.support_rep_id = e.employee_id)
ORDER BY e.last_name ASC;

-- 1.4
SELECT al.title, ar.name 
FROM album al
JOIN artist ar ON (al.artist_id = ar.artist_id);

-- 1.5
SELECT pt.track_id, p.name
FROM playlist_track_id pt
JOIN playlist p ON (pt.playlist_id = p.playlist_id)
WHERE p.name = 'Music';

-- 1.6
SELECT t.name FROM track t
JOIN playlist_track pt ON (pt.track_id = t.track_id)
WHERE pt.playlist_id = 5;

-- 1.7
SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON (pt.track_id = t.track_id)
JOIN playlist p ON (pt.playlist_id = p.playlist_id);

-- 1.8
SELECT t.name, al.title
FROM track t
JOIN album al ON (t.album_id = al.album_id)
JOIN genre g ON (t.genre_id = g.genre_id)
WHERE g.name = 'Alternative & Punk';

-- NESTED QUERIES
-- 2.1
SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99)

-- 2.2
SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

-- 2.3
SELECT names
FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

-- 2.4
SELECT *
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE genre = "Comedy");

-- 2.5
SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

-- 2.6
SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id IN 
(SELECT artist_id FROM artist WHERE name = 'Queen'));

-- UPDATING ROWS
-- 3.1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- 3.2
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- 3.3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- 3.4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- 3.5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

-- GROUP BY
-- 4.1
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- 4.2
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

-- 4.3
SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- USD DISTINCT
-- 5.1
SELECT DISTINCT composer
FROM track;

-- 5.2
SELECT DISTINCT billing_postal_codes
FROM invoice;

-- 5.3
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS
-- 6.1
DELETE FROM practice_delete WHERE type = 'bronze';

-- 6.2
DELETE FROM practice_delete WHERE type = 'silver';

-- 6.3
DELETE FROM practice_delete WHERE value = 150;

-- eCommerce Sim
-- 7.1

CREATE TABLE users (user_id SERIAL PRIMARY KEY, name TEXT, email TEXT);
CREATE TABLE products (product_id SERIAL PRIMARY KEY, name TEXT, price INTEGER);
CREATE TABLE orders (order_id SERIAL PRIMARY KEY, prouduct_id INTEGER);

