SELECT 
    subQ.number, P.maker, P.model
FROM
    Product AS P
        LEFT JOIN
    (SELECT 
        @i:=@i + 1 AS number, subP.maker
    FROM
        (SELECT 
        COUNT(subP.model) AS count, subP.maker
    FROM
        Product AS subP
    GROUP BY subP.maker
    ORDER BY count DESC , maker) AS subP, (SELECT @i:=0) AS t) AS subQ ON subQ.maker = P.maker

SELECT 
    C.num, P.maker, P.model 
FROM
    product AS P
    LEFT JOIN
        (SELECT 
            (SELECT 
                COUNT(*)
             FROM
                (SELECT 
                    COUNT(model) AS count, maker
                 FROM
                    product
                 GROUP BY maker
                 ORDER BY count DESC , maker) AS B
              WHERE
                (B.count >= A.count
                AND IF(B.count = A.count, B.maker <= A.maker, B.count))) AS num,
              A.maker
         FROM
            (SELECT 
                COUNT(model) AS count, maker  
            FROM
                product
            GROUP BY maker
            ORDER BY count DESC , maker) AS A)
        AS C ON C.maker = P.maker

#Выбирается номер из топа, имя, модель, которую производит производитель
#Из выборки топа, который формируется по количеству произведенных моделей
#Топ нумеруется подзапросом с условием в WHERE
#Основное условие - по количеству моделей
#Вторичное условие - если у производителей одинакове количество моделей, то нумеровка идет по имени, иначе так же по каунту
#Я поплавлен
