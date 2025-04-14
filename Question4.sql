USE Lab5;
Select TOP 3 Goal, Count(*) AS Goal_count
FROM (SELECT investor_phone, MIN(timeline) AS MinTimeline
		FROM Financial_Goal 
		GROUP BY investor_phone) FG
JOIN Financial_Goal FG2
ON FG2.investor_phone = FG.investor_phone And FG2.Timeline = FG.MinTimeline
GROUP BY Goal
ORDER BY COUNT(*) DESC