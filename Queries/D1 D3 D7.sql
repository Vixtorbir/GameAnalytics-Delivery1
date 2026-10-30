WITH UserFirstSession AS (
    SELECT 
        UserID, 
        MIN(DATE(StartSession)) AS cohort_date,
        DATE_FORMAT(MIN(StartSession), '%Y-%m') AS session_month
    FROM SessionUser
    GROUP BY UserID
),
UserActivity AS (
    SELECT DISTINCT 
        UserID, 
        DATE(StartSession) AS session_date
    FROM SessionUser
)
SELECT 
    f.session_month,
    COUNT(f.UserID) AS Cohort_Size,
    ROUND(SUM(CASE WHEN DATEDIFF(a.session_date, f.cohort_date) = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(f.UserID), 2) AS D1_Retention,
    ROUND(SUM(CASE WHEN DATEDIFF(a.session_date, f.cohort_date) = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(f.UserID), 2) AS D3_Retention,
    ROUND(SUM(CASE WHEN DATEDIFF(a.session_date, f.cohort_date) = 7 THEN 1 ELSE 0 END) * 100.0 / COUNT(f.UserID), 2) AS D7_Retention
FROM UserFirstSession f
LEFT JOIN UserActivity a ON f.UserID = a.UserID
GROUP BY f.session_month
ORDER BY f.session_month ASC;