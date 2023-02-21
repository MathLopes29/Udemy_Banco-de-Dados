/* Modelagem Banco de Dados x Data Science */

/* Banco de Dados -> 1,2 e 3 Formas normais
Evitam reduncancia, consequentemente poupam espaço em disco.
Consomem muito processamento em função de Joins. Queries lentas

Data Science e B.I -> Focam em agregaçoes e performance. Não se 
preocupam com espaço em disco. Em B.I, modelagem mínima (DW)
em Data Science, preferencialmente modelagem Colunar */

/* O servidor de maquinas gerou um arquivo de log CSV.
Vamos importá-lo e analisa-lo dentro do nosso banco */

/*Importando CSV*/
CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
	DIA INT,
	QTD NUMERIC(10,2)
);

D:\Matheus\Cursos\[BACKUP] Domine as Linguagens SQL e T-SQL\Arquivo PostgreSQL

COPY MAQUINAS
FROM 'D:\Matheus\Cursos\[BACKUP] Domine as Linguagens SQL e T-SQL\Arquivo PostgreSQL\LogMaquinas.csv' 
DELIMITER ','
CSV HEADER;

SELECT * FROM MAQUINAS;

/*QUAL A MEDIA DE CADA MAQUINA */
SELECT MAQUINA, AVG(QTD) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

/*ARREDONDANDO */
ROUND(COLUNA,2)

SELECT MAQUINA, ROUND(AVG(QTD),2) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

/* QUAL A MODA DAS QUANTIDADES */
select maquina, qtd, count(*) as moda
from maquinas
group by maquina, qtd
order by 3 desc


/* QUAL A MODA DAS QUANTIDADES DE CADA MAQUINA */
SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;


SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

/* moda do dataset inteiro */
SELECT  QTD, COUNT(*) AS MODA
FROM MAQUINAS
GROUP BY QTD
ORDER BY 2 DESC;


/* QUAL O MAXIMO E MINIMO E AMPLITUDE DE CADA MAQUINA  */
SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;
		

/* ACRESCENTE A MEDIA AO RELATORIO */
SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;


/* DESVIO PADRAO E VARIANCIA */
STDDEV_POP(coluna)
VAR_POP(coluna)

SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE,
	   ROUND(STDDEV_POP(QTD),2) AS DESV_PAD,
	   ROUND(VAR_POP(QTD),2) AS VARIANCIA
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;   


/* FUNCAO E ANALISE DA MEDIANA NO ARQUIVO 02 - Funcao de Mediana.sql 

	QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE
	VARIANCIA
	DESVIO PADRAO
	MEDIANA
	COEF VAR.
*/

SELECT MAQUINA,
	   COUNT(QTD) AS "QUANTIDADE",
	   SUM(QTD) AS "TOTAL",
	   ROUND(AVG(QTD),2) AS "MEDIA",
	   MAX(QTD) AS "MAXIMO",
	   MIN(QTD) AS "MINIMO",
	   MAX(QTD) - MIN(QTD) AS "AMPLIT. TOTAL",
	   ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	   ROUND(STDDEV_POP(QTD),2) AS "DESV. PADRAO",
	   ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	   ROUND((STDDEV_POP(QTD) / AVG(QTD)) * 100,2) AS "COEF. VARIACAO"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;

SELECT MEDIAN(QTD) AS MEDIANA
FROM MAQUINAS;

SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01';
								
SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02';
										 
SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03';

INSERT INTO MAQUINAS VALUES('Maquina 01',11,15.9);
INSERT INTO MAQUINAS VALUES('Maquina 02',11,15.4);
INSERT INTO MAQUINAS VALUES('Maquina 03',11,15.7);
INSERT INTO MAQUINAS VALUES('Maquina 01',12,30);
INSERT INTO MAQUINAS VALUES('Maquina 02',12,24);
INSERT INTO MAQUINAS VALUES('Maquina 03',12,45);

SELECT * FROM MAQUINAS;
										 
delete from maquinas where dia = 11 or dia = 12;


/* MODA - MODE() WITHIN GROUP(ORDER BY COLUNA)  */
SELECT * FROM MAQUINAS;

SELECT MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" FROM MAQUINAS;

SELECT MAQUINA, MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" 
FROM MAQUINAS
GROUP BY MAQUINA;

