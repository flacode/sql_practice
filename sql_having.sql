/* How many of the sales reps have more than 5 accounts that they manage? */

    SELECT s.name, COUNT(*) num_of_accounts
    FROM accounts a
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    GROUP BY s.name
    HAVING COUNT(*) >=5
    ORDER BY num_of_accounts;


/* How many accounts have more than 20 orders? */
 
    SELECT a.name, COUNT(o.id) no_of_orders
    FROM accounts a
    JOIN orders o
    ON o.account_id= a.id
    GROUP BY a.name
    HAVING COUNT(o.id) > 20
    ORDER BY no_of_orders;
 
/* Which account has the most orders? */
    SELECT a.name, COUNT(*) no_of_orders
    FROM accounts a
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY a.name
    ORDER BY no_of_orders DESC
    LIMIT 1;

/* How many accounts spent more than 30,000 usd total across all orders? */
    SELECT COUNT(*) accounts_spent_more_than_30000
    FROM (
        SELECT a.id, a.name
        FROM accounts a
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY a.id, a.name
        HAVING SUM(o.total_amt_usd) > 30000
    ) as table1;


/* Which account has spent the most with us? */
    SELECT a.id, a.name, SUM(o.total_amt_usd) usd_spent
    FROM accounts a
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY a.id, a.name
    ORDER BY usd_spent DESC
    LIMIT 1;


/* Which accounts used facebook as a channel to contact customers more than 6 times? */
    SELECT a.id, a.name, w.channel, COUNT(*) times_used
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    HAVING COUNT(*) > 6 AND channel = 'facebook'
    ORDER BY times_used;


/* Which account used facebook most as a channel? */
    SELECT a.id, a.name, w.channel, COUNT(*) times_used
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    HAVING channel = 'facebook'
    ORDER BY times_used DESC
    LIMIT 1;

/* Which channel was most frequently used by most accounts? */
    SELECT a.id, a.name, w.channel, COUNT(*) times_used
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    ORDER BY times_used DESC
    LIMIT 10;




                         