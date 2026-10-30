SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Today.UserID) AS DAU,
COUNT(DISTINCT Last30.UserID) AS MAU,
COUNT(DISTINCT Today.UserID) / COUNT(DISTINCT Last30.UserID) AS Stickiness
FROM SessionUser Today
JOIN SessionUser Last30
ON TIMESTAMPDIFF(DAY, DATE(Last30.StartSession), DATE(Today.StartSession)) BETWEEN 0 AND 29
GROUP BY DATE(Today.StartSession)
ORDER BY Day;
