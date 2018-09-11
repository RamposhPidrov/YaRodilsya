SELECT 
    subQ.maker,
    SUM(subQ.CNT) AS 'Models qty',
    SUM(IF(subQ.CNT = 1, 0, subQ.CNT)) AS 'Common prices qty'
FROM
    (SELECT 
		maker,
		CASE product.type
			WHEN 'Printer' THEN printer.price
			WHEN 'Laptop' THEN laptop.price
			WHEN 'PC' THEN pc.price
		END AS priceD,
		COUNT(maker) AS CNT
    FROM
        product
			LEFT JOIN laptop 
				ON product.model = laptop.model
			LEFT JOIN pc 
				ON pc.model = product.model
			LEFT JOIN printer 
				ON printer.model = product.model
    GROUP BY priceD) AS subQ
GROUP BY subQ.maker