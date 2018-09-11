SELECT 
    ROUND(AVG(price), 3)
FROM
    pc
        JOIN
    (SELECT 
        MAX(price) AS h
    FROM
        pc
    GROUP BY model) AS ss ON price = ss.h
WHERE
    model IN (SELECT 
            model
        FROM
            product
        WHERE
            maker IN (SELECT 
                    maker
                FROM
                    product
                WHERE
                    model IN (SELECT DISTINCT
                            model
                        FROM
                            printer
                                JOIN
                            (SELECT 
                                MIN(price) AS min
                            FROM
                                printer) AS sub ON price = sub.min))
                AND type = 'pc')
