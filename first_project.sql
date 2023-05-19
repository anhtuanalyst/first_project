select * 
from all_games_meta$;

select *
from all_games_user$;


--Number of games each platform
select platform, count(name) as number_of_games
from all_games_meta$
group by platform
order by number_of_games desc;

--Ranking game by meta score
select distinct name, meta_score
from all_games_meta$
group by name, meta_score
order by meta_score desc;

--Seperated by year
select distinct name, release_date, 
				year(release_date) as release_year,
				round(avg(meta_score),2) as avg_meta_score
from all_games_meta$
group by name, release_date
order by release_date;

--Ranking games by metascore each year
with cte as
(
select distinct name, release_date, 
				year(release_date) as release_year,
				round(avg(meta_score),2) as avg_meta_score
from all_games_meta$
group by name, release_date
)
select name, release_year, avg_meta_score,
	rank()
	over(
	partition by release_year
	order by avg_meta_score desc) as rank
from cte
group by name, release_year, avg_meta_score
order by release_year, rank;

--Ranking game by average user score
select name, round(avg(user_review),2) as avg_user_score
from all_games_user$
group by name
order by avg_user_score desc;

--Comparison between meta score and maximum user score
select distinct m.name, meta_score, max(user_review) as max_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
	on m.name = u.name
group by m.name, meta_score
order by meta_score desc;

--Comparison between meta score and average user score
select m.name, meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
	on m.name = u.name
group by m.name, meta_score
order by meta_score desc;

--Games having user score > meta score
with cte as
(
select m.name, round(avg(meta_score),2) as avg_meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
	on m.name = u.name
group by m.name
)
select name, avg_meta_score, avg_user_score
from cte
where avg_meta_score < (avg_user_score * 10)
order by avg_meta_score desc;



--comparison of games rating by metacritics and users
with cte as
(
select m.name, m.release_date, round(avg(meta_score),2) as avg_meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
	on m.name = u.name
group by m.name, m.release_date
)
select name, release_date, avg_meta_score, avg_user_score, (avg_user_score * 10 - avg_meta_score) as diff_score
from cte
where avg_meta_score > (avg_user_score * 10)
order by diff_score;


--Most underrated games by users
with cte as
(
select m.name, m.release_date, round(avg(meta_score),2) as avg_meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
	on m.name = u.name
group by m.name,m.release_date
)
select name, release_date, avg_meta_score, avg_user_score, (avg_user_score * 10 - avg_meta_score) as diff_score
from cte
where avg_meta_score < (avg_user_score * 10)
	and avg_meta_score < (select avg(meta_score) 
					  from all_games_meta$)
order by diff_score desc;



--temp table
drop table if exists #MostUnderratedGamesByUsers
create  table #MostUnderratedGamesByUsers
(
name nvarchar(255),
avg_meta_score numeric,
avg_user_score numeric,
diff_score numeric
)

insert into #MostUnderratedGamesByUsers
select name, avg_meta_score, avg_user_score, (avg_user_score * 10 - avg_meta_score) as diff_score
from 
(
select m.name, round(avg(meta_score),2) as avg_meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
    on m.name = u.name
group by m.name
) as cte
where avg_meta_score < (avg_user_score * 10)
    and avg_meta_score < (select avg(meta_score) 
                          from all_games_meta$)
--order by diff_score desc;

select *
from #MostUnderratedGamesByUsers;

--Creating View to store data for later visualizations

create view MostUnderratedGamesByUsers as
select name, avg_meta_score, avg_user_score, (avg_user_score * 10 - avg_meta_score) as diff_score
from 
(
select m.name, round(avg(meta_score),2) as avg_meta_score, round(avg(user_review),2) as avg_user_score
from all_games_meta$ as m
inner join all_games_user$ as u
    on m.name = u.name
group by m.name
) as cte
where avg_meta_score < (avg_user_score * 10)
    and avg_meta_score < (select avg(meta_score) 
                          from all_games_meta$);
--order by diff_score desc;

select *
from MostUnderratedGamesByUsers