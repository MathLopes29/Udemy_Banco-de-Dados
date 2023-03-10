CREATE SCHEMA Livraria;
DROP SCHEMA Livraria;
USE LIVRARIA;

SHOW TABLES;
SHOW DATABASES;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE VENDEDORES;
DROP TABLE VENDAS;
DROP TABLE LIVROS;
DROP TABLE ESTOQUE;

CREATE TABLE VENDEDORES(
Id_Vendedor int auto_increment,
Nome_Vendedores varchar (50) not null,

PRIMARY KEY (Id_Vendedor)
);

CREATE TABLE LIVROS(
Id_Livro int auto_increment,
Nome_Livro varchar (50) not null,
Autora varchar (50) not null,
Editora varchar (50) not null,
Categoria varchar (50) not null,
Preco numeric (10,2) not null,

PRIMARY KEY (Id_Livro)
);

CREATE TABLE ESTOQUE(
Id_Livro int,
Qtd_Estoque int not null,

FOREIGN KEY (Id_Livro)
REFERENCES LIVROS (Id_Livro)
); 


CREATE TABLE VENDAS (
 Id_Pedido int auto_increment,
 Id_Vendedor int,
 Id_Livro int,
 Qtd_vendida int not null,
 Data_vendida date not null,
 
 PRIMARY KEY (Id_Pedido),
 
 FOREIGN KEY (Id_Vendedor)
 REFERENCES VENDEDORES (Id_Vendedor),
 
 FOREIGN KEY (Id_Livro)
 REFERENCES LIVROS (Id_Livro)
);

/*************************************************************/
INSERT INTO VENDEDORES VALUES 
(NULL,'Matheus'),
(NULL,'Lucas'),
(NULL,'Thiago');

SELECT * FROM VENDEDORES;

INSERT INTO LIVROS VALUES 
(NULL, 'Mr.Zion','Matrix','MRR','Acao',125.99),
(NULL, 'Laura B','West LTT','LPA','Drama',52.65),
(NULL, 'GI','PAC','LXX','Ficcao',15.25);

SELECT * FROM LIVROS;

INSERT INTO ESTOQUE VALUES
(1,9),
(3,10),
(2,25);

SELECT * FROM ESTOQUE;

INSERT INTO VENDAS VALUES 
(NULL, 1,1,2, '2019-05-15'),
(NULL, 3,2,1, '2022-12-05'),
(NULL, 2,3,3, '2021-10-06');

SELECT * FROM VENDAS;