SELECT MAQUINA,
	   COUNT(QTD) AS "QUANTIDADE",
	   SUM(QTD) AS "TOTAL",
	   ROUND(AVG(QTD),2) AS "MEDIA",
	   MAX(QTD) AS "MAXIMO",
	   MIN(QTD) AS "MINIMO",
	   MAX(QTD) - MIN(QTD) AS "AMPLIT. TOTAL",
	   ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	   ROUND(STDDEV_POP(QTD),2) AS "DESV. PADRAO",
	   ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	   ROUND((STDDEV_POP(QTD) / AVG(QTD)) * 100,2) AS "COEF. VARIACAO",
	   MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;
	   
/* TABELA DE EXPORT COLUNAR 
create table as select - Podemos criar uma tabela com o resultado de uma query 
e essa é a forma de realizar uma modelagem colunar - CREATE TABLE AS SELECT */
CREATE TABLE GENERO(
	IDGENERO INT PRIMARY KEY,
	NOME VARCHAR(30)
);

INSERT INTO GENERO VALUES(1,'FANTASIA');
INSERT INTO GENERO VALUES(2,'AVENTURA');
INSERT INTO GENERO VALUES(3,'SUSPENSE');
INSERT INTO GENERO VALUES(4,'AÇÃO');
INSERT INTO GENERO VALUES(5,'DRAMA');

SELECT * FROM GENERO;

CREATE TABLE FILME(
	IDFILME INT PRIMARY KEY,
	NOME VARCHAR(50),
	ANO INT,
    ID_GENERO INT,
	FOREIGN KEY(ID_GENERO)
	REFERENCES GENERO(IDGENERO)
);

INSERT INTO FILME VALUES(100,'KILL BILL I',2007,2);
INSERT INTO FILME VALUES(200,'DRACULA',1998,3);
INSERT INTO FILME VALUES(300,'SENHOR DOS ANEIS',2008,1);
INSERT INTO FILME VALUES(400,'UM SONHO DE LIBERDADE',2008,5);
INSERT INTO FILME VALUES(500,'OS BAD BOYS',2008,4);
INSERT INTO FILME VALUES(600,'GUERRA CIVIL',2016,2);
INSERT INTO FILME VALUES(700,'CADILLAC RECORDS',2009,5);
INSERT INTO FILME VALUES(800,'O HOBBIT',2008,1);
INSERT INTO FILME VALUES(900,'TOMATES VERDES FRITOS',2008,5);
INSERT INTO FILME VALUES(1000,'CORRIDA MORTAL',2008,4);

SELECT * FROM FILME;

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA DATE,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

INSERT INTO LOCACAO VALUES(1,'01/08/2019',23,3,100);
INSERT INTO LOCACAO VALUES(2,'01/02/2019',56,1,400);
INSERT INTO LOCACAO VALUES(3,'02/07/2019',23,3,400);
INSERT INTO LOCACAO VALUES(4,'02/02/2019',43,1,500);
INSERT INTO LOCACAO VALUES(5,'02/02/2019',23,2,100);
INSERT INTO LOCACAO VALUES(6,'03/07/2019',76,3,700);
INSERT INTO LOCACAO VALUES(7,'03/02/2019',45,1,700);
INSERT INTO LOCACAO VALUES(8,'04/08/2019',89,3,100);
INSERT INTO LOCACAO VALUES(9,'04/02/2019',23,3,800);
INSERT INTO LOCACAO VALUES(10,'05/07/2019',23,3,500);
INSERT INTO LOCACAO VALUES(11,'05/02/2019',38,3,800);
INSERT INTO LOCACAO VALUES(12,'01/10/2019',56,1,100);
INSERT INTO LOCACAO VALUES(13,'06/12/2019',23,3,400);
INSERT INTO LOCACAO VALUES(14,'01/02/2019',56,2,300);
INSERT INTO LOCACAO VALUES(15,'04/10/2019',76,3,300);
INSERT INTO LOCACAO VALUES(16,'01/09/2019',32,2,400);
INSERT INTO LOCACAO VALUES(17,'08/02/2019',89,3,100);
INSERT INTO LOCACAO VALUES(18,'01/02/2019',23,1,200);
INSERT INTO LOCACAO VALUES(19,'08/09/2019',45,3,300);
INSERT INTO LOCACAO VALUES(20,'01/12/2019',89,1,400);
INSERT INTO LOCACAO VALUES(21,'09/07/2019',23,3,1000);
INSERT INTO LOCACAO VALUES(22,'01/12/2019',21,3,1000);
INSERT INTO LOCACAO VALUES(23,'01/02/2019',34,2,100);
INSERT INTO LOCACAO VALUES(24,'09/08/2019',67,1,1000);
INSERT INTO LOCACAO VALUES(25,'01/02/2019',76,3,1000);
INSERT INTO LOCACAO VALUES(26,'01/02/2019',66,3,200);
INSERT INTO LOCACAO VALUES(27,'09/12/2019',90,1,400);
INSERT INTO LOCACAO VALUES(28,'03/02/2019',23,3,100);
INSERT INTO LOCACAO VALUES(29,'01/12/2019',65,5,1000);
INSERT INTO LOCACAO VALUES(30,'03/08/2019',43,1,1000);
INSERT INTO LOCACAO VALUES(31,'01/02/2019',27,31,200);

