SELECT if(model regexp '^([A-z]*|[0-9]*)$', model, null) FROM product;
