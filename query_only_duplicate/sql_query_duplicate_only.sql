SELECT code, COUNT(*) as count
FROM users
GROUP BY code
HAVING COUNT(*) > 1;