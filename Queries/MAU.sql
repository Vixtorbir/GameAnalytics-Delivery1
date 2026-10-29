SELECT DATE_FORMAT(StartSession, '%Y-%m') AS session_month, COUNT(DISTINCT UserID) AS MAU

FROM SessionUser

GROUP BY DATE_FORMAT(StartSession, '%Y-%m')

ORDER BY session_month ASC;