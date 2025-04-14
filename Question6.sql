USE Lab5;
WITH Company_Goal AS (
	SELECT I.Company, FG.Goal, COUNT(*) AS Goal_Count
	FROM Investor I
	JOIN Financial_Goal FG 
	ON I.Phone = FG.investor_phone
	WHERE Year(dob) BETWEEN 1984 AND 1995
	GROUP BY I.Company, FG.Goal
), Most_Goal AS (
		SELECT Company, MAX(Goal_Count) AS Most_Count
		FROM Company_Goal
		GROUP BY Company)
SELECT MG.Company, CG.Goal AS Most_Popular_Goal
FROM Most_Goal MG
JOIN Company_Goal CG 
ON MG.Company = CG.Company AND MG.Most_Count = CG.Goal_Count;