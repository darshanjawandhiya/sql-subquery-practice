-- Problem 1 - 6 [olympics dataset]
-- Problem 1 : Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the average height 
-- of all athletes in the 2008 Olympics.

select name from olympics where Year = 2008 and Medal = 'Gold'
AND height > (select avg(height) from olympics where year =2008);

-- Problem 2 : Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight is less than 
-- the average weight of all athletes who won a medal in the 2016 Olympics.

select name from olympics where sport ='Basketball' and Medal is not null and year =2016 and 
weight < (select avg(weight) from olympics where medal is not null and year =2016);

-- Problem 3
-- Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics.
select * from olympics where sport ='Swimming' and medal is not null and year in (2008,2016);

-- Problem 4
-- Display the names of all countries that have won more than 50 medals in a single year.

select country,year,count(*) from olympics where medal is not null and country is not null
group by country,year having count(*) > 50 
order by year,country;

-- Problem 5
-- Display the names of all athletes who have won medals in more than one sport in the same year.

select distinct (name) from olympics where ID in
(select distinct (ID) from olympics where Medal is not null group by ID,sport,Year having count(*) >1
order by count(*) desc);

-- Problem 6
-- What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event?

WITH result as(
select * from olympics where Medal is not null
)
select avg(A.weight -B.weight) from result A 
join result B on A.event=B.event and
A.Sex != B.Sex;

-- Problem 7 - 10 [insurance dataset]

-- Problem 7
-- How many patients have claimed more than the average claim amount for patients who are smokers and have at least one child, and belong to the southeast region?

select count(*) from insurance  where claim >
(SELECT avg(claim) FROM insurance where smoker ='Yes' and region = 'southwest' and children >=1);

-- Problem 8
-- How many patients have claimed more than the average claim amount for patients who are not smokers and have a BMI greater than 
-- the average BMI for patients who have at least one child?

select count(*) from insurance where 
claim > (select avg(claim) from insurance where smoker ='No' and 
bmi > (select avg(bmi) from insurance where children>=1));

-- Problem 9
-- How many patients have claimed more than the average claim amount for patients who have a BMI greater than the average BMI for 
-- patients who are diabetic, have at least one child, and are from the southwest region?

select count(*) from insurance 
where claim >(select avg(claim) from insurance 
where bmi >(select avg(bmi) from insurance where diabetic='Yes' and children>=1 and region='southwest'));

-- Problem 10:
-- What is the difference in the average claim amount between patients who are smokers and patients who are non-smokers, and 
-- have the same BMI and number of children?

select avg(A.claim - B.claim) from insurance A 
join insurance B 
on A.bmi =B.bmi
and A.smoker != b.smoker
and A.children =b.children;





