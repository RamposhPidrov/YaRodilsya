SELECT 
    subQ.number, P.maker, P.model
FROM
    Product AS P
        LEFT JOIN
    (SELECT 
        @i:=@i + 1 AS number, subP.maker
    FROM
        (SELECT 
        COUNT(subP.model) AS count, subP.maker
    FROM
        Product AS subP
    GROUP BY subP.maker
    ORDER BY count DESC , maker) AS subP, (SELECT @i:=0) AS t) AS subQ ON subQ.maker = P.maker

