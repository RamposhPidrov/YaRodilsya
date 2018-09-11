SELECT 
    ROUND(AVG(price), 3)
FROM
    PC
        JOIN
    (SELECT 
        MAX(price) AS h
    FROM
        PC
    GROUP BY model) AS ss ON price = ss.h
WHERE
    model IN (SELECT 
            model
        FROM
            Product
        WHERE
            maker IN (SELECT 
                    maker
                FROM
                    Product
                WHERE
                    model IN (SELECT DISTINCT
                            model
                        FROM
                            Printer
                                JOIN
                            (SELECT 
                                MIN(price) AS min
                            FROM
                                Printer) AS sub ON price = sub.min))
                AND type = 'PC')
