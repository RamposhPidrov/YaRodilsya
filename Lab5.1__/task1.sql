SELECT if(model regexp '^([A-z]*|[0-9]*)$', model, null) FROM product;


SELECT 
    ko.still
FROM
    (SELECT 
        IF(model REGEXP '^([A-z]*|[0-9]*)$', model, NULL) AS still
    FROM
        product) AS ko
WHERE
    ko.still IS NOT NULL;
