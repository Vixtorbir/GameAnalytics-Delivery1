SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Today.UserID) AS Players,
COUNT(DISTINCT Later.UserID) AS PlayersBack,
COUNT(DISTINCT Later.UserID) / COUNT(DISTINCT Today.UserID) AS D1
FROM SessionUser Today
LEFT JOIN SessionUser Later
ON Today.UserID = Later.UserID
AND TIMESTAMPDIFF(DAY, DATE(Today.StartSession), DATE(Later.StartSession)) = 1
GROUP BY DATE(Today.StartSession)
ORDER BY Day;

SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Today.UserID) AS Players,
COUNT(DISTINCT Later.UserID) AS PlayersBack,
COUNT(DISTINCT Later.UserID) / COUNT(DISTINCT Today.UserID) AS D3
FROM SessionUser Today
LEFT JOIN SessionUser Later
ON Today.UserID = Later.UserID
AND TIMESTAMPDIFF(DAY, DATE(Today.StartSession), DATE(Later.StartSession)) = 3
GROUP BY DATE(Today.StartSession)
ORDER BY Day;

SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Today.UserID) AS Players,
COUNT(DISTINCT Later.UserID) AS PlayersBack,
COUNT(DISTINCT Later.UserID) / COUNT(DISTINCT Today.UserID) AS D7
FROM SessionUser Today
LEFT JOIN SessionUser Later
ON Today.UserID = Later.UserID
AND TIMESTAMPDIFF(DAY, DATE(Today.StartSession), DATE(Later.StartSession)) = 7
GROUP BY DATE(Today.StartSession)
ORDER BY Day;
