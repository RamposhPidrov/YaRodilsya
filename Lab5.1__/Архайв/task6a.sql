SELECT 
    ROUND(AVG(m), 3)
FROM
    laptop
		JOIN
    (SELECT 
        MIN(price) AS m
    FROM
        laptop
    GROUP BY model) AS y ON y.m = laptop.price
WHERE
    model IN (SELECT 
            model
        FROM
            product
        WHERE
            type = 'laptop'
                AND maker IN (SELECT 
                    t.maker
                FROM
                    pc
                        LEFT JOIN
                    (SELECT 
                        MIN(cd) AS min
                    FROM
                        pc) AS min ON min.min = pc.cd
                        LEFT JOIN
                    product AS t ON pc.model = t.model
                WHERE
                    min.min IS NOT NULL))
        AND m IS NOT NULL