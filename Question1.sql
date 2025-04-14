USE Lab5;
SELECT Phone, Investor_Name
FROM Investor I, (SELECT investor_phone 
					FROM Unrealized_Gain_Loss
					GROUP BY investor_phone  
					HAVING AVG(Amount) < 0) I2
WHERE I.Phone = I2.investor_phone



