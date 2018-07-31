/* We would like to understand 3 different levels of customers based on the
amount associated with their purchases. The top branch includes anyone with a
Lifetime Value (total sales of all orders) greater than 200,000 usd. The second
branch is between 200,000 and 100,000 usd. The lowest branch is anyone under
100,000 usd. Provide a table that includes the level associated with each
account. You should provide the account name, the total sales of all orders for
the customer, and the level. Order with the top spending customers listed first.
*/

    SELECT a.name, SUM(o.total_amt_usd),
        CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'top'
            	WHEN SUM(o.total_amt_usd) >= 100000 AND SUM(o.total_amt_usd) <= 200000 THEN 'middle'
             ELSE 'low' END AS level
    FROM accounts a
    JOIN orders o
    ON a.id=o.account_id
    GROUP BY a.name
    ORDER BY 2 DESC;


/*We would like to understand 3 different levels of customers based on the
amount associated with their purchases. The top branch includes anyone with a
Lifetime Value (total sales of all orders) greater than 200,000 usd. The second
branch is between 200,000 and 100,000 usd. The lowest branch is anyone under
100,000 usd. Provide a table that includes the level associated with each
account. You should provide the account name, the total sales of all orders for
the customer, and the level. Order with the top spending customers listed first.
We would now like to obtain the total amount spent by customers only in 2016
and 2017.
*/

    SELECT a.name, SUM(o.total_amt_usd),
    CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'lifetime'
        	WHEN SUM(o.total_amt_usd) >= 100000 AND SUM(o.total_amt_usd) <= 200000 THEN 'middle'
         ELSE 'low' END AS level
    FROM accounts a
    JOIN orders o
    ON a.id=o.account_id
    WHERE DATE_PART('year', o.occurred_at) BETWEEN '2016' AND '2017'
    GROUP BY a.name  
    ORDER BY 2 DESC;

/* We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final table.
*/
    SELECT s.id, s.name,
    COUNT(o.total) orders,
    CASE WHEN COUNT(o.total) > 200 THEN 'top'
        	ELSE 'bottom' END AS category
    FROM sales_reps s
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON a.id=o.account_id
    GROUP BY s.id, s.name
    ORDER BY 3 DESC;

/* We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final table.
Management decides they want to see these characteristics represented as well.
We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders or more than 750000 in total sales. The
middle group has any rep with more than 150 orders or 500000 in sales. Create a
table with the sales rep name, the total number of orders, total sales across
all orders, and a column with top, middle, or low depending on this criteria.
Place the top sales people based on dollar amount of sales first in your final
table.*/


SELECT s.id, s.name,
COUNT(*) orders,
SUM(o.total_amt_usd) total_sales,
CASE
	WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
    WHEN (COUNT(*) <= 200 AND COUNT(*) > 150) OR (SUM(o.total_amt_usd) <= 750000 AND SUM(o.total_amt_usd) > 500000) THEN 'middle'
	ELSE 'low' END AS category
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id=o.account_id
GROUP BY s.id, s.name
ORDER BY 4 DESC;
