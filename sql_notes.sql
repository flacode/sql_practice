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

JOINs

1. JOIN - an INNER JOIN that only pulls data that exists in both tables.
2. LEFT JOIN - a way to pull all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
3. RIGHT JOIN - a way to pull all of the rows from the table in the JOIN even if they do not exist in the FROM statement.


AGGREGATION

NULLs are a datatype that specifies where no data exists in SQL. They are often ignored in our aggregation functions. 0 means that there was an attempt that yielded no results whill null means that there was no attempt.
NULL is a property of data and not a data value therefore in the WHERE clause you use 'IS' instead of '='. To negate the results use 'IS NOT NULL'.
An important thing to remember: aggregators only aggregate vertically - the values of a column. If you want to perform a calculation across rows, you would do this with simple arithmetic. is (+, -, *, / ) as in the previous examples.


1. SUM
This treats nulls as 0.
        SELECT SUM(col_1) col_1,
        SUM(col_2) col 2
        FROM table;


2. COUNT
Count does not consider rows with null values. For example
        SELECT COUNT(*)
        FROM accounts; /* this will count all the rows returned because its not counting basedo an indvidual column */
        
        SELECT COUNT(primary_pro)
        FROM accounts /* Here rows with null values in the primary_poc will not be considered. */ 

3. MIN AND MAX
Notice that MIN and MAX are aggregators that again ignore NULL values.
Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns. Depending on the column type, MIN will return the lowest number, earliest date, or non-numerical value as early in the alphabet as possible. As you might suspect, MAX does the opposite—it returns the highest number, the latest date, or the non-numerical value closest alphabetically to “Z.”

4. AVERAGE
Similar to other software AVG returns the mean of the data - that is the sum of all of the values in the column divided by the number of values in a column. This aggregate function again ignores the NULL values in both the numerator and the denominator.

If you want to count NULLs as zero, you will need to use SUM and COUNT. However, this is probably not a good idea if the NULL values truly just represent unknown values for a cell.

MEDIAN - Expert Tip
One quick note that a median might be a more appropriate measure of center for this data, but finding the median happens to be a pretty difficult thing to get using SQL alone — so difficult that finding a median is occasionally asked as an interview question.

5. GROUP BY
Placed between WHERE and ORDER BY if they exist.
GROUP BY can be used to aggregate data within subsets of the data other than the whole table.
        Any column in the SELECT statement that is not within an aggregator must be in the GROUP BY clause.

GROUP BY - Expert Tip
Before we dive deeper into aggregations using GROUP BY statements, it is worth noting that SQL evaluates the aggregations before the LIMIT clause. If you don’t group by any columns, you’ll get a 1-row result—no problem there. If you group by a column with enough unique values that it exceeds the LIMIT number, the aggregates will be calculated, and then some rows will simply be omitted from the results.

This is actually a nice way to do things because you know you’re going to get the correct aggregates. If SQL cuts the table down to 100 rows, then performed the aggregations, your results would be substantially different. The above query’s results exceed 100 rows, so it’s a perfect example. In the next concept, use the SQL environment to try removing the LIMIT and running it again to see what changes.


6. DISTINCT
DISTINCT is always used in SELECT statements, and it provides the unique rows for all columns written in the SELECT statement. Therefore, you only use DISTINCT once in any particular SELECT statement.

You could write:

    SELECT DISTINCT column1, column2, column3
    FROM table1;
which would return the unique (or DISTINCT) rows across all three columns.

You would not write:

    SELECT DISTINCT column1, DISTINCT column2, DISTINCT column3
    FROM table1;
You can think of DISTINCT the same way you might think of the statement "unique".

DISTINCT - Expert Tip
It’s worth noting that using DISTINCT, particularly in aggregations, can slow your queries down quite a bit.


7. HAVING

WHERE can not be used with an aggregated value, HAVING comes in to save the day.

HAVING - Expert Tip
HAVING is the “clean” way to filter a query that has been aggregated, but this is also commonly done using a subquery. Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.


8. 
SQL_DATE formt => yyyy-mm-dd
GROUPing BY a date column is not usually very useful in SQL, as these columns tend to have transaction data down to a second. Keeping date information at such a granular data is both a blessing and a curse, as it gives really precise information (a blessing), but it makes grouping information together directly difficult (a curse).

Lucky for us, there are a number of built in SQL functions that are aimed at helping us improve our experience in working with dates.

Here we saw that dates are stored in year, month, day, hour, minute, second, which helps us in truncating. In the next concept, you will see a number of functions we can use in SQL to take advantage of this functionality.

