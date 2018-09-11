SELECT 
    IF(num % 6 = 0, PC.code, ''), AVG(PC.price)
FROM
    PC
        JOIN
    (SELECT 
        @i:=@i + 1 AS num,
            d.code AS code,
            IF(@i % 6 = 0, @g:=@g + 1, @g) AS 'group'
    FROM
        PC AS d, (SELECT @i:=- 1, @g:=0) AS t
    ORDER BY d.code) AS sub ON sub.code = PC.code
GROUP BY sub.group;

