CREATE DATABASE ECURSOR;
USE ECURSOR;

CREATE TABLE TESTE(
 nome varchar(50),
 jan int,
 fev int,
 mar int
);

SHOW TABLES;

insert into teste values 
('MATHEUS', 116, 453, 871),
('LUCAS', 963, 760, 130),
('THIAGO', 230, 587, 874),
('ANA', 987, 364, 371),
('MARIA', 236, 129, 487);

/********************************/
SELECT * FROM teste;
SELECT * FROM venda_teste;

SELECT NOME, (JAN + FEV + MAR) AS TOTAL FROM TESTE;
SELECT (JAN + FEV + MAR)/3 AS MEDIA FROM TESTE;

/*********************************/
CREATE TABLE VENDA_TESTE(
 nome varchar(50),
 jan int,
 fev int,
 mar int, 
 total int,
 media int 
);

/***********************************/
DELIMITER $
CREATE PROCEDURE INSERE_TESTE ()
BEGIN

	DECLARE FIM INT DEFAULT 0;
	DECLARE VAR1, VAR2, VAR3, VTOTAL, VMEDIA INT;
	DECLARE VNOME VARCHAR(50);
	
	DECLARE REG CURSOR FOR(
		SELECT NOME, JAN, FEV, MAR FROM TESTE
	);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM = 1;
	
	OPEN REG;
		
		REPEAT
			FETCH REG INTO VNOME, VAR1, VAR2, VAR3;
			IF NOT FIM THEN
			
				SET VTOTAL = VAR1+VAR2+VAR3;
				SET VMEDIA = VTOTAL/3;
				
				INSERT INTO VENDA_TESTE VALUES (VNOME, VAR1, VAR2, VAR3, VTOTAL, VMEDIA);
			END IF;
			
		UNTIL FIM END REPEAT;
	
	CLOSE REG;

END
$

DELIMITER ;

/***************************************************/
CALL INSERE_TESTE();
