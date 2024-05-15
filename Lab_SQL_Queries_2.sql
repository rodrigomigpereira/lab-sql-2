## Lab | SQL Queries 2
## In this lab, you will be using the Sakila database of movie rentals.

## Instructions
## 1.	Select all the actors with the first name ‘Scarlett’.

use sakila; ## Use the database sakila 

select first_name, last_name from actor; ## Selecting all the actors ("first_name" + "last_name") of the table "actor"

select first_name, last_name 
	from actor
			where first_name = "Scarlett"; ## I listed the 2 actors with the first name "Scarlett" when I use the condition command where first_name = "Scarlett"

## 2.	Select all the actors with the last name ‘Johansson’.

select first_name, last_name 
	from actor
			where last_name = "Johansson"; ## I lsited teh 3 actors with the last name "Johansson" when I use the condition command where last_name = "Johansson"

## Extra highlighted below where created a new column ("full_name") concatenating the first_name + last_name
select first_name, last_name, concat(first_name," ", last_name) as full_name
	from actor
			where last_name = "Johansson";      
            
## 3.	How many films (movies) are available for rent?

select * from film; ## Selecting all info of the table "film"

select count(film_id) from film; ## There are 1000 movies available when we count how many different "film_id" are listed at teh table "film"

select count(distinct film_id) from film; ## There are 1000 movies, even after I use the command "distinct" which removes duplicates (if any)

## 4.	How many films have been rented?

select * from rental; ## Selecting all info of the table "rental"

select count(distinct rental_id) from rental; # 16044 different renta_id
select count(distinct inventory_id) from rental; ## 4580 different inventory_id 

## So we can conclude that 4580 moveis were rented 16044 times

## 5.	What is the shortest and longest rental period?

select *, 
	date_format(left(rental_date,10), "%Y-%m-%d") as formatted_rental_date, 
    date_format(left(return_date,10), "%Y-%m-%d") as formatted_return_date
    	from rental; ## subquery1

select *, datediff(formatted_return_date, formatted_rental_date) as rental_period  ## The DATEDIFF() function returns the difference between two dates, as an integer. https://www.w3schools.com/sql/func_sqlserver_datediff.asp
	from (select *, 
	date_format(left(rental_date,10), "%Y-%m-%d") as formatted_rental_date,
    date_format(left(return_date,10), "%Y-%m-%d") as formatted_return_date
    	from rental ## subquery1
	) as subquery2;

select max(rental_period) as max_rental_period, min(rental_period) as min_rental_period
	from (select *, datediff(formatted_return_date, formatted_rental_date) as rental_period  
		from (select *, 
		date_format(left(rental_date,10), "%Y-%m-%d") as formatted_rental_date,
		date_format(left(return_date,10), "%Y-%m-%d") as formatted_return_date
			from rental ## subquery1
		) as subquery2
    ) as subquery3;  ## I got the result of 10 days for the longest rental period and 1 day for the shortest one
    
## 6.	What are the shortest and longest movie duration? Name the values max_duration and min_duration.

select * from film;  ## selecting all info from table "film"

select max(length) as max_duration, min(length) as min_duration
	from film;  ## Max_durantion = 185 and min_durantion i= 46 

## 7.	What's the average movie duration?

select * from film;

select avg(length) as average_durantion from film; ## average movie duratio = 115.2720

## 8.	What's the average movie duration expressed in format (hours, minutes)?

select 
	avg(length) div 60 as Hours,  ## The DIV function is used for integer division (x is divided by y) 
    avg(length) % 60 as Minutes   ## Operator % to get the remaining minutes
from film;

## 9.	How many movies longer than 3 hours?

select * from film where length > 180;  ## to list all the info of moviews considering its lenght > 3 hours (180 minutes)

select count(film_id)
	from film 
		where length > 180; ## 39 movies are longer than 3 hours

## 10.	Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.

select * from customer;

select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as formatted_first_name ## Formating the column "first_name". ,1,1 means that started 1st character and it has 1 lenght
	from customer;

select lower(email) as formatted_email ## Formating the column email
	from customer;

select *, concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as formatted_first_name, lower(email) as formatted_email
	from customer;

select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as formatted_first_name, last_name, lower(email) as formatted_email ## Selecting the 3 columns as requested (Example: Mary SMITH - mary.smith@sakilacustomer.org.)
	from customer;

select *, concat(formatted_first_name," ", last_name, " - ",formatted_email) ## Concatenating the data das requested (Example: Mary SMITH - mary.smith@sakilacustomer.org.) and displaying the info in a new column
	from (select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as formatted_first_name, last_name, lower(email) as formatted_email 
			from customer
		) as subquery;

## 11.	What's the length of the longest film title?

select length(title) as title_length from film; ## Creating an extra title_lenght

select max(length(title)) as title_length from film; ## Longest film title has 27 characters 		
