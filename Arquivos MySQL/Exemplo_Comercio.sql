/* BANCO DE DADOS COMERCIO */
CREATE DATABASE comercio;
DROP DATABASE comercio;
USE comercio;
SHOW TABLES;

CREATE TABLE vender(
	idvender int auto_increment,
    nome varchar(35) not null,
    sexo char (1) not null,
    janeiro float(10,2),
    fevereiro float(10,2),
    marco float(10,2),
    
    PRIMARY KEY(idvender)
);

INSERT INTO vender VALUES
(NULL,'Marcos','M',15562,45631,98756),
(NULL,'Maria','F',48970,13088,96471),
(NULL,'Thiago','M',14876,30214,36785);

/* BUSCAS FUNÇÕES */
SELECT MAX(janeiro) AS Maximo_Janeiro FROM vender;
SELECT MIN(marco) AS Minimo_Marco FROM vender;
SELECT AVG(janeiro) AS Media FROM vender;
SELECT AVG(fevereiro) AS Media_Fevereiro FROM vender;
SELECT COUNT(marco) AS Contagem_Marco FROM vender;
SELECT SUM(janeiro) AS Soma_Janeiro FROM vender;
SELECT sexo, SUM(janeiro)AS Total_Janeiro FROM vender GROUP BY sexo;

/* SUB QUERY */
SELECT nome, sexo, janeiro FROM vender WHERE janeiro = (SELECT MIN(janeiro) AS Menor_Valor_Janeiro FROM vender);
SELECT nome, sexo, janeiro FROM vender WHERE janeiro = (SELECT MAX(janeiro) AS MAX_Valor_Janeiro FROM vender);
SELECT nome, janeiro FROM vender WHERE janeiro = (SELECT AVG(janeiro) FROM vender);
SELECT nome, sexo, janeiro FROM vender WHERE janeiro > (SELECT AVG(janeiro) FROM vender);
SELECT nome, sexo, janeiro FROM vender WHERE janeiro < (SELECT AVG(janeiro) FROM vender);

ALTER TABLE vender ADD ender VARCHAR(35);
ALTER TABLE vender MODIFY janeiro varchar(10);
ALTER TABLE vender RENAME teste;