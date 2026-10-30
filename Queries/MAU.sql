SELECT DATE(Today.StartSession) AS Day, COUNT(DISTINCT Last30.UserID) AS MAU
FROM SessionUser Today
JOIN SessionUser Last30
ON TIMESTAMPDIFF(DAY, DATE(Last30.StartSession), DATE(Today.StartSession)) BETWEEN 0 AND 29
GROUP BY DATE(Today.StartSession)
ORDER BY Day;
