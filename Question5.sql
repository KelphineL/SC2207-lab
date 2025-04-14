USE Lab5;
WITH Asset_PID AS (
    (SELECT ID, PID 
	 FROM Stock_In_Portfolio)
    UNION
    (SELECT ID, PID 
	 FROM Bond_In_Portfolio)
    UNION
    (SELECT ID, PID 
	 FROM Fund_In_Portfolio)
), Asset_Transaction AS (
    (SELECT stock_transaction_date AS Transaction_Date, stock_ID AS ID, transaction_type
     FROM Stock_Transaction)
    UNION
    (SELECT bond_transaction_date AS Transaction_Date, bond_ID AS ID, transaction_type
     FROM Bond_Transaction)
    UNION
    (SELECT fund_transaction_date AS Transaction_Date, fund_ID AS ID, transaction_type
     FROM Fund_Transaction)
)
SELECT Phone, Investor_Name
FROM Investor I
WHERE EXISTS (	SELECT Portfolio_PID 
				FROM Portfolio P
				WHERE P.Investor_Phone = I.Phone
				AND 12 = (SELECT COUNT(DISTINCT AST.Transaction_Date)
  						  FROM   Asset_PID ASP
						  JOIN  Asset_Transaction AST
						  ON ASP.ID = AST.ID
					      WHERE ASP.PID = P.Portfolio_PID AND AST.transaction_type = 'Top Up' 
						  AND DAY(AST.Transaction_Date) = 1)
);