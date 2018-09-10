select subQ.number, P.maker, P.model from product as P left join (select @i:=@i+1 as number, count(subP.model) as count, subP.maker from product as subP, (select @i:=0) as t group by subP.maker order by count desc, subP.maker) as subQ on P.maker = subQ.maker

