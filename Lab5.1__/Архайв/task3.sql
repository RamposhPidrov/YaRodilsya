SELECT 
    P.maker,
    P.type,
    ROUND(COUNT(P.model) / subQ.total, 4) * 100 AS procent
FROM
    product AS P
        LEFT JOIN
    (SELECT 
        COUNT(model) AS total, maker
    FROM
        product
    GROUP BY maker) AS subQ ON subQ.maker = P.maker
GROUP BY P.type , P.maker