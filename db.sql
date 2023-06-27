create database caixa;

use caixa;

create table Cliente (
	id int not null auto_increment, 
    nome varchar(100),
    conta long,
    senha varchar(16),
    saldo double,
    primary key(id)
);

create table Transacao(
	id int not null auto_increment,
    cliente_id int not null,
    tipo int not null,
    valor double,
    dt_transacao datetime default current_timestamp,
    primary key(id),
    foreign key(cliente_id) references Cliente(id),
    foreign key(tipo) references TipoTransacao(id)
);

create table TipoTransacao (
	id int not null auto_increment, 
    nome varchar(20),
    primary key(id)
);

insert into TipoTransacao (nome) values ('saque'),('deposito'),('transferencia');

create table Transferencias (
	id int not null auto_increment,
    cliente_env int,
    cliente_rec int,
    transacao_id int,
    foreign key(cliente_env) references Cliente(id),
    foreign key(cliente_rec) references Cliente(id),
    foreign key(transacao_id) references Transacao(id),
    primary key(id)
);


DELIMITER //
create procedure SP_TRANSACAO_COMUM (in
	cliente_id int,
	valor double,
    tipo_transacao int
) 
begin
	declare saldo_cliente double;
    
    select saldo into saldo_cliente from Cliente where id = cliente_id;
    
    if tipo_transacao = 1 then
		update Cliente set saldo = (saldo_cliente - valor) where id = cliente_id;
	else
		update Cliente set saldo = (saldo_cliente + valor) where id = cliente_id;
    end if;
    
    insert into Transacao (cliente_id, tipo, valor) values (cliente_id, tipo_transacao, valor);
    
    select * from Transacao where cliente_id = cliente_id order by dt_transacao desc limit 1;
end//
DELIMITER ;

DELIMITER //
create procedure SP_TRANSFERENCIA (in
	cliente_id int,
    cliente_transf int,
	valor double
) 
begin
	declare saldo_cliente double;
    declare saldo_transf double;
    
    select saldo into saldo_cliente from Cliente where id = cliente_id;
    select saldo into saldo_transf from Cliente where id = cliente_transf;
    
	update Cliente set saldo = (saldo_cliente - valor) where id = cliente_id;
    update Cliente set saldo = (saldo_transf + valor) where id = cliente_transf;
    
    insert into Transacao (cliente_id, tipo, valor) values (cliente_id, 3, valor);
    
    insert into Transferencias (cliente_env, cliente_rec, transacao_id) value (cliente_id, cliente_transf, last_insert_id());
    
    select * from Transacao where cliente_id = cliente_id order by dt_transacao desc limit 1;
end//
DELIMITER ;


DELIMITER //
create procedure SP_BUSCAR_TRANSFERENCIAS (in
	cliente_id int
) 
begin
	select
	ts.id as id, 
	t.cliente_env as cliente_id, 
	ts.tipo, 
	ts.valor, 
	ts.dt_transacao 
	from Transferencias t 
	inner join Transacao ts on ts.id = t.transacao_id 
	where cliente_env= cliente_id or cliente_rec = cliente_id;
end//
DELIMITER ;










