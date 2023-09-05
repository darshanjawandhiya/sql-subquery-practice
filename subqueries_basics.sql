-- Find the movie with highest rating (without using subquery)
select * from movies order by score desc limit 1;

-- Find the movie with highest rating (with using subquery)
select max(score) from movies ;
select * from movies where score = (select max(score) from movies );

-- Independent Subquery -Scalar Subquery

-- 1. Find the movie with highest profit(vs order by)
select * from movies order by (gross-budget) desc limit 1;
select max(gross-budget) from movies;
select * from movies where (gross-budget) =(select max(gross-budget) from movies) ;

-- 2. Find how many movies have a rating > the avg of all the movie ratings(Find the count of above average movies)
select avg(score) from movies ;
select count(*) from movies where score > (select avg(score)from movies)  ;

-- 3. Find the highest rated movie of 2000
select * from movies where year = 2000 and score = (select max(score) from movies where year = 2000);
 
-- 4. Find the highest rated movie among all movies whose number of votes are > the dataset avg votes
select * from movies where score = (select max(score) from movies where votes > (select avg(votes) from movies));

-- Independent Subquery - Row Subquery(One Col Multi Rows)

-- 1. Find all users who never ordered

select distinct (user_id) from orders;

select * from users where user_id not in (select distinct (user_id) from orders);

-- 2. Find all the movies made by top 3 directors(in terms of total gross income) [IMP]
select * from movies where director in
(select director from movies group by director order by sum(gross) desc limit 3); 

-- Query gives error - Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'

-- Solving by using CTE
with top_directors as (select director from movies group by director order by sum(gross) desc limit 3)    -- temp table top_directors 
select * from movies 
where director in (select * from top_directors);

-- 3. Find all movies of all those actors whose filmography's avg rating > 8.5(take 25000 votes as cutoff)


select star,avg(score) from movies where votes > 25000 group by star having avg(score) >8.5;

select * from movies where star in 
(select star from movies where votes > 25000 group by star 
having avg(score) >8.5) ;

-- Independent Subquery - Table Subquery (Multi Col Multi Row)

-- 1. Find the most profitable movie of each year [IMP]
select * from movies where (year,(gross-budget)) in
(select year,max(gross-budget) as 'profit' from movies group by year);

select * from movies group by year ;

-- 2. Find the highest rated movie of each genre votes cutoff of 25000

select * from movies where (genre,score) in (select genre,max(score) from movies where votes > 25000 group by genre );

-- 3. Find the highest grossing movies of top 5 actor/director combo in terms of total gross income [IMP]

-- [have to use cte as limit keyword is present in query and we cannot write subquery to display name with it as -- Query gives error - Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery']

-- cte is used to create a temporary table

with top_duos as (select star,director,max(gross) from movies group by star,director order by sum(gross) desc limit 5)
select * from movies where (star,director,gross) in (select * from top_duos);

-- Correlated Subquery - Here the the inner query is dependent on the outer query [IMP CONCEPT]

-- 1. Find all the movies that have a rating higher than the average rating of movies in the same genre. [IMP]

select * from movies m1 where score > (select avg(score) from movies m2 where m2.genre=m1.genre);

-- 2. Find the favorite food of each customer.  [IMP]
-- [Using cte to sove this question]

WITH fav_food as (
select t1.name,t1.user_id,f_name,t3.f_id,count(*) as 'count' from users t1 
join orders t2 on t1.user_id =t2.user_id
join order_details t3 on t2.order_id=t3.order_id
join food t4 on t3.f_id=t4.f_id
group by t2.user_id,t3.f_id,name,f_name
order by name,count desc)

select * from fav_food f1
where count = (select max(count) from fav_food f2 where f2.user_id=f1.user_id)
order by user_id;

-- Usage with SELECT
-- 1. Get the percentage of votes for each movie compared to the total number of votes.

-- select name,(votes/sum(votes))*100 from movies group by name,(votes/sum(votes))*100; --does not works as agg column used without group by

select name,(votes/(select sum(votes) from movies))*100 as 'percent' from movies ;   -- another way

-- 2. Display all movie names ,genre, score and avg(score) of genre [IMP]

select name,genre,score,(select round(avg(score),2) from movies m2 where m2.genre = m1.genre ) as'avg' from movies m1 ; 


-- NOTE I : Assignment operator in sql works from RIGHT TO LEFT order

-- NOTE II : Why this is inefficient?
-- Subquery inside SELECT statement is inefficient because for each row you need to perform same no of calculations which is highly inefficient.

-- Usage with FROM

-- 1. Display average rating of all the restaurants

-- using joins

-- select r_name,avg(restaurant_rating) from orders t1 
-- join restaurants t2 on t1.r_id=t2.r_id
-- group by r_name 

-- using subquery

select r_name,avg_rating from (select r_id, avg(restaurant_rating) as 'avg_rating' from orders
group by r_id) t1 join restaurants t2 on t1. r_id = t2.r_id;

-- Here eventually we performed join but before that we created a temporary table where we used subquery inside the from clause

-- Usage with HAVING
-- 1. Find genres having avg score > avg score of all the movies [IMP]

select genre,round(avg(score),2) as 'avg_genre_score' from movies 
group by genre having avg_genre_score > (select avg(score) from movies );

-- Here we make use of subquery to filter group by results

-- Subquery In INSERT

-- Populate a already created loyal_customers table with records of only those customers who have ordered food more than 3 times.

insert into loyal_customers
(user_id,name)
select t1.user_id,t2.name from orders t1 
join users t2 on t1.user_id=t2.user_id
group by t1.user_id,t2.name
having count(*) > 3;


-- Subquery in UPDATE

-- Populate the money col of loyal_cutomer table using the orders table.
-- Provide a 10% app money to all customers based on their order value. [IMP - use correlated subquery to solve this question]

update loyal_customers
set money =(select sum(amount)*0.1 from orders
where orders.user_id=loyal_customers.user_id);


-- Subquery in DELETE

-- Delete all the customers record who have never ordered.

delete from users 
where user_id IN (
select user_id from users where user_id not in (select distinct(user_id) from orders));






