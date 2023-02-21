/**
* @author Matheus Lopes Lourenço
* Banco de Dados - Exercício de Teste Delimiter - Empresa.
*/

CREATE DATABASE empresa;
USE empresa;

CREATE TABLE cliente (
	IDCliente int AUTO_INCREMENT,
	Nome varchar(35) NOT NULL,
    Email varchar(35) NULL,
    Telefone varchar(12) NOT NULL,
    
    PRIMARY KEY (IDCliente)
);

CREATE TABLE valores(
numero_1 integer NOT NULL,
numero_2 integer NOT NULL
);

INSERT INTO cliente VALUES
(null,'Thiago Andrade','thiago1635@gmail.com','112365-4987'),
(null,'Lucas Macedo','luck9875@outlook.com','152068-7891'),
(null,'Maria de Marquez','marck1598@outlook.com','1178456-0321');

/* DECLARAÇÃO DO DELIMITER */

DELIMITER $

CREATE PROCEDURE insert_dados (numero_1 integer, numero_2 integer) 
BEGIN 
	INSERT INTO valores VALUES(numero_1, numero_2); 
END

CREATE PROCEDURE resposta (numero_1 integer, numero_2 integer) 
BEGIN 
	SELECT numero_1 + numero_2 FROM valores;
END

DELIMITER ;

CALL resposta(5,6);
CALL resposta(6,9);
CALL resposta(1,7);
