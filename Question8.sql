USE Lab5;
SELECT (COUNT(DISTINCT investor_phone)/50.0)*100 AS percentage
FROM Financial_Goal 
WHERE goal = 'Fund education'
AND Year(timeline) >= 2015
