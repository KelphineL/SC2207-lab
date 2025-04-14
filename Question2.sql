USE Lab5;
SELECT Phone, Investor_Name
FROM Investor I
WHERE 10 <= ALL 
            (SELECT Annualized_Return 
            FROM Portfolio P 
            WHERE P.Investor_Phone = I.Phone)