# SQL Subqueries Practice

This repository is your go-to resource for mastering SQL subqueries and expanding your querying skills. Explore a wide range of SQL subquery exercises and solutions, organized into various topics:

## Topics Covered

### Subquery Basics
1. Find the movie with the highest rating.
2. Find how many movies have a rating greater than the average of all movie ratings.
3. Find the highest-rated movie of the year 2000.
4. Find the highest-rated movie among all movies with more than the average number of votes.

### Independent Subqueries
1. Find the most profitable movie of each year.
2. Find the highest-rated movie of each genre with a votes cutoff of 25000.
3. Find the highest-grossing movies of the top 5 actor/director combos in terms of total gross income.

### Correlated Subqueries
1. Find all the movies that have a rating higher than the average rating of movies in the same genre (e.g., Animation).
2. Find the favorite food of each customer.

### Usage with SELECT
1. Get the percentage of votes for each movie compared to the total number of votes.
2. Display all movie names, genre, score, and the average score of the genre.

### Usage with FROM
1. Display the average rating of all the restaurants.

### Usage with HAVING
1. Find genres with an average score greater than the average score of all movies.

### Subquery In INSERT
1. Populate an already created loyal_customers table with records of only those customers who have ordered food more than 3 times.
   
### Subquery in UPDATE
1. Populate the money column of the loyal_customer table using the orders table, providing a 10% app money reward based on their order value.

### Subquery in DELETE
1. Delete all customer records who have never ordered.

## SQL Query Solutions

This repository includes SQL query solutions for all exercises, available in the accompanying SQL file. Use this resource to enhance your SQL skills and tackle real-world data querying challenges.

## Usage

Clone this repository to your local machine to access the SQL queries and solutions. Happy querying!

***

**Assignment Task: SQL Subquery Challenges**

In this repository, you'll find SQL subquery exercises using two datasets: the Olympic dataset and the health insurance dataset. Before you begin, follow these steps to load the datasets into your SQL database:

1. Create a database in your local machine server:
   ```sql
   CREATE DATABASE <database_name>;
   ```

2. Use Python to load the dataset(s):

```python
import pandas as pd
from sqlalchemy import create_engine

# Load the Olympic dataset
olympics_df = pd.read_csv("path/to/olympic/olympics.csv")

# Load the health insurance dataset
insurance_df = pd.read_csv("path/to/insurance/insurance.csv")

engine = create_engine("mysql+pymysql://<db_username>:<db_password>@<hostname>/<database_name>")

# Load Olympic dataset into SQL
olympics_df.to_sql("<olympics_table_name>", con=engine)

# Load health insurance dataset into SQL
insurance_df.to_sql("<insurance_table_name>", con=engine)
```

**Assignment Problems:**

**Olympic Dataset (Problems 1-6):**

1. Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the average height of all athletes in the 2008 Olympics.

2. Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight is less than the average weight of all athletes who won a medal in the 2016 Olympics.

3. Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics.

4. Display the names of all countries that have won more than 50 medals in a single year.

5. Display the names of all athletes who have won medals in more than one sport in the same year.

6. What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event?

**Health Insurance Dataset (Problems 7-10):**

7. Find the number of patients who claimed more than the average claim amount for patients who are smokers, have at least one child, and belong to the southeast region.

8. Find the number of patients who claimed more than the average claim amount for patients who are non-smokers, have a BMI greater than the average BMI for patients with at least one child.

9. Find the number of patients who claimed more than the average claim amount for patients who have a BMI greater than the average BMI for diabetic patients, have at least one child, and are from the southwest region.

10. Calculate the difference in the average claim amount between patients who are smokers and patients who are non-smokers, with the same BMI and number of children.

Complete these SQL subquery challenges using the provided datasets and enhance your SQL skills. Good luck!

**Credits:** 

This collection of SQL subquery exercises and content is provided by the CampusX Data Science Bootcamp.
