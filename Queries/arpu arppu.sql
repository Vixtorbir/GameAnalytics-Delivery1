WITH MonthlyUserRevenue AS (
    SELECT 
        DATE_FORMAT(s.StartSession, '%Y-%m') AS session_month,
        s.UserID,
        SUM(i.ItemPrice) AS user_revenue
    FROM SessionUser s
    JOIN Purchases p ON s.SessionID = p.SessionID
    JOIN Item i ON p.ItemID = i.ItemID
    GROUP BY DATE_FORMAT(s.StartSession, '%Y-%m'), s.UserID
),
MonthlyActiveUsers AS (
    SELECT 
        DATE_FORMAT(StartSession, '%Y-%m') AS session_month,
        COUNT(DISTINCT UserID) AS MAU
    FROM SessionUser
    GROUP BY DATE_FORMAT(StartSession, '%Y-%m')
)
SELECT 
    m.session_month,
    m.MAU,
    COUNT(DISTINCT r.UserID) AS paying_users,
    ROUND(COALESCE(SUM(r.user_revenue), 0), 2) AS total_revenue,
    ROUND(COALESCE(SUM(r.user_revenue), 0) / m.MAU, 2) AS ARPU,
    ROUND(COALESCE(SUM(r.user_revenue), 0) / NULLIF(COUNT(DISTINCT r.UserID), 0), 2) AS ARPPU
FROM MonthlyActiveUsers m
LEFT JOIN MonthlyUserRevenue r ON m.session_month = r.session_month
GROUP BY m.session_month, m.MAU
ORDER BY m.session_month ASC;