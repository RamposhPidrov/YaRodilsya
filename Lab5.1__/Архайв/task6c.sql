SELECT 
    ROUND(AVG(price), 3)
FROM
    printer
        JOIN
    (SELECT 
        MAX(price) AS m
    FROM
        printer
    GROUP BY model) AS r ON r.m = printer.price
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
                    model IN (SELECT 
                            model
                        FROM
                            laptop
                                JOIN
                            (SELECT 
                                MAX(ram) AS m
                            FROM
                                laptop) AS m ON m.m = laptop.ram))
                AND type = 'printer')