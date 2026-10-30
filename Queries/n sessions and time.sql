SELECT 
    UserID,
    COUNT(SessionID) AS total_sessions,
    ROUND(AVG(TIMESTAMPDIFF(SECOND, StartSession, EndSession)) / 60.0, 2) AS avg_session_length_minutes,
    ROUND(SUM(TIMESTAMPDIFF(SECOND, StartSession, EndSession)) / 60.0, 2) AS total_time_spent_minutes
FROM SessionUser
GROUP BY UserID
ORDER BY total_sessions DESC;