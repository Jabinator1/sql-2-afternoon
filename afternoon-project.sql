-- JOIN STATEMENTS

SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT al.title, ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist pl ON pl.playlist_id = pt.playlist_id
WHERE pl.name = 'Music';

SELECT pl.name
FROM playlist pl
JOIN playlist_track pt ON pt.playlist_id = 5;

SELECT tr.name, pl.name
FROM track tr
JOIN playlist_track pt ON tr.track_id = pt.track_id
JOIN playlist pl ON pl.playlist_id = pt.playlist_id;

SELECT tr.name, al.title
FROM track tr
JOIN album al ON tr.album_id = al.album_id
JOIN genre g ON tr.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';

SELECT tr.name, g.name, al.title, ar.name
FROM playlist pl
JOIN playlist_track pt ON pt.playlist_id = pl.playlist_id
JOIN track tr ON tr.track_id = pt.track_id
JOIN genre g ON g.genre_id = tr.genre_id
JOIN album al ON al.album_id = tr.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
WHERE pl.name = 'Music';


-- NESTED QUERIES

SELECT * FROM invoice
WHERE invoice_id IN (
    SELECT invoice_id
    FROM invoice_line
    WHERE unit_price > 0.99
);

SELECT * FROM playlist_track
WHERE playlist_id IN (
    SELECT playlist_id
    FROM playlist
    WHERE name = 'Music'
);

SELECT name FROM track
WHERE track_id IN (
    SELECT track_id
    FROM playlist_track
    WHERE playlist_id = 5
);

SELECT * FROM track
WHERE genre_id IN (
    SELECT genre_id
    FROM genre
    WHERE name = 'Comedy'
);

SELECT * FROM track
WHERE album_id IN (
    SELECT album_id
    FROM album
    WHERE title = 'Fireball'
);

SELECT * FROM track
WHERE album_id IN (
    SELECT album_id FROM album WHERE artist_id IN (
        SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);

-- UPDATING ROWS

UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (
  SELECT genre_id
  FROM genre
  WHERE name = 'Metal'
)
AND composer IS NULL;

-- GROUP BY

SELECT COUNT(*), g.name
FROM track tr
JOIN genre g ON g.genre_id = tr.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track tr
JOIN genre g ON g.genre_id = tr.genre_id
WHERE g.name
GROUP BY g.name;

SELECT COUNT(*), ar.name FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- DISTINCT

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

-- DELETE

DELETE FROM practice_delete
WHERE name = 'bronze';

DELETE FROM practice_delete
WHERE name = 'silver';

DELETE FROM practice_delete
WHERE value = 150;

