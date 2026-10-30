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

SELECT DATE(SessionUser.StartSession) AS Day, SUM(Item.ItemPrice) / COUNT(DISTINCT SessionUser.UserID) AS ARPU
FROM SessionUser
LEFT JOIN Purchases
ON SessionUser.SessionID = Purchases.SessionID
LEFT JOIN Item
ON Purchases.ItemID = Item.ItemID
GROUP BY DATE(SessionUser.StartSession)
ORDER BY Day;

SELECT DATE(SessionUser.StartSession) AS Day, SUM(Item.ItemPrice) / COUNT(DISTINCT SessionUser.UserID) AS ARPPU
FROM Purchases
JOIN SessionUser
ON Purchases.SessionID = SessionUser.SessionID
JOIN Item
ON Purchases.ItemID = Item.ItemID
GROUP BY DATE(SessionUser.StartSession)
ORDER BY Day;
