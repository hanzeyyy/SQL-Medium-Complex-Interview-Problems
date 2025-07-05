CREATE TABLE events_1 
(
	ID int,
	event varchar(255),
	YEAR INt,
	GOLD varchar(255),
	SILVER varchar(255),
	BRONZE varchar(255)
);


INSERT INTO events_1 VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events_1 VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events_1 VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events_1 VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events_1 VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events_1 VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events_1 VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events_1 VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events_1 VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events_1 VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events_1 VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events_1 VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

select * from events_1;
--write a query to find no. of gold medals per swimmer who only won gold medal	
select distinct gold as swimmer_name,
count(1) as no_of_medals
from events_1
group by gold;
--in this query, we are getting silver and bronze an well but we want only gold

--using subquery
select gold as swimmer_name,
count(1) as no_of_medals
from events_1
where gold not in (select silver from events_1
				   union all
				   select bronze from events_1)
group by gold;

--using cte
with cte as
	(select gold as swimmer_name,
	'Gold' as medal_type
	from events_1
	union all
	select silver as swimmer_name,
	'Silver' as medal_type
	from events_1
	union all
	select bronze as swimmer_name,
	'Bronze' as medal_type
	from events_1)
select swimmer_name, 
count(1) as no_of_gold_medals
from cte
group by swimmer_name
having count(distinct medal_type) = 1 and max(medal_type) = 'Gold';
