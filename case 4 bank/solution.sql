-- 1. What are the names of all the customers who live in New York?
select concat(firstname , ' ' , lastname) as fullname
from customers
where city = 'New York' ;
-- **************************************

-- 2. What is the total number of accounts in the Accounts table?
select count(accountid) as total
from accounts;

-- ***************************************

-- 3. What is the total balance of all checking accounts?
select sum(balance) as total
from accounts
where AccountType = 'Checking';

-- ******************************************
--  4. What is the total balance of all accounts associated with customers who live in Los Angeles?

SELECT SUM(Balance) AS TotalBalanceLosAngeles
FROM Accounts as a
	JOIN Customers as c
		ON a.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles';
-- ******************************************

-- 5. Which branch has the highest average account balance?
SELECT
    b.branchName
    , AVG(a.Balance) as branch_balance
FROM
    branches b
    JOIN accounts a 
		ON b.BranchID = a.BranchID
GROUP BY b.branchName
ORDER BY
    AVG(a.Balance) DESC
LIMIT 1;
-- ******************************************
					
-- 6. Which customer has the highest current balance in their accounts?
SELECT
	concat(firstname , ' ' , lastname) as fullname
    , sum(Balance) as total
FROM customers as c
	join accounts a 
		on c.CustomerID = a.CustomerID
group by 1
order by sum(Balance) desc
limit 1;

-- ******************************************

-- 7. Which customer has made the most transactions in the Transactions table?
select 
	concat(firstname , ' ' , lastname) as full_name
    , count(transactionid) as total_transactions
from customers 
	join accounts using(customerid) 
    join transactions using(accountid)
group by full_name
order by count(transactionid) desc
limit 1;
-- ******************************************
	
-- 8.Which branch has the highest total balance across all of its accounts?
select 
	branchname, 
    sum(balance) as total_balance
from 
	branches 
    join accounts using(branchid)
group by 1
order by total_balance desc
limit 1;

-- ******************************************

-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
WITH CTE AS (
    SELECT
        CONCAT(firstname , ' ' , lastname) AS full_name,
        balance,
        accounttype,
        DENSE_RANK() OVER (PARTITION BY accounttype ORDER BY balance DESC) AS rankk
    FROM
        customers
        JOIN accounts USING (customerid)
)
SELECT *
FROM CTE
WHERE rankk = 1 AND balance > 0;

-- ******************************************

-- 10. Which branch has the highest number of transactions in the Transactions table?
select 
	branchname
    , count(transactionid) as transactions
from 
	branches 
    join accounts using(branchid) 
    join transactions using(accountid)
group by branchname
order by transactions desc
limit 1;

-- ******************************************