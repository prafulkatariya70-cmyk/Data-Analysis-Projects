CREATE TABLE netflix_data (
    ShowID INT PRIMARY KEY,
    Title VARCHAR(100),
    Category VARCHAR(50),      
    Genre VARCHAR(50),
    ReleaseYear INT,
    IMDBScore DECIMAL(3,1),
    AgeRating VARCHAR(10)      
);


INSERT INTO netflix_data VALUES
(1,  'Stranger Things',         'TV Show', 'Sci-Fi',        2016, 8.7, 'TV-14'),
(2,  'Money Heist',             'TV Show', 'Crime',         2017, 8.3, 'TV-MA'),
(3,  'The Witcher',             'TV Show', 'Fantasy',       2019, 8.1, 'TV-MA'),
(4,  'Extraction',              'Movie',   'Action',        2020, 6.8, 'R'),
(5,  'Bird Box',                'Movie',   'Horror',        2018, 6.6, 'R'),
(6,  'Dark',                    'TV Show', 'Mystery',       2017, 8.8, 'TV-MA'),
(7,  'Inception',               'Movie',   'Sci-Fi',        2010, 8.8, 'PG-13'),
(8,  'The Social Dilemma',      'Movie',   'Documentary',   2020, 7.6, 'PG-13'),
(9,  'You',                     'TV Show', 'Thriller',      2018, 7.7, 'TV-MA'),
(10, 'Sweet Tooth',             'TV Show', 'Fantasy',       2021, 7.8, 'TV-14'),

(11, 'Enola Holmes',            'Movie',   'Adventure',     2020, 6.6, 'PG-13'),
(12, 'Lucifer',                 'TV Show', 'Drama',         2016, 8.2, 'TV-14'),
(13, 'Red Notice',              'Movie',   'Action',        2021, 6.4, 'PG-13'),
(14, 'The Crown',               'TV Show', 'Historical',    2016, 8.6, 'TV-MA'),
(15, 'Kota Factory',            'TV Show', 'Drama',         2019, 9.0, 'TV-14'),
(16, 'Sacred Games',            'TV Show', 'Thriller',      2018, 8.6, 'TV-MA'),
(17, 'Dangal',                  'Movie',   'Sports',        2016, 8.8, 'PG-13'),
(18, 'RRR',                     'Movie',   'Action',        2022, 8.0, 'PG-13'),
(19, 'Mission Mangal',          'Movie',   'Drama',         2019, 6.5, 'PG'),
(20, 'Jawan',                   'Movie',   'Action',        2023, 7.2, 'PG-13'),

(21, 'Peaky Blinders',          'TV Show', 'Crime',         2013, 8.8, 'TV-MA'),
(22, 'Wednesday',               'TV Show', 'Fantasy',       2022, 8.1, 'TV-14'),
(23, 'The Irishman',            'Movie',   'Crime',         2019, 7.8, 'R'),
(24, 'Army of the Dead',        'Movie',   'Action',        2021, 5.8, 'R'),
(25, 'Narcos',                  'TV Show', 'Crime',         2015, 8.8, 'TV-MA'),
(26, 'The Adam Project',        'Movie',   'Sci-Fi',        2022, 6.7, 'PG-13'),
(27, 'Spider-Man 2',            'Movie',   'Action',        2004, 7.4, 'PG-13'),
(28, 'Interstellar',            'Movie',   'Sci-Fi',        2014, 8.6, 'PG-13'),
(29, 'Joker',                   'Movie',   'Crime',         2019, 8.4, 'R'),
(30, 'Breaking Bad',            'TV Show', 'Crime',         2008, 9.5, 'TV-MA');

DROP TABLE IF EXISTS netflix_data;

select * from netflix_data

-- SUBQUERIES --

-- Show all shows with IMDBScore higher than the overall average score
select * from netflix_data
where imdbscore > (select avg(imdbscore) from netflix_data );

-- Find movies released after the earliest release year
select * from netflix_data
where releaseyear > (select min(releaseyear) from netflix_data );

-- Get all shows whose IMDB score matches the maximum score in the table
select * from netflix_data
where imdbscore = (select max(imdbscore) from netflix_data);

-- Find all movies belonging to the same genre as ‘Inception’
SELECT *
FROM netflix_data
WHERE Genre = (
    SELECT Genre
    FROM netflix_data
    WHERE Title = 'Inception'
);

