-- 1. Find all players in the database who played at Vanderbilt University. Create a list showing each player's first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
WITH vandy_players AS (
						SELECT DISTINCT playerid
						FROM collegeplaying 
							LEFT JOIN schools
							USING(schoolid)
						WHERE schoolid = 'vandy'
)
SELECT namefirst, 
	   namelast, 
	   SUM(salary)::numeric::money AS total_salary, 
	   COUNT(DISTINCT yearid) AS years_played
FROM people
	 INNER JOIN vandy_players
	 USING(playerid)
	 LEFT JOIN salaries
	 USING(playerid)
GROUP BY playerid, namefirst, namelast
ORDER BY total_salary DESC NULLS LAST;
-- David Price is the highest earning MLB player with $81,851,296.00 in combined salary