WITH DailyActiveUsers AS (
    SELECT DATE(StartSession) AS session_date, DATE_FORMAT(StartSession, '%Y-%m') AS session_month, COUNT(DISTINCT UserID) AS DAU 
    FROM SessionUser 
    GROUP BY DATE(StartSession), DATE_FORMAT(StartSession, '%Y-%m')
), 
MonthlyActiveUsers AS (
    SELECT DATE_FORMAT(StartSession, '%Y-%m') AS session_month, COUNT(DISTINCT UserID) AS MAU 
    FROM SessionUser 
    GROUP BY DATE_FORMAT(StartSession, '%Y-%m')
) 
SELECT m.session_month, ROUND(AVG(d.DAU), 2) AS Avg_DAU, m.MAU, ROUND((AVG(d.DAU) / m.MAU) * 100, 2) AS Stickiness_Percentage 
FROM MonthlyActiveUsers m 
JOIN DailyActiveUsers d ON m.session_month = d.session_month 
GROUP BY m.session_month, m.MAU 
ORDER BY m.session_month ASC;