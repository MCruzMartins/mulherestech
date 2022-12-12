drop database if exists oficina;

create database oficina character set utf8 collate utf8_general_ci;

use oficina;

create table endereco(
	cep char(9) primary key,
	rua varchar(60)not null,
	bairro varchar(40)not null,
	cidade varchar(40)not null,
	uf char(2)not null);
	
create table cliente(
	cpf char(12) primary key,
	nome varchar(60)not null,
	telefone varchar(15)not null,
	cep char(9) not null,
	numerocasa integer not null,
	complemento varchar(30),
	foreign key(cep)references endereco(cep));
	
create table funcionario(
	matricula integer primary key auto_increment,
	nome varchar(60)not null,
	telefone varchar(15)not null,
	cpf char(12)not null,
	qualificacao varchar(30)not null,
	experiencia varchar(20)not null,
	cep char(9) not null,
	numerocasa integer not null,
	complemento varchar(30),
	foreign key(cep)references endereco(cep));
	
	
	create table veiculo(
		placa char(7)primary key,
		marca varchar(20)not null,
		modelo varchar(20)not null,
		cor varchar(20)not null,
		ano char(4)not null,
		cpf char(12)not null,
		foreign key(cpf)references cliente(cpf));
		
	create table servico(
		ordemservico integer primary key auto_increment,
		defeito varchar(100)not null,
		dataentrada date not null,
		datasaida date not null,
		preco double not null,
		garantia varchar(50)not null,
		formapagamento varchar(20)not null,
		placa char(7)not null,
		foreign key(placa)references veiculo(placa));
		
	create table peca(
		codigopeca integer primary key auto_increment,
		nome varchar(60)not null,
		marca varchar(40) not null,
		modeloano varchar(250)not null,
		quantidade integer not null,
		preco double not null);
		
	create table servicopeca(
		idservicopeca integer primary key auto_increment,
		quantidade integer not null,
		codigopeca integer not null,
		ordemservico integer not null,
		foreign key(codigopeca)references peca(codigopeca),
		foreign key(ordemservico)references servico(ordemservico));
		
	create table servicofunc(
		idservicofunc integer primary key auto_increment,
		descricao varchar(100)not null,
		ordemservico integer not null,
		matricula integer not null,
		foreign key(ordemservico)references servico(ordemservico),
		foreign key(matricula)references funcionario(matricula));
		
	
	insert into endereco(cep,rua,bairro,cidade,uf)VALUES
	('23085-610','Rua Padre Pauwels','Campo Grande','Rio de Janeiro','RJ'),
	('26551-090','Travessa Elpidio','Cruzeiro do Sul','Mesquita','RJ');

	insert into cliente(cpf,nome,telefone,cep,numerocasa,complemento)VALUES
	('123456789-10','Jariele','(21)99886-4587','23085-610',100,'apartamento 10'),
	('05841983709','Marina','(21)972122211','26551-090','3','rua' 'lajinha');
	
	insert into funcionario(nome,telefone,cpf,qualificacao,experiencia,cep,numerocasa,complemento)VALUES
	('João da Silva','(21)99869-4581','123456789-10','lanterneiro',
	'3 anos', '26551-090',100,'casa');
	
	insert into veiculo(placa,marca,modelo,cor,ano,cpf)VALUES
	('OPD8551','UNO','VIVACE','PRATA','2013','123456789-10'),
	('KPY6545','SAVEIRO','WOLKS','BRANCA','2014','05841983709');

	insert into servico(defeito,dataentrada,datasaida,preco,garantia,formapagamento,placa)VALUES
	('MOTOR','2022-05-01','2022-05-10','6000','2ANOS','DINHEIRO','OPD8551'),
	('EMBREAGEM','2022-05-01','2022-05-10','5000','1MES','CARTAO','KPY6545');

	insert into peca(nome,marca,modeloano,quantidade,preco) VALUES
	('cantoneira','boir','saveiro2013','1000','800'),
	('buchadabalanca','boir','unovivace2014','400','500');

	insert into servicopeca(quantidade,codigopeca,ordemservico)VALUES
	(2,1,1),
	(1,2,2);

	insert into servicofunc(descricao,ordemservico,matricula)VALUES
	('realizado o servico','2','1'),
	('realizado','1','1');