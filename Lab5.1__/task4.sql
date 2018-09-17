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

 SELECT 
    IF(B.num % 6 = 0, PC.code, '') AS groupCode, AVG(PC.price)
FROM
    pc AS PC
        JOIN
    (SELECT 
        (SELECT 
                    COUNT(*)
                FROM
                    PC
                WHERE
                    code < A.code) AS num,
            (SELECT 
                    COUNT(*)
                FROM
                    PC
                WHERE
                    code < A.code) DIV 6 AS 'group',
            code
    FROM
        PC AS A
    ORDER BY code) AS B ON PC.code = B.code
GROUP BY B.group
