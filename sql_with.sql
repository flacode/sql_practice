/*
The WITH statement is often called a Common Table Expression or CTE
CTE improve readabilty for sub queries
Each CTE gets an alias.
*/

/* Provide the name of the sales_rep in each region with the largest amount of total_amt_usd
sales. */
/* 1.sales_rep_data => get the total sales and region for each sales rep
   2. region_data => group by the region and get the max sales for each region from sales_rep_data 
   3. Find the sales from sales_rep_data that correspond to region_data
*/
WITH sales_rep_data AS (SELECT s.name sales_rep, r.name region, SUM(o.total_amt_usd) sales
						FROM sales_reps s
						JOIN accounts a
						ON a.sales_rep_id=s.id
						JOIN orders o
						ON o.account_id=a.id
						JOIN region r
						ON r.id=s.region_id
						GROUP BY 1, 2),
     region_data AS (SELECT region, MAX(sales) max_sales
                     FROM sales_rep_data
                    GROUP BY region
)
SELECT s.sales_rep, s.region, r.max_sales largest_sales
FROM sales_rep_data s
JOIN region_data r
ON s.region = r.region and s.sales = r.max_sales;


/* For the region with the largest sales total_amt_usd, how many total orders were placed? */
/*
	1. region_data => find the total_amt_usd and orders per region
    2. Find the maximum of this and total orders
*/
WITH region_data AS (SELECT r.name region, SUM(o.total_amt_usd) sales, COUNT(o.total) total_orders
					FROM orders o
					JOIN accounts a
					ON o.account_id=a.id
					JOIN  sales_reps s
					ON a.sales_rep_id=s.id
					JOIN region r
					ON r.id=s.region_id
					GROUP BY 1),
     max_total_orders AS (SELECT MAX(total_orders) total_orders
						  FROM region_data
)
SELECT r.region, r.total_orders
FROM region_data r
JOIN max_total_orders m
ON r.total_orders = m.total_orders


/* For the name of the account that purchased the most (in total over their lifetime as a customer)
standard_qty paper, how many accounts still had more in total purchases?  */
/* 
	1. Get the standard_qty_data.
    2. Get the total orders for account with maximum standard_qty_data.
    3. Get all accounts with total orders greater than total for account with maximum
    standard_qty_orders
    
*/
WITH max_standard_qty AS (SELECT a.id, a.name, SUM(o.standard_qty) standard, SUM(o.total) total
						FROM accounts a
						JOIN orders o
						ON a.id=o.account_id
						GROUP BY 1, 2
                        ORDER BY 3 DESC
  						LIMIT 1),
     accounts_greater_than_max AS (SELECT a.id, a.name, SUM(o.total) total
									FROM accounts a
									JOIN orders o
									ON a.id=o.account_id
									GROUP BY 1, 2
									HAVING SUM(o.total) > (SELECT total FROM max_standard_qty)
)

SELECT COUNT(*) FROM accounts_greater_than_max



/*
For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd,
how many web_events did they have for each channel?
*/

/*
	1. customer => find customer who spent the most.
    2. customer_events => Find the number of web_events per customer.
    3. Return number of web_events for the customer in 1
*/
   
WITH customer AS (SELECT a.id, a.name, SUM(o.total_amt_usd) total_sales
 					FROM accounts a
 					JOIN orders o
 					ON o.account_id = a.id
 					GROUP BY 1, 2
 					ORDER BY 3 DESC
 					LIMIT 1
)


SELECT a.id, a.name, w.channel, COUNT(*) no_of_events
FROM accounts a
JOIN web_events w
ON w.account_id=a.id
WHERE a.id = (SELECT id FROM customer)
GROUP BY 1, 2, 3

/*
In the accounts table, there is a column holding the website for each company. The last three digits
specify what type of web address they are using. Pull these extensions and provide how many of each
website type exist in the accounts table.
*/

SELECT RIGHT(website, '3') web_domain, COUNT(*) no_of_companies
FROM accounts
GROUP BY 1

/*
There is much debate about how much the name (or even the first letter of a company name) matters.
Use the accounts table to pull the first letter of each company name to see the distribution of
company names that begin with each letter (or number). 
*/
SELECT LEFT(UPPER(name), 1) first_letter, COUNT(*) no_of_companies
FROM accounts
GROUP BY 1
ORDER BY 1

/* Use the accounts table and a CASE statement to create two groups: one group of company names that
start with a number and a second group of those company names that start with a letter. What proportion
of company names start with a letter? */

SELECT SUM(nums) numbers, SUM(letters)letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2','3','4','5','6','7','8','9')
				THEN 1 ELSE 0 END AS nums,
               CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2','3','4','5','6','7','8','9')
				THEN 0 ELSE 1 END AS letters
      FROM accounts)t1

/*Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what
percent start with anything else?*/

SELECT SUM( vowel) vowel, SUM(no_vowel) no_vowel
FROM (SELECT name, CASE WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i','o','u')
				THEN 1 ELSE 0 END AS vowel,
               CASE WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i','o','u')
				THEN 0 ELSE 1 END AS no_vowel
      FROM accounts)t1
                                                 
                                                

                                                 
                                                