9. DATE_TRUNC

DATE_TRUNC allows you to truncate your date to a particular part of your date-time column. Common trunctions are day, month, and year. 
https://blog.modeanalytics.com/date-trunc-sql-timestamp-function-count-on/

10. DATE_PART
DATE_PART can be useful for pulling a specific portion of a date, but notice pulling month or day of the week (dow) means that you are no longer keeping the years in order. Rather you are grouping for certain components regardless of which year they belonged in.
https://www.postgresql.org/docs/9.1/static/functions-datetime.html

dow returns a value between Sunday and Saturday where 0 is Sunday and 6 is Saturday


11. CASE

The CASE statement always goes in the SELECT clause.

CASE must include the following components: WHEN, THEN, and END. ELSE is an optional component to catch cases that didn’t meet any of the other previous CASE conditions.

You can make any conditional statement using any conditional operator (like WHERE) between WHEN and THEN. This includes stringing together multiple conditional statements using AND and OR.

You can include multiple WHEN statements, as well as an ELSE statement again, to deal with any unaddressed conditions.
         SELECT col1,
         col2, 
         CASE WHEN condition THEN true ELSE false END AS Name_of_derived_column
         FROM tablex;

can be used to avoif divide by zero errors encountered earlier for example.
    SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
    FROM orders
    LIMIT 10;
    
Solution: 
    SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                            ELSE standard_amt_usd/standard_qty END AS unit_price
    FROM orders
    LIMIT 10;
With CASE you can query for data using multiple conditions ie you can have multiple WHEN/THEN pairs.



1 .POSITION takes a character and a column, and provides the index where that character is for each row.
The index of the first position is 1 in SQL. If you come from another programming language, many begin
indexing at 0. Here, you saw that you can pull the index of a comma as POSITION(',' IN city_state).


2. STRPOS provides the same result as POSITION, but the syntax for achieving those results is a bit
different as shown here: STRPOS(city_state, ',').
Note, both POSITION and STRPOS are case sensitive, so looking for A is different than looking for a. 
Therefore, if you want to pull an index regardless of the case of a letter, you might want to use 
LOWER or UPPER to make all of the characters lower or uppercase.


CONCAT and Piping ||
Each of these will allow you to combine columns together across rows. For example 
first and last names stored in separate columns could be combined together to create a full name: 
1. CONCAT => CONCAT(first_name, ' ', last_name) 
2. piping => first_name || ' ' || last_name.


CASTING
1. TO_DATE
2. CAST
3. Casting with ::
DATE_PART('month', TO_DATE(month, 'month')) here changed a month name into the number associated with
that particular month.
eg. To convert May to a number, May can be replaced with a column to support dynamic data.
/*
    SELECT DATE_PART('month', TO_DATE('May', 'month'))
*/

Convert month to a number, concat with day and year to get a date string, convert date string into sql date.
Get the day of the week from this date.
/* SELECT DATE_PART('dow',
                    CAST(CONCAT(DATE_PART('month', TO_DATE('May', 'month')), '-9', '-1994') AS date))
*/


Then you can change a string to a date using CAST. CAST is actually useful to change lots of column types.
Commonly you might be doing as you saw here, where you change a string to a date using CAST(date_column AS DATE).
However, you might want to make other changes to your columns in terms of their data types.
You can see other examples http://www.postgresqltutorial.com/postgresql-cast/

In this example, you also saw that instead of CAST(date_column AS DATE), you can use date_column::DATE.

These 3 functions are specific to strings. They won’t work with dates, integers or floating-point numbers.
However, using any of these functions will automatically change the data to the appropriate type.

LEFT, RIGHT, and TRIM are all used to select only certain elements of strings, but using them to select elements
of a number or date will treat them as strings for the purpose of the function. Though we didnot cover TRIM in this
lesson explicitly, it can be used to remove characters from the beginning and end of a string. This can remove
unwanted spaces at the beginning or end of a row that often happen with data being moved from Excel or other storage systems.

There are a number of variations of these functions, as well as several other string functions not covered here.
Different databases use subtle variations on these functions, so be sure to look up the appropriate database’s syntax if you’re
connected to a private database.
The Postgres literature contains a lot of the related functions. (https://www.postgresql.org/docs/9.1/static/functions-string.html)

1. COALESCE
Used to work with NULL values. Used to specify the the value to substitute null values in a query. For example, to replace null with 0
SELECT COALESCE(column, 0)

Extra material
1. https://www.w3schools.com/sql/sql_isnull.asp
2. https://community.modeanalytics.com/sql/tutorial/sql-string-functions-for-cleaning/