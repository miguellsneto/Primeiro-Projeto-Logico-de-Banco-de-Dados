-- Consultas SQL
USE ecommerce;

show tables;
select * from clients;
select * from product;
select * from orders;
select * from supplier;
select * from seller;
select * from productSeller;
select count(*) from clients;
select * from clients c, orders o
	where c.idClient = idOrderClient;
select Fname,Lname, idOrder, orderStatus
	from clients c, orders o
    where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status
	from clients c, orders o
    where c.idClient = idOrderClient;
select count(*)
	from clients c, orders o 
	where c.idClient = idOrderClient;
select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
	inner join orders o ON c.idClient = o.idOrderClient
    inner join productOrder p on p.idPOorder = o.idOrder;
    -- group by idClient;
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
	inner join orders o ON c.idClient = o.idOrderClient
	group by idClient;