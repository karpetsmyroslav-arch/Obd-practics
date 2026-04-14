SELECT COUNT(*) AS total_games FROM games;

SELECT
    AVG(games.baseprice) AS avg_price,
    MAX(games.baseprice) AS max_game_price,
    MIN(games.baseprice) AS min_game_price
FROM games;

SELECT agerating, COUNT(*) AS games_count
FROM games
GROUP BY agerating;

SELECT agerating, COUNT(*) AS games_count
FROM games
GROUP BY agerating
HAVING COUNT(*) > 2;

SELECT
    g.Title AS Game_Title,
    d.DevName AS Developer
FROM Games g
INNER JOIN GameDevelopers gd ON g.GameID = gd.GameID
INNER JOIN Developers d ON gd.DevID = d.DevID;

SELECT
    u.Nickname,
    COUNT(l.GameID) AS games_owned
FROM Users u
LEFT JOIN Library l ON u.UserID = l.UserID
GROUP BY u.Nickname;

SELECT
    d.DevName,
    p.PubName
FROM Developers d
CROSS JOIN Publishers p;

SELECT Title, BasePrice
FROM Games
WHERE BasePrice > (
    SELECT AVG(BasePrice) FROM Games
);

SELECT
    u.Nickname,
    (SELECT TotalPoints FROM Points p WHERE p.UserID = u.UserID) AS user_points
FROM Users u;

SELECT Title
FROM Games
WHERE GameID IN (
    SELECT DISTINCT GameID
    FROM Reviews
    WHERE Rating = 5
);

