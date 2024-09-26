create database exhibition;
use exhibition;
show tables;
select * from art_work;
select * from artsist_data;
select * from customer;
select * from exhibition_details;
select * from sell;

desc art_work;
desc artsist_data;
desc customer ;
desc exhibition_details;
desc sell;

alter table art_work add constraint PK_artist primary key(artist_id);
select * from art_work;
#------------------------------------------------------* JOINS *-------------------------------------------------------------------------------



#JOINS 
# 1) what is the nationality of the artist having the ID 167
select nationality, name from art_work A inner join artsist_data D on A.artist_iD = D.artist_id where A.artist_id = 167;

# 2) art having the artwork_id 2157 was get by which customer 
select name, customer_id, email_id, phone from customer inner join sell on customer.customer_id = sell.customer_id where sell.artwork_id = 2157;

# 3) customer name mail phone having sale id using join
select sale_id , email_id, phone, name from customer join sell on customer.customer_id = sell.customer_id;

# 4) title of the project and thier nationality 
select title , nationality from art_work A join artsist_data D on A.artist_id = D.artist_id; 

# 5) find average price of the artwork in the medium category 
select avg(price) , nationality from art_work inner join artsist_data on art_work.artist_id = artsist_data.artist_id   where nationality = "Russia";

# 6) right join use of the two table to show name with there medium and nationality
select name , artwork_medium , nationality from art_work A right join artsist_data AD on A.artist_id = AD.artist_id; 

# 7) joining 3 tables to extract name of the customer having spend more than 300000 on artwork
SELECT c.name, c.email_id FROM customer c JOIN sell s ON c.customer_id = s.customer_id JOIN art_work a ON s.artwork_id = a.artwork_id
WHERE a.price > 300000;



#---------------------------------------------------------------*SUBQUERIES*----------------------------------------------------------------------------------



#SUBQUERIES
# 1) 2nd highest price of the art_work
select max(price) from art_work;
select max(price) from art_work where price < (select max(price) from art_work);

# 2) Retrieve the names of customers who have purchased artworks worth more than $10,000
select * from art_work where price > 10000;
select artwork_medium from art_work where price > any(select artist_id from art_work where price > 10000);

# 3) data of the artist whos salary is greater than the one who are from united states 
select nationality, price from artsist_data join art_work on artsist_data.artist_id = art_work.artist_id where nationality ="united states";
select * from art_work where price > (select max(price) from artsist_data join art_work on artsist_data.artist_id = art_work.artist_id where nationality ="united states");

# 4) show the data of the artwork whos price the greater than average price
select avg(price) from art_work;
select * from art_work where price > (select avg(price) from art_work);

select customer_id from art_work inner join sell on art_work.artwork_id = sell.artwork_id where art_work.price > 300000;
select name, email_id 
from customer C 
inner join sell S 
on C.customer_id = S.customer_id ;

select * from sell;
# 5) having the name and email_id of the customer who spend more than 300000 on the art using joins and subqueries
SELECT c.name, c.email_id FROM customer c
WHERE c.customer_id IN (SELECT s.customer_id
    FROM sell s
    JOIN art_work a ON s.artwork_id = a.artwork_id
    WHERE a.price > 300000);




#---------------------------------------------------------*BASIC QUESTIONS*--------------------------------------------------------------------------------------------------------------------



# 1) Find the average price of artworks in a specific size
select avg(price) from art_work where size = "small";

# 2) Find the total value of artworks sold by the artist "Verena Cumbridge"
select sum(price)  from art_work inner join artsist_data on art_work.artist_id = artsist_data.artist_id where artsist_data.name = "Verena Cumbridge";

# 3) dropping the table
alter table exhibition_details drop column artist_id;

# 4) artwork having the top 5 price
select * from art_work limit 5; 

# 5) count of artist by sizes available
select size, count(artist_id) from art_work group by size;

# 6) selecting particular value 
select * from sell where artwork_id = 2157;
select * from sell;

# 7) title of a project having size small 
select size, title from art_work where size = "small";

# 8) extract month name from the table
select monthname(sale_date) from sell;

# 9) change mobile number of the customer 
update customer set phone = 7447547494 where customer_id = 3506;
select * from customer; 

# 10) use of group by clause using joins getting sum of the price in the medium
select artwork_medium ,sum(price), count(price) from art_work inner join sell on art_work.artwork_id = sell.artwork_id group by artwork_medium ;

# 11) use of logical operator AND 
select * from art_work where price > 100000 AND size = "large";

# 12) convert the email ID of the particular customer to the uper case 
select upper(name), customer_id from customer where customer_id = 3506;
select * from customer; 

# 13) what is the day gap between start date and the date sold 
select datediff(submission_date,start_date ) from exhibition_details;

# 14) title of the art work having id 1,2,3,4,5
select title, price from art_work where artist_id in (1,2,3,4,5);

# 15) change the column name and add the city is new york 
alter table sell add city varchar(30);
select * from sell;
update sell set city = "new york";