SELECT * FROM LOCACAO;

/* SELECT COLUNAR */
SELECT F.NOME, G.NOME, L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

/* CREATE TABLE COLUNAR */
DROP TABLE REL_LOCADORA;

CREATE TABLE REL_LOCADORA AS
SELECT F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM REL_LOCADORA;

COPY REL_LOCADORA TO /* EXPORT */ /* FROM - IMPORT */
'D:\Matheus\Cursos\[BACKUP] Domine as Linguagens SQL e T-SQL\Arquivo PostgreSQL\REL_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

/* SINCRONIZANDO TABELAS E RELATORIOS */
DROP TABLE LOCACAO;

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA TIMESTAMP,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)
);

SELECT * FROM LOCACAO;

/* AUTO_INCREMENT NO POSTGRE - NEXTVAL('SEQ_LOCACAO'); */
CREATE SEQUENCE SEQ_LOCACAO;
DROP SEQUENCE SEQ_LOCACAO;

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/08/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/07/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',43,1,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',23,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/07/2018',76,3,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',45,1,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/08/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/02/2018',23,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/07/2018',23,3,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/02/2018',38,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/10/2018',56,1,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'06/12/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,2,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/10/2018',76,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/09/2018',32,2,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/02/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',23,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/09/2018',45,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',89,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/07/2018',23,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',21,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',34,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/08/2018',67,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',76,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',66,3,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/12/2018',90,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',65,5,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/08/2018',43,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',27,31,200);

SELECT * FROM LOCACAO;	
SELECT * FROM GENERO;
SELECT * FROM FILME;
SELECT * FROM REL_LOCADORA;

/* NOVA TABELA REL LOCADORA COM ID */
CREATE TABLE RELATORIO_LOCADORA AS 
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM RELATORIO_LOCADORA;
SELECT * FROM LOCACAO;

/* SELECT PARA TRAZER OS REGISTROS NOVOS */
SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;
					
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* INSERINDO OS REGISTROS NOVOS */
INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;					
					
/* VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMATICO POR MEIO DE UMA TRIGGER */
CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

COPY RELATORIO_LOCADORA TO
'D:\Matheus\Cursos\[BACKUP] Domine as Linguagens SQL e T-SQL\Arquivo PostgreSQL\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;					

/* COMANDO PARA APAGAR UMA TRIGGER */
DROP TRIGGER TG_RELATORIO ON LOCACAO;

CREATE TRIGGER TG_RELATORIO
AFTER INSERT ON LOCACAO
FOR EACH ROW
	EXECUTE PROCEDURE ATUALIZA_REL();

				
/* INSERINDO NOVOS REGISTROS */
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),100,7,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),500,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),800,6,500);

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

/* SINCRONIZANDO COM REGISTROS DELETADOS */
CREATE OR REPLACE FUNCTION DELETE_LOCACAO()
RETURNS TRIGGER AS
$$
BEGIN

DELETE FROM RELATORIO_LOCADORA
WHERE IDLOCACAO = OLD.IDLOCACAO;

COPY RELATORIO_LOCADORA TO
'C:\Scripts SQL DataScience\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN OLD;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER DELETE_REG
	BEFORE DELETE ON LOCACAO 
	FOR EACH ROW
	EXECUTE PROCEDURE DELETE_LOCACAO();

/* TESTE */
SELECT * FROM LOCACAO;	
SELECT * FROM RELATORIO_LOCADORA;	

DELETE FROM LOCACAO 
WHERE IDLOCACAO = 1;