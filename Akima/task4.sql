SELECT if(num % 6 = 0, PC.code, ''), AVG(PC.price) FROM bd.pc as PC join (select @i:=@i + 1 as num, d.code as code, if(@i % 6 = 0, @g:=@g+1, @g) as 'group' from pc as d, (select @i:=-1, @g:=0) as t order by d.code) as sub on sub.code = PC.code group by sub.group;

