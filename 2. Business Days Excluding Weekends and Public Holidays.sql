---Business Days Excluding Weekends and Public Holidays---
create table tickets_2
(
	ticket_id varchar(10),
	create_date date,
	resolved_date date
);
insert into tickets_2 values
(1,'2022-08-01','2022-08-03'), (2,'2022-08-01','2022-08-12'), (3,'2022-08-01','2022-08-16');

create table holidays_2
(
	holiday_date date,
	reason varchar(100)
);

insert into holidays_2 values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from tickets_2;
select * from holidays_2;
--write a query to find business day between create and resolved date by excluding weekends and public holidays	
select *,
datediff(day, create_date, resolved_date) - 2*datediff(WEEK, create_date, resolved_date) - no_of_holidays as business_days
from
	(select ticket_id, create_date, resolved_date,
	count(holiday_date) as no_of_holidays
	from tickets_2
	left join holidays_2 on holiday_date between create_date and resolved_date
	group by ticket_id, create_date, resolved_date) A



--logic
select *,
datediff(day, create_date, resolved_date) as actual_days,
datepart(week, create_date),
datepart(week, resolved_date),
datediff(WEEK, create_date, resolved_date) as working_days
from tickets_2;
--since there are 2 days of weekends, so we multiplied by 2 and then subtracted to exclude weekends
