SELECT DATE(StartSession) AS session_date, COUNT(DISTINCT UserID) AS DAU
FROM SessionUser
GROUP BY DATE(StartSession)
ORDER BY session_date ASC;