-- 1. What are the names of the players whose salary is greater than 100,000?
select 
	player_id 
    , player_name
from
	players
where 
	salary >100000;

-- 2. What is the team name of the player with player_id = 3?
select 
	t.team_name
from
	teams as t
    left join players as p
		on t.team_id = p.team_id
where 
	p.player_id = 3;
    
-- 3. What is the total number of players in each team?
select
	t.team_id
    , t.team_name
    , count(p.player_id) as total_players
from 
	players as p 
    left join teams as t
		on p.team_id = t.team_id
group by
	t.team_id , t.team_name;

-- 4. What is the team name and captain name of the team with team_id = 2?
select
	t.team_id
    , t.team_name
    , p.player_name
from
	teams as t
    left join players as p
		on p.player_id = t.captain_id
where t.team_id = 2;

-- 5. What are the player names and their roles in the team with team_id = 1?
select 
	player_name
    , role
from 
	players
where
	team_id = 1;

-- 6. What are the team names and the number of matches they have won?
select 
	t.team_id  
    , t.team_name
    , count(m.match_id) as total_won_matches
from
	teams as t
    left join matches as m
		on t.team_id = m.winner_id
group by t.team_id , t.team_name;

-- 7. What is the average salary of players in the teams with country 'USA'?
select
	 avg(salary)
from 
	players as p 
    right join teams as t 
		on p.team_id = t.team_id
where
	t.country = 'USA';
    
-- 8. Which team won the most matches?
select 
     t.team_name
    , count(m.match_id) as total_won_matches
from
	teams as t
    left join matches as m
		on t.team_id = m.winner_id
group by 
	 t.team_name
order by
	total_won_matches desc
limit 1
;
-- 9. What are the team names and the number of players in each team whose salary is greater than 100,000?
SELECT 
    t.team_name, COUNT(P.player_id) AS high_salary_players
FROM
    Teams AS t
        JOIN
    Players AS p ON t.team_id = p.team_id
WHERE
    p.salary > 100000
GROUP BY t.team_name
;
-- 10. What is the date and the score of the match with match_id = 3?
select
	match_date
    , score_team1
    , score_team2
from
	matches
where
	match_id = 3;
	