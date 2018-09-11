SELECT 
    ROUND(AVG(price), 3)
FROM
    Printer
        JOIN
    (SELECT 
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
                                JOIN
                            (SELECT 
                                MAX(ram) AS m
                            FROM
                                Laptop) AS m ON m.m = Laptop.ram))
                AND type = 'Printer')