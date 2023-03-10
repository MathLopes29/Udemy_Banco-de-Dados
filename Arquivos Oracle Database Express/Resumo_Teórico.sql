/* INTRODUÇÃO AO BD ORACLE 
----------------------------------------------------------------------------------------------
     ESTRUTURAS LÓGICAS
 
 * Tabelas, Índices, Views, Procedures = Unidades Lógicas 
  -> Ocupam -> Espaço Físico (Extenção de Arquivos)

 * SEGMENT - São objetos dos Bancos de Dados Oracle

 * DATABLOCKS - Unidade Mínima de Armazenamento (Bloco de Dados)
 
 * EXTENTS - Conjunto de Datablocks, ou seja, ocupa um tamanho. 
 Quanto ao armazenamento, os segmentos formam extensões, 
 que não são necessariamente contiguas, mas os blocos de dados
 compoõe uma extend.
 
 * TABLESPACE - Padrão System (Estrutura Lógica), sendo ligada aos arquivos de dados,
 os DBF (Files). Onde, uma tabela criada dentro dela ocupa um espaço e é distribuida 
 de maneira correspondente ao tamanho. Pode ser Permanente (MetaData) e Temporária.
 HEADER -> PONTEIRO PARA O PRÓXIMO DADO ARMAZENADO
 ESPAÇO -> ARMAZENAMENTO
 DADOS -> TAMANHO PADRÃO DE DADOS (8KB PADRÃO)
 
 OLTP -> INSERT, DELETE, UPDATE
 OLAP -> SELECT 

 * "Ao criar uma Segment (Tabela), ela ocupa uma Extend, que são
 compostas por Datablocks, ocupando espaço no disco rígido"
 
-------------------------------------------------------------------------------------------
    ESTRUTURAS FÍSICAS

 ARQUIVOS FÍSICOS:
	* DATAFILES - Estruturas Físicas de armazenamento do BD Oracle. 
	Os detalhes compõe as tablespaces e a soma dos seus tamanhos é o total
    da tablespace. (Arquivos de Usuário - Exemplo: ~~~~.DBF).
	
	* CONTROLFILES - Controle e funcionamento da BD Oracle. 
	Onde temos a cópia de arquivos DBF (Multiplexação), 
	tendo um limite de 8 arquivos. Fornecendo informações de Start Up ou 
	Shut Down, vendo se os processos foram executados e sincronizados. 
	Informa nome, timestamp, onde está localizado e o último checkpoint.
	
	* REDO LOG FILES - Armazenam as transações executadas e confirmadas com COMMIT.
	São o log de transações. O objetivo é permitir a maior recuperação de dados comitados.
	Quando executamos o COMMIT, os dados permanecem em memória, pois o acesso a ela é mais 
	rápido do que o acesso ao DISCO. Sendo assim, os dados comitados são gravados no REDO LOGS,
	afim de recuperação em caso de perda antes da sincronização com os DATAFILES. (REDO LOG BUFFER)
	
	* ARQUIVE LOG - Modo Arquive - É o backup dos dados do REDO LOG, 
	assim não será perdido os dados, sendo possível retornar suas cópias 
	anteriores dos arquivos REDO.
	
	* FILE SYSTEM - Gerenciador de Volumes
	
	* ASM - Armazenamento transparente onde o Oracle gerencia o BD 
	devido ao ganho de performace

	* ARQ PARÂMETROS - São os arquivos lidos no momento que um BD sobe, ou seja, no
	momento em que ele fica operacional. Como parâmetros, são por exemplo a quantidade
	de memória, parâmetros de sessão, etc. Sendo dois tipos de arquivos: 
	(Estáticos - Necessita Reiniciação), (Dinâmicos - Maioria dos Parâmetros).
    
	**(SPFILE) Instância do BD que lê esse arquivo no momento da inicialização. 
	É um arquivo binário e deixa os parâmetros persistentes.

	**(PFILE) É um arquivo idêntico ao SPFILE, porém é um arquivo texto e pode ser
	editado manualmente pelo usuário.

	Escopos: 
	 * 1-> Memória (SCOPE = MEMORY). 
	 * 2-> Reiniciação (SCOPE = SPFILE - Alteração válida após a reinicialização e não vai estar na memória, mesmo sendo dinâmico ). 
	 * 3-> No momento (SCOPE = BOOTH ou ÂMBOS - Deve trabalhar com parâmetro dinâmico e deixar sem escopo, pois ele tratará como padrão).

	* ALTER SESSION SET - Reconfigura um parâmetro apenas para a sessão corrente, ou seja, é ideal para 
	se testar algo como performance. Ao desligar a sessão, a alteração é desfeita e não estará 
	disponível para nenhuma outra sessão.
	
	SELEST * FROM v$parameter - Verificar Parâmetros!
	
	PASSWORDFILE - Arquivo de Senhas Criptografadas para autenticação do BD.
	ARQ. BACKUP - Geralmente são arquivos TRACE ou .TRC que servem para monitorar o BD.
	ARQ. ALERTA - Alert Log, são alertas automatizados de todas as situações que ocorreram.

	TAB.System - Armazena toda a parte do CORE do sistema do BD
	TAB.Undo - "DESFAZENDO" - Desfazer alterações com o ROOLBACK
	TAB.Temp - Auxiliar a memória do Oracle

----------------------------------------------------------------------------------------------------------
    ESTRUTURAS DE MEMÓRIA E ARQUITETURA

	* Oracle armazena 40% de RAM, tendo dois tipos de memória:
		* Compartilhada 'SGA', usada por todos os usuários.
		* Dedicada 'PGA', onde cada usuário possui o seu próprio espaço.


    BD'S ARQ. FÍSICO - ORACLE  
	                      |
	  MEMÓRIA 'PGA' - INTÂNCIAS - MEMORIA 'SGA'
	                                |
                                Vários POOL'S

	** LARGE POOL - Rotinas de Backup, permite o paralelismo no Oracle.
	** JAVA POOL - Programação em Java e JVM.
	** STREAMS POOL - Armazena msg de replicação de dados.
	** INSTÂNCIAS - Podem ter diversas tabelas, bancos, etc. - INSTALAÇÃO DA MAQUINA

	#SQL -> Análise Sintática -> Semântica -> Dicionário de Dados -> Execução
	
	** LIBRAY CACHE - SQL, PLSQL, Procedures, Functions
	** DATA DICTIONARY CACHE - Definição de Dicionário
	** SHARED POOL - Local onde é verificado Sintáse e Semántica.
	
	* DATABASE BUFFER CACHE - (2kb, 4kb - Mais Rápida a Escrita) (8kb - Padrão) (16kb, 32kb - Melhor a Leitura)
	"Quando o usuário faz um sql, o Oracle verifica se o comando já foi veito antes assim acessando
	o buffer do sistema na SHARED POOL, utilizando o comando no Oracle. Ele armazena os dados comitados
	pelo usuário, que serão sincronizados com arquivos DBF's por um processo. "
	
	"... Mantém uma lista com os blocos mais utilizados e vai liberando espaço de acordo com os blocos
	mais usados e vai liberando espaço de acordo com os blocos menos utilizados sempre que necessário 
	para acessar informações novas." 
	
	"Arquivos Comitados são armazenados no REDOLOG BUFFER's 
	para não travar o espaço em dísco sendo depois 
	sincronizado no DBF e DISCO, lembrando que uma 
	serie de Redos forma um ARCHIVE."
	
	* PGA - Auxilia o usuário com cláusulas ORDER BY ou DISTINCT, variáveis BIND ou de SESSÃO
	
	



*/