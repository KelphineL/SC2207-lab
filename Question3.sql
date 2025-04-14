USE Lab5;
SELECT MONTH(unrealized_gains_loss_date) AS Month, AVG(Amount) AS Average_Amount
FROM Unrealized_Gain_Loss
GROUP BY MONTH(unrealized_gains_loss_date)