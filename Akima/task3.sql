select P.maker, P.type,  round(count(P.model) / subQ.total, 4) * 100 as procent from product as P left join (select count(model) as total, maker from product group by maker) as subQ on subQ.maker = P.maker group by P.type, P.maker 