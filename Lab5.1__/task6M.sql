SELECT 
    AVG(a)
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        ROUND(AVG(m), 3) a
    FROM
        Laptop
    JOIN (SELECT 
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
                    LEFT JOIN (SELECT 
                        MIN(cd) AS min
                    FROM
                        PC) AS min ON min.min = PC.cd
                    LEFT JOIN Product AS t ON PC.model = t.model))
            AND m IS NOT NULL) AS A UNION (SELECT 
        ROUND(AVG(price), 3) a
    FROM
        PC
    JOIN (SELECT 
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
                            JOIN (SELECT 
                                MIN(price) AS min
                            FROM
                                Printer) AS sub ON price = sub.min))
                    AND type = 'PC')
            AND h IS NOT NULL) UNION (SELECT 
        ROUND(AVG(price), 3) AS a
    FROM
        Printer
    JOIN (SELECT 
        MAX(price) AS m
    FROM
        Printer
    GROUP BY model) AS r ON r.m = Printer.price
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
                        model IN (SELECT 
                                model
                            FROM
                                Laptop
                            JOIN (SELECT 
                                MAX(ram) AS m
                            FROM
                                Laptop) AS m ON m.m = Laptop.ram))
                    AND type = 'Printer')
            AND m IS NOT NULL)) AS D
