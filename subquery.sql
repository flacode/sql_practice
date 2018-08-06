
/* Provide the name of the sales_rep in each region with the largest amount of
total_amt_usd sales. */

/*
1. Find the total sales and region for each sales rep => t2
2. Find the max sales per region  => t3
3. Select the accounts in t2 that are also in t3.
*/


SELECT t2.sales_rep, t2.region, t2.sales
FROM (SELECT s.name sales_rep, r.name region, SUM(total_amt_usd) sales
	FROM sales_reps s
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1, 2) t2
JOIN (SELECT t1.region, MAX(t1.sales) max_sales
	FROM(SELECT s.name sales_rep, r.name region, SUM(o.total_amt_usd) sales
		FROM sales_reps s
		JOIN accounts a
		ON a.sales_rep_id = s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1, 2) t1
	GROUP BY 1) t3
ON t3.region=t2.region AND t3.max_sales = t2.sales;

/* For the region with the largest (sum) of sales total_amt_usd, how many total
 (count) orders were placed? */
 
SELECT r.name region, SUM(o.total_amt_usd) sales, COUNT(o.total) orders_placed
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1


/* For the name of the account that purchased the most (in total over their
lifetime as a customer) standard_qty paper, how many accounts still had more
in total purchases? */

/* 1. Find account with maximum standard_qty => t1
   2. Find the total orders for this account
   3. Find accounts with total orders greater than 2 above => 2
   4. Count the number of accounts
 */

SELECT count(*) no_of_accounts
FROM (SELECT a.name, SUM(o.total) orders
	FROM accounts a
	JOIN orders o
	ON a.id=o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT t1.orders
    	FROM (SELECT a.name, SUM(o.standard_qty) standard_qty, SUM(o.total) orders
			FROM accounts a
			JOIN orders o
			ON a.id=o.account_id
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 1) t1)) t2;


/* For the customer that spent the most (in total over their lifetime as a customer)
total_amt_usd, how many web_events did they have for each channel*/

/* 1. Find customer who spent the most total_amt_usd => t1
   2. Find the number of events for each channel by grouping by account and channel
   3. Return only the accounts whose id corresponds to 1 above
 */


SELECT a.id, a.name, w.channel, COUNT(*) no_of_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = (SELECT t1.id
              FROM ( SELECT a.id, a.name, SUM(o.total_amt_usd) total_sales
					FROM accounts a
					JOIN orders o
					ON a.id=o.account_id
					GROUP BY 1, 2
					ORDER BY 3 DESC
					LIMIT 1
              ) t1
)
GROUP BY 1, 2, 3
ORDER BY 1

/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total
spending accounts? */

/*1. Find the total sales for the top 10 accounts => t1
  2. Find the average of the total sales for these accounts
*/
SELECT AVG(t1.total_amt_usd)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) total_amt_usd
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1, 2
	ORDER BY 3 DESC) t1
LIMIT 10;

/* What is the lifetime average amount spent in terms of total_amt_usd for only the companies
that spent more than the average of all orders.*/
/* 1. Find the average for all orders 
   2. Find all accounts that spent more than the average in 1 above => t1
   3. Find the average of this average
*/
SELECT AVG(t1.total_amt_usd) lifetime_average_amount
FROM (SELECT account_id, AVG(total_amt_usd) total_amt_usd
	FROM orders
	GROUP BY 1
	HAVING AVG(total_amt_usd) > (SELECT AVG(total_amt_usd) average_of_all_orders
								FROM orders)
	ORDER BY 1) t1                               
