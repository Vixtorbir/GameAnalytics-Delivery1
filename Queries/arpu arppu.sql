SELECT SUM(Item.ItemPrice) AS Revenue
FROM Purchases
JOIN Item
ON Purchases.ItemID = Item.ItemID;

SELECT COUNT(UserID) AS Users
FROM User;

SELECT COUNT(DISTINCT SessionUser.UserID) AS PayingUsers
FROM Purchases
JOIN SessionUser
ON Purchases.SessionID = SessionUser.SessionID;

SELECT SUM(Item.ItemPrice) / COUNT(DISTINCT SessionUser.UserID) AS ARPU
FROM SessionUser
LEFT JOIN Purchases
ON SessionUser.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID;

SELECT SUM(Item.ItemPrice) / COUNT(DISTINCT SessionUser.UserID) AS ARPPU
FROM Purchases
JOIN SessionUser
ON Purchases.SessionID = SessionUser.SessionID
JOIN Item
ON Purchases.ItemID = Item.ItemID;

SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Last30.UserID) AS MAU,
SUM(Item.ItemPrice) / COUNT(DISTINCT Today.SessionID) AS Revenue30,
SUM(Item.ItemPrice) / COUNT(DISTINCT Today.SessionID) / COUNT(DISTINCT Last30.UserID) AS ARPU
FROM SessionUser Today
JOIN SessionUser Last30
ON TIMESTAMPDIFF(DAY, DATE(Last30.StartSession), DATE(Today.StartSession)) BETWEEN 0 AND 29
LEFT JOIN Purchases
ON Last30.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID
GROUP BY DATE(Today.StartSession)
ORDER BY Day;

SELECT DATE(Today.StartSession) AS Day,
COUNT(DISTINCT Last30.UserID) AS PayingUsers,
SUM(Item.ItemPrice) / COUNT(DISTINCT Today.SessionID) AS Revenue30,
SUM(Item.ItemPrice) / COUNT(DISTINCT Today.SessionID) / COUNT(DISTINCT Last30.UserID) AS ARPPU
FROM SessionUser Today
JOIN SessionUser Last30
ON TIMESTAMPDIFF(DAY, DATE(Last30.StartSession), DATE(Today.StartSession)) BETWEEN 0 AND 29
JOIN Purchases
ON Last30.SessionID = Purchases.SessionID
JOIN Item
ON Purchases.ItemID = Item.ItemID
GROUP BY DATE(Today.StartSession)
ORDER BY Day;
