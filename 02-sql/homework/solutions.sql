--1.
SELECT * FROM movies WHERE year=1998;
--2.
SELECT COUNT(*) FROM movies WHERE year=1982;
--3.
SELECT * FROM actors WHERE last_name LIKE "%stack%";
--4.
SELECT first_name, last_name, COUNT(*) 
FROM actors 
GROUP BY lower(first_name), lower(last_name) 
ORDER BY COUNT(*) DESC 
LIMIT 10;
--5.
SELECT actors.first_name, actors.last_name, COUNT(*) as total
FROM actors
JOIN roles
ON actors.id = roles.actor_id
GROUP BY actors.id
ORDER BY total DESC
LIMIT 100;
--6.
SELECT genre, COUNT(*)
FROM movies_genres
GROUP BY genre
ORDER BY COUNT(*) ASC;
--7.
SELECT actors.first_name, actors.last_name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
WHERE movies.name = 'Braveheart' AND movies.year = 1995
ORDER BY actors.last_name ASC;
--8.
SELECT directors.first_name, directors.last_name, movies.name, movies.year
FROM directors
JOIN movies_directors ON directors.id = movies_directors.director_id
JOIN movies ON movies.id = movies_directors.movie_id
JOIN movies_genres ON movies.id = movies_genres.movie_id
WHERE movies_genres.genre = 'Film-Noir' AND movies.year % 4 = 0
ORDER BY movies.name ASC;
--9.
SELECT actors.first_name, actors.last_name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
JOIN movies_genres ON movies_genres.movie_id = movies.id
WHERE movies_genres.genre = 'Drama' AND movies.id IN (
    SELECT movies.id FROM movies
    JOIN roles ON movies.id = roles.movie_id
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.first_name = 'Kevin' AND actors.last_name = 'Bacon'
) AND (actors.first_name != 'Kevin' AND actors.last_name != 'Bacon')
ORDER BY actors.first_name;
--10.
SELECT *
FROM actors
WHERE id IN (
    SELECT roles.actor_id
    FROM roles
    JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year < 1900
) AND id IN (
    SELECT roles.actor_id
    FROM roles
    JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year > 2000
);
--11.
SELECT actors.first_name, actors.last_name, movies.name, COUNT(DISTINCT role) as total_roles
FROM actors
JOIN roles on actors.id = roles.actor_id
JOIN movies on movies.id = roles.movie_id
WHERE movies.year > 1990 
GROUP BY actors.id, movies.id
HAVING total_roles > 5;
--12.
SELECT year, COUNT(DISTINCT id) as total_movies
FROM movies
WHERE id not IN(
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.gender = 'M'
)
GROUP BY year
ORDER BY year DESC;