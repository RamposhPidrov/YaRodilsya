SELECT 
    subQ.maker,
    SUM(subQ.CNT) AS 'Models qty',
    SUM(IF(subQ.CNT = 1, 0, subQ.CNT)) AS 'Common prices qty'
FROM
    (SELECT 
		maker,
		CASE Product.type
			WHEN 'Printer' THEN printer.price
			WHEN 'Laptop' THEN laptop.price
			WHEN 'PC' THEN pc.price
		END AS priceD,
		COUNT(maker) AS CNT
    FROM
        Product
			LEFT JOIN Laptop 
				ON Product.model = Laptop.model
			LEFT JOIN PC 
				ON PC.model = Product.model
			LEFT JOIN Printer 
				ON Printer.model = Product.model
    GROUP BY priceD) AS subQ
GROUP BY subQ.maker