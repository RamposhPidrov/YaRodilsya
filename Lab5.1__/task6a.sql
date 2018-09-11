SELECT 
    ROUND(AVG(m), 3)
FROM
    Laptop
		JOIN
    (SELECT 
        MIN(price) AS m
    FROM
        Laptop
    GROUP BY model) AS y ON y.m = Laptop.price
WHERE
    model IN (SELECT 
            model
        FROM
            Product
        WHERE
            type = 'Laptop'
                AND maker IN (SELECT 
                    t.maker
                FROM
                    PC
                        LEFT JOIN
                    (SELECT 
                        MIN(cd) AS min
                    FROM
                        PC) AS min ON min.min = PC.cd
                        LEFT JOIN
                    Product AS t ON PC.model = t.model
                WHERE
                    min.min IS NOT NULL))
        AND m IS NOT NULL