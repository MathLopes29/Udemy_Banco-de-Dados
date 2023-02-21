/* DATABASE TITULAR */
CREATE DATABASE LOJA;
USE LOJA;

CREATE TABLE PRODUTOS(
idProd int auto_increment,
nome varchar(35) not null,
valor_original varchar(10.2) not null,
primary key(idProd)
);
SHOW TABLES;
DROP TABLE PRODUTOS;

DROP DATABASE LOJA;

/* INSERT DE DADOS */
INSERT INTO LOJA.PRODUTOS VALUES 
(NULL,'LIVRO JAVA','85.00'),
(NULL,'LIVRO C++','56.00'),
(NULL,'LIVRO C#','120.00');

INSERT INTO BKP_LOJA.BKP_PRODUTOS VALUES
(NULL,'1','LIVRO TESTE','3.50');

/* DATATIME E QUEM ALTEROU */
SELECT NOW();
SELECT CURRENT_USER();

/* DATABASE DE BACKUP */
CREATE DATABASE BKP_LOJA;
USE BKP_LOJA;

CREATE TABLE BKP_PRODUTOS(
idBkp int primary key auto_increment,
idProd int,
nome varchar(35) not null,
valor_original varchar(10.2) not null,
valor_alterado varchar(10.2),
date datetime,
usuario varchar(30),
evento char(1)
);
SHOW TABLES;

DROP DATABASE BKP_LOJA;

/* DML */
SELECT * FROM BKP_LOJA.BKP_PRODUTOS;
SELECT * FROM LOJA.PRODUTOS;
DELETE FROM PRODUTOS WHERE idProd = 2;

/* ALTER TABLE */
ALTER TABLE BKP_LOJA.BKP_PRODUTOS ADD EVENTO CHAR(1);

/* TRIGGER DADOS ANTES DE SEREM DELETADOS */
DROP TRIGGER Backup_Loja_Del;

DELIMITER $
CREATE TRIGGER Backup_Loja_Del
BEFORE DELETE ON PRODUTOS
FOR EACH ROW
BEGIN 
INSERT INTO BKP_LOJA.BKP_PRODUTOS VALUES 
(NULL, OLD.idProd, OLD.nome, OLD.valor_original);
END 
$
DELIMITER ;

/* TRIGGER DADOS APÓS INSERIDO NAS TABELAS */
DROP TRIGGER Backup_Loja_Ins;

DELIMITER $
CREATE TRIGGER Backup_Loja_Ins
AFTER INSERT ON PRODUTOS
FOR EACH ROW
BEGIN 
 INSERT INTO BKP_LOJA.BKP_PRODUTOS 
 VALUES (NULL, NEW.idProd, NEW.nome, NEW.valor_original);
END $
DELIMITER ;

/* TRIGGER DADOS APÓS SER ATUALIZADO NAS TABELAS */
DROP TRIGGER Backup_Loja_Upd;

DELIMITER $
CREATE TRIGGER Backup_Loja_Upd
AFTER UPDATE ON PRODUTOS
FOR EACH ROW
BEGIN 
 INSERT INTO BKP_LOJA.BKP_PRODUTOS VALUES (NULL, OLD.idProd, OLD.nome, OLD.valor_original, NOW(), CURRENT_USER(),'U');
END $
DELIMITER ;
