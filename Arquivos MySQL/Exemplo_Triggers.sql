/* Banco de Dados - TRIGGERS */
/* Declaração de TRIGGERS */
DELIMITER $
CREATE TRIGGER Busca
BEFORE/AFTER INSERT/DELETE/UPDATE ON cliente
FOR EACH ROW()
BEGIN 

END$

DELIMITER ;
/************************************************/
/* EXEMPLO PRÁTICO 1  - VALORES DELETADOS BACKUP*/

DROP DATABASE exemplo;
CREATE DATABASE exemplo;
USE exemplo;
SHOW DATABASES;

CREATE TABLE cliente (
	idcliente int primary key auto_increment,
	nome varchar(30) not null,
	login varchar(5) not null
);

CREATE TABLE BKP_cliente (
	idbackup int primary key auto_increment,
	idcliente int, 
	nome varchar(30) not null,
	login varchar(5) not null
);

DELIMITER $

CREATE TRIGGER Backup_User
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN 

	INSERT INTO BKP_cliente VALUES 
	(NULL, old.idcliente, old.nome, old.login);
END 
$

DELIMITER ;

INSERT INTO cliente VALUES(NULL, 'Thiago', 'AB963');
SELECT * FROM cliente;

DELETE FROM cliente WHERE idcliente = 1;
SELECT * FROM BKP_cliente;

/**************************************************/
/* EXEMPLO PRÁTICO 2 - COMUNICAÇÃO ENTRE BANCOS */
CREATE DATABASE LOJA;
USE LOJA;
SHOW TABLES;

CREATE TABLE PRODUTOS(
	idProd INT AUTO_INCREMENT,
	nome VARCHAR(35) NOT NULL,
	valor INTEGER(10) NOT NULL,
	
	PRIMARY KEY(idProd)
);


 /* INSERT DE DADOS */
INSERT INTO PRODUTOS VALUES
(NULL,'Kit Kat','5.35'),
(NULL,'Agua Mineral','2.35'),
(NULL,'Coxinha','4.00'),
(NULL,'Caneta BIS','5.35'),
(NULL,'Bandeira BRA','10.35'),
(NULL,'Luva','8.00');
SELECT * FROM PRODUTOS;
 
 /* DELETE DE DADOS */
 DELETE FROM PRODUTOS WHERE idProd = 3;
 SELECT * FROM backup_loja.bkp_PRODUTOS;
 SELECT * FROM loja.produtos;

/* BACKUP DE DADOS ANTES DE SEREM INSERIDOS */
 DROP TRIGGER Backup_Produtos;

 DELIMITER $
 CREATE TRIGGER Backup_Produtos
 AFTER /* before funciona melhor */ INSERT ON PRODUTOS
 FOR EACH ROW
 BEGIN
 INSERT INTO BACKUP_LOJA.BKP_PRODUTOS VALUES 
 (NULL, NEW.idProd, NEW.nome, NEW.valor);
 END 
 $
 DELIMITER ;
 
 /* BACKUP DE DADOS ANTES DE SEREM EXCLUIDOS */
 DROP TRIGGER Backup_Produtos_Del;
  
 DELIMITER $
 CREATE TRIGGER Backup_Produtos_Del
 BEFORE DELETE ON PRODUTOS
 FOR EACH ROW
 BEGIN
 INSERT INTO BACKUP_LOJA.BKP_PRODUTOS VALUES 
 (NULL, OLD.idProd, OLD.nome, OLD.valor);
 END 
 $
 DELIMITER ;
 
/* DATABASE RESERVA */
CREATE DATABASE BACKUP_LOJA;
USE BACKUP_LOJA;

CREATE TABLE BKP_PRODUTOS(
	idBKP INT PRIMARY KEY AUTO_INCREMENT,
	idProd INT,
	nome VARCHAR(35) NOT NULL,
	valor INTEGER(10) NOT NULL
);

/* TESTE DE CONEXÃO */
 INSERT INTO BACKUP_LOJA.BKP_PRODUTOS VALUES 
 (NULL, 10,'TESTE','3.56');
 
