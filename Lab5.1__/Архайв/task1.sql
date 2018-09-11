#SELECT if(model regexp '^([A-z]*|[0-9]*)$', model, null) FROM product;

select model from product where model like '' 