--Show all titles with the same age rating as ‘Stranger Things’
select * from netflix_data
where agerating = (select agerating from netflix_data where title='Stranger things');

-- Find all shows with the same Genre as 'Dark'
select * from netflix_data
where genre = (select genre where title='dark');

-- Find movies released after the release year of 'Inception'
select * from netflix_data
where releaseyear > (select releaseyear from netflix_data where title='inception');

-- Show the title with the highest IMDB score
select title,imdbscore from netflix_data
where imdbscore = (select max(imdbscore) from netflix_data);

--Find the category (Movie/TV Show) of 'RRR'
SELECT Category
FROM netflix_data
WHERE ShowID = (
    SELECT ShowID
    FROM netflix_data
    WHERE Title = 'RRR'
);

--Get all PG-13 movies that have a higher IMDB score than the average IMDB score
select * from netflix_data
where imdbscore > (select avg(imdbscore) from netflix_data );

--INTERMEDIATE SUBQUERIES--

--Find all movies that have the same Age Rating as the highest-rated movie
select * from netflix_data
WHERE AGERATING = (SELECT AGERATING FROM netflix_data where title='breaking bad'); 

--Find titles whose IMDB score is higher than the IMDB score of any 2020 release
select title,imdbscore from netflix_data
where imdbscore > (select avg(imdbscore) from netflix_data where releaseyear='2020');

--List all Genres where the highest-rated show in that genre has IMDBScore > 8.5
SELECT DISTINCT Genre
FROM netflix_data
WHERE IMDBScore > (
    SELECT MAX(IMDBScore)
    FROM netflix_data
    WHERE Genre = 'Crime'
);

--Find titles released before the earliest movie in the table
SELECT * 
FROM netflix_data
WHERE ReleaseYear < (
    SELECT AVG(ReleaseYear) 
    FROM netflix_data 
    WHERE Category = 'Movie'
);

--Find all shows with a higher IMDB score than 'Money Heist'
select * from netflix_data
where imdbscore > (select imdbscore from netflix_data where title='money heist');

--Find all titles whose IMDB score is higher than the IMDB score of ANY 2021 release
select title,imdbscore,category from netflix_data
where imdbscore > (select max(imdbscore) from netflix_data where releaseyear=2021);

--Find movies that were released earlier than ALL TV shows
SELECT *
FROM netflix_data
WHERE Category = 'Movie'
AND ReleaseYear < (
    SELECT MIN(ReleaseYear)
    FROM netflix_data
    WHERE Category = 'TV Show'
);

--Find titles that belong to genres where average IMDB score is greater than 8
select * from netflix_data
where genre in (select genre from netflix_data group by genre having avg(imdbscore)>8);

--Find all titles that have a lower score than the highest-rated TV Show
select * from netflix_data
where imdbscore < (select max(imdbscore) from netflix_data where category='tv show');

--Find titles released between the earliest and latest release years of the “Action” genre
select * from netflix_data
where releaseyear between (select min(releaseyear) from netflix_data where genre='action')
and (select max(releaseyear) from netflix_data where genre='action');

--Movies released before the earliest release year of any TV Show
select * from netflix_data
where releaseyear < (select min(releaseyear) from netflix_data where category='tv show');

--Shows with IMDBScore higher than the average score
select * from netflix_data
where imdbscore>(select avg(imdbscore) from netflix_data );

--Find average IMDB score by category
select category, avg(imdbscore) as avgscore
from (select category, imdbscore from netflix_data)
as t group by category;

--Count titles for each genre after filtering only movies
select genre, count(*) as Total_movies
from (select * from netflix_data where category='movie')
as movies group by genre;

-- Get only those titles whose ReleaseYear is above the overall average
select title,releaseyear from netflix_data
where releaseyear>(select avg(releaseyear) from netflix_data);

--Show each title with the average IMDB score
SELECT 
    Title,
    IMDBScore,
    (SELECT AVG(IMDBScore) FROM netflix_data) AS AvgScore
FROM netflix_data;

--Show each title with count of total movies
select title,category,
(select count(*) from netflix_data where category='movie') 
as totalmovies from netflix_data;

--Show each title with genre of ‘Inception’ for comparison
select title,genre from netflix_data 
where genre=(select genre from netflix_data where title='inception')








