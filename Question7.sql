USE Lab5;
SELECT Gender, SUM(Amount) AS Total_Gain_Loss
FROM Investor I
JOIN Unrealized_Gain_Loss UGL
ON I.Phone = UGL.investor_phone
GROUP BY Gender