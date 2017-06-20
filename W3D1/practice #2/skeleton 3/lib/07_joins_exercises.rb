# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      title
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      name = 'Harrison Ford'

  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    name = 'Harrison Ford' AND ord != 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT
    title, name
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    ord = 1 AND yr = '1962'
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT
    yr, COUNT(*)
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    name = 'John Travolta'
  GROUP BY
    yr
  HAVING
    COUNT(*) >= 2

  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  SELECT
    DISTINCT m1.title, a1.name
  FROM (
    SELECT
      movies.*
    FROM
      movies
    JOIN
      castings ON castings.movie_id = movies.id
    JOIN
      actors ON actors.id = castings.actor_id
    WHERE
      actors.name = 'Julie Andrews'
  ) as m1
  -- this gives us all the movies Julie Andrews played in. We will join this to the table below.
  JOIN (
    SELECT
      actors.*,
      castings.movie_id AS movie_id
    FROM
      actors
    JOIN
      castings ON castings.actor_id = actors.id
    WHERE
      cstings.ord = 1
  ) AS a1 ON m1.id = a1.movie_id
  -- this gives us a table of all the leading actors for every movie.
  -- when we join the two tables together, it will match rows in the movies table (which are movies that Julie Andrews played in) with movies in the modified actors/castings table (which are movies listed by their star actor). the resulting join will give us the lead actors of all the movies that Julie Andrews played in.
  ORDER BY
  m1.title
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  SELECT
    actors.name
    -- when joining, make sure to specify the table to which the column I want belongs.
  FROM
    actors
  JOIN
    castings ON castings.actor_id = actors.id
    -- list the foreign key before the primary key
  WHERE
    castings.ord = 1
  GROUP BY
    actors.name
  HAVING
    COUNT(*) >= 15
  ORDER BY
    actors.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
  SELECT
  movies.title,
    COUNT(DISTINCT castings.actor_id) AS actor_count
  FROM
    movies
  JOIN
    castings ON castings.movie_id = movies.id
    -- joins castings to movies table.
    -- we'll have a row for every actor in every movie...
  WHERE
    movies.yr = 1978
    -- selects all movies made in the year 1978
  GROUP BY
    movies.id
    -- group by the movie id. could have also grouped by movie title
  ORDER BY
    COUNT(*) DESC
-- this will count the number of rows for each movie -- which gives us the number of actors.
    , movies.title ASC;
    --
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  SELECT
    a1.name
  FROM (
    SELECT
      movies.*
      -- this will only give me the rows that are in movies
    FROM
      movies
    JOIN
      castings ON castings.movie_id = movies.id
    JOIN
      actors ON actors.id = castings.actor_id
    WHERE
      actors.name = 'Art Garfunkel'
  ) AS m1
  JOIN (
    SELECT
      actors.*,
      castings.movie_id
      -- including castings.movie_id allows me to connect this to movies through a join
    FROM
      actors
    JOIN
      castings ON castings.actor_id = actors.id
    WHERE
      actors.name!= 'Art Garfunkel'
    ) AS a1 ON m1.id = a1.movie_id
    -- the first table gives me a list of all the movies that have art garfunkel in it.
    -- the second table gives me a list of all the actors that are NOT Simon and Garfunkel.
    -- joining the two tables will give me all the movies that Simon and Garfunkel were in, + all the other actors that were in those movies, excluding Simon and Garfunkel.

  SQL
end
