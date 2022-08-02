CREATE TEMPORARY TABLE IF NOT EXISTS tempLifeCycleAnalysis AS (
SELECT
CASE 
	WHEN COUNT(customer_id) >= 3 THEN 3
	ELSE COUNT(customer_id)
END AS tempNumberOfOrders,
CASE
  WHEN (extract (year FROM CURRENT_TIMESTAMP) - extract (year FROM MAX(date))) > 3 THEN 3
  Else (extract (year FROM CURRENT_TIMESTAMP) - extract (year FROM MAX(date)))
END AS tempYearsSinceLastOrder,
SUM(cost) AS tempTotalRevenue
FROM Orders
GROUP BY customer_id
);

SELECT
tempNumberOfOrders AS "Number of orders", 
tempYearsSinceLastOrder AS "Years since last order", 
SUM(tempTotalRevenue) AS "Total Revenue"
FROM tempLifeCycleAnalysis 
GROUP BY tempNumberOfOrders, tempYearsSinceLastOrder;