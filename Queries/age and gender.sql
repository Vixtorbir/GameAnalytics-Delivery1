SELECT User.UserAge, COUNT(DISTINCT User.UserID) AS Users,
COUNT(SessionUser.SessionID) / COUNT(DISTINCT User.UserID) AS SessionsPerUser,
AVG(TIMESTAMPDIFF(SECOND, SessionUser.StartSession, SessionUser.EndSession)) AS AvgSessionLength
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
GROUP BY User.UserAge
ORDER BY User.UserAge;

SELECT User.UserAge, SUM(Item.ItemPrice) / COUNT(DISTINCT User.UserID) AS ARPU
FROM User
LEFT JOIN SessionUser
ON User.UserID = SessionUser.UserID
LEFT JOIN Purchases
ON SessionUser.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID
GROUP BY User.UserAge
ORDER BY User.UserAge;

SELECT COUNT(DISTINCT User.UserID) AS Users,
COUNT(SessionUser.SessionID) / COUNT(DISTINCT User.UserID) AS SessionsPerUser,
AVG(TIMESTAMPDIFF(SECOND, SessionUser.StartSession, SessionUser.EndSession)) AS AvgSessionLength
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
WHERE User.UserGender < 0.5;

SELECT COUNT(DISTINCT User.UserID) AS Users,
COUNT(SessionUser.SessionID) / COUNT(DISTINCT User.UserID) AS SessionsPerUser,
AVG(TIMESTAMPDIFF(SECOND, SessionUser.StartSession, SessionUser.EndSession)) AS AvgSessionLength
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
WHERE User.UserGender >= 0.5;

SELECT SUM(Item.ItemPrice) / COUNT(DISTINCT User.UserID) AS ARPU
FROM User
LEFT JOIN SessionUser
ON User.UserID = SessionUser.UserID
LEFT JOIN Purchases
ON SessionUser.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID
WHERE User.UserGender < 0.5;

SELECT SUM(Item.ItemPrice) / COUNT(DISTINCT User.UserID) AS ARPU
FROM User
LEFT JOIN SessionUser
ON User.UserID = SessionUser.UserID
LEFT JOIN Purchases
ON SessionUser.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID
WHERE User.UserGender >= 0.5;
