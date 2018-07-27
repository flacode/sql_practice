SQL

Clauses
1. LIMIT 
        SELECT occurred_at, account_id, channel
        FROM web_events
        LIMIT 15;
        
2. ORDER_BY
    Ascending order.
        SELECT occurred_at, account_id, channel
        FROM web_events
        ORDER BY occorred_at
        LIMIT 15;
    Descending order.
        SELECT occurred_at, account_id, channel
        FROM web_events
        ORDER BY occurred_at DESC
        LIMIT 15;
    DESC works for the intermediate column
    
3. WHERE
        SELECT name, website
        FROM accounts
        WHERE primary_poc = 'Exxon Mobil';

4. ARITHMETIC OPERATION.
    Can be used to generate derived columns for example
        SELECT a+b as sum
        FROM xxx

Introduction to Logical Operators
In the next concepts, you will be learning about Logical Operators. Logical Operators include:
1. LIKE
    This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for. We use wildcards.

    Wildcard	Description
    %	A substitute for zero or more characters
    _	A substitute for a single character
    [charlist] can be a range eg ‘[a-e]’ or can be a list ‘[a,b,c,d,e]’	Sets and ranges of characters to match
    [^charlist] or [!charlist]	Matches only a character NOT specified within the brackets

2. IN
    This allows you to perform operations similar to using WHERE and =, but for more than one condition ie using several filters.
his operator allows you to use an =, but for more than one item of that particular column. We can check one, two or many column values for which we want to pull data, but all within the same query. 
    The IN operator is a shorthand for multiple OR conditions.
    The following SQL statement selects all customers that are from the same countries as the suppliers:
	
	Example
        	SELECT * FROM Customers
        	WHERE Country IN (SELECT Country FROM Suppliers);

3. NOT
    This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

4. AND & BETWEEN
    These allow you to combine operations where all combined conditions must be true.

5. OR
    This allow you to combine operations where at least one of the combined conditions must be true.


Write Your First JOIN
Below is a JOIN, you will get a lot of practice writing these, and there is no better way to learn than practice. You will notice, we have introduced two new parts to our regular queries: JOIN and ON. The JOIN introduces the second table from which you would like to pull data, and the ON tells you how you would like to merge the tables in the FROM and JOIN statements together.
    SELECT orders.*  /* can be table.column name or */
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

What to Notice
We are able to pull data from two tables:
1. orders
2. accounts
Above, we are only pulling data from the orders table since in the SELECT statement we only reference columns from the orders table.
The ON statement holds the two columns that get linked across the two tables. This will be the focus in the next concepts.
Additional Information
If we wanted to only pull individual elements from either the orders or accounts table, we can do this by using the exact same information in the FROM and ON statements. However, in your SELECT statement, you will need to know how to specify tables and columns in the SELECT statement:
1. The table name is always before the period.
2. The column you want from that table is always after the period.
For example, if we want to pull only the account name and the dates in which that account placed an order, but none of the other columns, we can do this with the following query:
    SELECT accounts.name, orders.occurred_at
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;
This query only pulls two columns, not all the information in these two tables. Alternatively, the below query pulls all the columns from both the accounts and orders table.
    SELECT *
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;
And the first query you ran pull all the information from only the orders table:
    SELECT orders.*
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;
Joining tables allows you access to each of the tables in the SELECT statement through the table name, and the columns will always follow a . after the table name.

Notice
Notice our SQL query has the two tables we would like to join - one in the FROM and the other in the JOIN. Then in the ON, we will ALWAYs have the PK equal to the FK:
The way we join any two tables is in this way: linking the PK and FK (generally in an ON statement).


To join three tables.
If we wanted to join all three of these tables, we could use the same logic. The code below pulls all of the data from all of the joined tables.
    SELECT *
    FROM web_events
    JOIN accounts
    ON web_events.account_id = accounts.id
    JOIN orders
    ON accounts.id = orders.account_id

Inner joins: https://www.youtube.com/watch?v=CxuHtd1Daqk
https://youtu.be/4edRxFmWUEw

NB: If you have two or more columns in your SELECT that have the same name after the table name such as accounts.name and sales_reps.name you will need to alias them. Otherwise it will only show one of the columns. You can alias them like accounts.name AS AcountName, sales_rep.name AS SalesRepName





