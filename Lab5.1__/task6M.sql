SELECT 
    A.a, B.b, C.c
FROM
    (SELECT 
        ROUND(AVG(m), 3) a
    FROM
        laptop
    JOIN (SELECT 
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
                    LEFT JOIN (SELECT 
                        MIN(cd) AS min
                    FROM
                        PC) AS min ON min.min = PC.cd
                    LEFT JOIN product AS t ON PC.model = t.model))
            AND m IS NOT NULL) AS A,
    (SELECT 
        ROUND(AVG(price), 3) b
    FROM
        pc
    JOIN (SELECT 
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
                            JOIN (SELECT 
                                MIN(price) AS min
                            FROM
                                printer) AS sub ON price = sub.min))
                    AND type = 'PC')
            AND h IS NOT NULL) AS B,
    (SELECT 
        ROUND(AVG(price), 3) AS c
    FROM
        printer
    JOIN (SELECT 
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
                            JOIN (SELECT 
                                MAX(ram) AS m
                            FROM
                                laptop) AS m ON m.m = laptop.ram))
                    AND type = 'Printer')
            AND m IS NOT NULL) AS C