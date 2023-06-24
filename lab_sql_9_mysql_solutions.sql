-- 1
drop table if exists sakila.rentals_may;
create table if not exists sakila.rentals_may(
`rental_id` int unique NOT NULL,
`rental_date` datetime NOT NULL,
`inventory_id` mediumint unsigned NOT NULL,
`customer_id` smallint unsigned NOT NULL,
`return_date` datetime DEFAULT NULL,
`staff_id` tinyint unsigned NOT NULL,
`last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT PRIMARY KEY (`rental_id`),
CONSTRAINT FOREIGN KEY (`inventory_id`) references inventory(inventory_id),
CONSTRAINT FOREIGN KEY (`customer_id`) references customer(customer_id),
CONSTRAINT FOREIGN KEY (`staff_id`) references staff(staff_id));

-- It's possible to do it like this:
-- create table sakila.rentals_may
-- like sakila.rental;

-- 2
insert into sakila.rentals_may (
select *
from sakila.rental
where date_format(rental_date, '%m') = 5);

-- 3
drop table if exists sakila.rentals_june;
create table if not exists sakila.rentals_june(
`rental_id` int unique NOT NULL,
`rental_date` datetime NOT NULL,
`inventory_id` mediumint unsigned NOT NULL,
`customer_id` smallint unsigned NOT NULL,
`return_date` datetime DEFAULT NULL,
`staff_id` tinyint unsigned NOT NULL,
`last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`rental_id`),
CONSTRAINT FOREIGN KEY (`inventory_id`) references inventory(inventory_id),
CONSTRAINT FOREIGN KEY (`customer_id`) references customer(customer_id),
CONSTRAINT FOREIGN KEY (`staff_id`) references staff(staff_id));

-- 4
insert into sakila.rentals_june (
select *
from sakila.rental
where date_format(rental_date, '%m') = 6);

-- 5
select customer_id, count(*) as rentals_may
from sakila.rentals_may
group by customer_id;

-- 6
select customer_id, count(*) as rentals_june
from sakila.rentals_june
group by customer_id;