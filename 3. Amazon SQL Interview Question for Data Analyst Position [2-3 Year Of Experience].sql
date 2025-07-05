---Amazon SQL Interview Question for Data Analyst Position [2-3 Year Of Experience]---
create table hospital_3 
( 
	  emp_id int
	, action varchar(10)
	, time datetime)
;

insert into hospital_3 values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital_3 values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital_3 values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital_3 values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital_3 values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital_3 values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital_3 values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital_3 values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital_3 values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital_3 values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital_3 values ('5', 'out', '2019-12-22 09:40:00');

select * from hospital_3;
--write a query to find the total number of people present inside the hospital
---method 1
--using having clause
select emp_id, 
max(case when action = 'in' then time end) as in_time,
max(case when action = 'out' then time end) as out_time
from hospital_3
group by emp_id
having max(case when action = 'in' then time end) > max(case when action = 'out' then time end) 
or max(case when action = 'in' then time end) is null;


--using cte
with cte as
	(select emp_id, 
	max(case when action = 'in' then time end) as in_time,
	max(case when action = 'out' then time end) as out_time
	from hospital_3
	group by emp_id)
select * from cte 
where in_time > out_time or out_time is null;


---method 2
with in_time as
	(select emp_id,
	max(time) as latest_in_time
	from hospital_3
	where action = 'in'
	group by emp_id),
	out_time as
	(select emp_id,
	max(time) as latest_out_time
	from hospital_3
	where action = 'out'
	group by emp_id)
select * 
from in_time i
full outer join out_time o on i.emp_id = o.emp_id
where latest_in_time > latest_out_time or latest_out_time is null;


---method 3
with latest_time as
	(select emp_id,
	max(time) as max_latest_time
	from hospital_3
	group by emp_id),
	latest_in_time as
	(select emp_id,
	max(time) as in_time
	from hospital_3
	where action = 'in'
	group by emp_id)
select * from latest_time l
inner join latest_in_time li on l.emp_id = li.emp_id and l.max_latest_time = li.in_time;
