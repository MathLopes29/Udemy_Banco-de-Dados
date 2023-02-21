
/*

RESUMO ENTRE OS COMPONENTES DO SQL!

(DDL) permite aos usuários especificar um esquema de banco de dados através de um conjunto de definições. Portanto, um esquema é o projeto geral de um banco de dados e raramente é modificado
(DML) é uma família de linguagens de computador, incluindo comandos que permitem aos usuários manipular dados em um banco de dados. Portanto, essa manipulação envolve inserir dados em tabelas de banco de dados, recuperar dados existentes, excluir dados de tabelas existentes e modificar dados existentes. 
(DCL) inclui comandos como GRANT e REVOKE que lidam principalmente com os direitos, permissões e outros controles do sistema de banco de dados.
(TCL) são usados para gerenciar transações no banco de dados. Dessa forma, um conjunto de instruções SQL correlacionadas logicamente e executadas nos dados armazenados na tabela é conhecido como transação. 

 * DML - SELECT *(DQL), DELETE, INSERT, UPDATE - "INCLUDE" (MANIPULAÇÃO DOS DADOS)
  
 * DDL - ALTER, CREATE, RENAME, DROP, TRUNCATE, COMMENT (DEFINIÇÃO / ALTERAÇÃO DOS DADOS)
 
 * DCL - REVOKE & GRANT (DATA CONTROL - ACESSO!)
 
 * TCL - COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION (CONTROLE DE TRANSAÇÃO) 
 
 */
SHOW TABLES;
SHOW DATABASES;
DESC Cliente;

ALTER TABLE Cliente
DROP COLLUM Telefone;

ALTER TABLE Cliente
CHANGE Nome VARCHAR (25);

ALTER TABLE Cliente
ADD COLLUM Informações varchar (50) NULL
AFTER Telefone;

ALTER TABLE Cliente
MODIFY Nome varchar (100) NOT NULL;

UPDATE Cliente
SET Nome = 'Carlos'
WHERE idCliente = 4;

DELETE FROM Cliente WHERE idCliente = 3

SELECT COUNT(*) AS'QTDE' 
FROM Cliente;

INSERT INTO Cliente (Nome, Email, Ender, Telefone) VALUES
('Matheus', 'mat.lopes2907@gmail.com','São Paulo', '(11)97863-0125')
('Lucas', 'luck1890@gmail.com','Rio de Janeiro', '(11)23089-7041'),
('Thiago', 'thi.lopez5097@gmail.com','Minas Gerais', '(21)16093-0149'),
('Ana','car1985@outlook.com','Bahia','(30)2630-9874')
;

SELECT Nome, Ender, Telefone FROM Cliente A WHERE A.idCliente = 1 AND A.idCliente =3;

SELECT C.NOME, C.EMAIL, E.ESTADO, T.CONTATO FROM CLIENTE C 
INNER JOIN ENDERECO E ON  IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE T ON IDCLIENTE = ID_CLIENTE;

SELECT C.NOME, IFNULL (C.EMAIL, '*********') AS "EMAIL", E.ESTADO, T.CONTATO FROM CLIENTE C 
INNER JOIN ENDERECO E ON  IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE T ON IDCLIENTE = ID_CLIENTE;

/**  VIEW

CREATE VIEW V_RELATORIO AS
	SELECT C.NOME, 
		C.SEXO, 
		IFNULL(T.EMAIL,'***********') AS "EMAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRO, 
		E.CIDADE,
		E.ESTADO
	FROM CLIENTE C
	INNER JOIN TELEFONE T ON IDCLIENTE = ID_CLIENTE
	INNER JOIN ENDERECO E ON IDCLIENTE = ID_CLIENTE;

SHOW TABLES;
SELECT * FROM V_RELATORIO;
DROP VIEW V_RELATORIO;


SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;

*/

/* DML em VIEW.
	INSERT - FUNCIONA PORÉM APENAS ANTES DE CRIAR A VIEW 
	DELETE - APENAS ANTES DE CRIAR A VIEW
	UPDATE - FUNCIONA MAS SEM TABELAS VIEW COM INNER JOIN 
*/

CREATE TABLE ALUNOS (
	IDALUNO INT AUTO_INCREMENT,
	NOME VARCHAR(35) NOT NULL,
);

INSERT INTO ALUNOS (IDALUNO, NOME) VALUES
	('Matheus'),
	('Lucas'),
	('Carlos'),
	('Thiago'),
	('Ana')
;

SELECT * FROM ALUNOS ORDER BY IDALUNO;
SELECT NOME FROM ALUNOS ORDER BY IDALUNO, ALUNO DESC /*ASC*/;