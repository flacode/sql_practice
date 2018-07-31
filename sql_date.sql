/* Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals? */
    SELECT DATE_PART('year', o.occurred_at) AS Year, SUM(o.total_amt_usd) total_sales
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC;
    
/* Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset? */
    SELECT DATE_PART('month', o.occurred_at) AS month, SUM(o.total_amt_usd) total_sales
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1;

/* Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset? */
    SELECT DATE_PART('year', o.occurred_at) AS Year, SUM(o.total) total_number_of_orders
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1;

/* Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset? */
    SELECT DATE_PART('month', o.occurred_at) AS month, SUM(o.total) total_number_of_orders
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1;

/* In which month of which year did Walmart spend the most on gloss paper in terms of dollars? */
    SELECT DATE_TRUNC('month', o.occurred_at) AS Month, SUM(o.gloss_amt_usd) gloss_orders_amt
    FROM orders o
    JOIN accounts a
    ON a.id=o.account_id
    WHERE a.name='Walmart'
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1;
