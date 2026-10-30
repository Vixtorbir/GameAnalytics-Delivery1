SELECT COUNT(SessionID) AS Sessions
FROM SessionUser;

SELECT AVG(TIMESTAMPDIFF(SECOND, StartSession, EndSession)) AS AvgSessionLength
FROM SessionUser;

SELECT User.UserID, User.UserName, COUNT(SessionUser.SessionID) AS Sessions
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
GROUP BY User.UserID, User.UserName
ORDER BY Sessions DESC;

SELECT User.UserCountry, COUNT(SessionUser.SessionID) AS Sessions
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
GROUP BY User.UserCountry
ORDER BY Sessions DESC;

SELECT User.UserCountry, AVG(TIMESTAMPDIFF(SECOND, SessionUser.StartSession, SessionUser.EndSession)) AS AvgSessionLength
FROM User
JOIN SessionUser
ON User.UserID = SessionUser.UserID
GROUP BY User.UserCountry
ORDER BY AvgSessionLength DESC;
