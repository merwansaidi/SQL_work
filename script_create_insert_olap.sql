spool c:\temp\trace.log
create table VENTES (
	ref_client	VARCHAR2(15),
	ref_produit		VARCHAR2(10),
	ref_fournisseur	VARCHAR2(20),
	montant		NUMBER(10,2)
	);

DROP INDEX IDX_VENTES_CLI;
DROP INDEX IDX_VENTES_PROD;
DROP INDEX IDX_VENTES_FOUR;
CREATE INDEX IDX_VENTES_CLI ON VENTES (ref_client) ;
CREATE INDEX IDX_VENTES_PROD ON VENTES (ref_produit)  ;
CREATE INDEX IDX_VENTES_FOUR ON VENTES (ref_fournisseur)  ;

Insert into VENTES values ('ref_client_1', 'savon', 'palmolive',10);
Insert into VENTES values ('ref_client_2', 'savon', 'dop', 2);
Insert into VENTES values ('ref_client_3', 'savon', 'palmolive',7);
Insert into VENTES values ('ref_client_4', 'savon', 'dixrit', 15);
Insert into VENTES values ('ref_client_5', 'savon', 'dop', 6);

Insert into VENTES values ('ref_client_6', 'shampoing', 'dop', 1);
Insert into VENTES values ('ref_client_1', 'shampoing', 'elsève', 20);
Insert into VENTES values ('ref_client_2', 'shampoing', 'shamp1', 5);
Insert into VENTES values ('ref_client_5', 'shampoing','dop', 10);
Insert into VENTES values ('ref_client_6', 'shampoing', 'elsève', 7);

Insert into VENTES values ('ref_client_1', 'lessive', 'dash', 25);
Insert into VENTES values ('ref_client_2', 'lessive', 'ariel', 34);
Insert into VENTES values ('ref_client_3', 'lessive', 'ariel', 31);
Insert into VENTES values ('ref_client_4', 'lessive', 'skip', 50);
Insert into VENTES values ('ref_client_5', 'lessive', 'omo', 30);

Insert into VENTES values ('ref_client_4', 'serviette', 'inextenso', 100);
Insert into VENTES values ('ref_client_5', 'serviette',' inextenso', 22);
Insert into VENTES values ('ref_client_6', 'serviette', 'lacoste', 35);
Insert into VENTES values ('ref_client_3', 'serviette', 'adidas', 41);
Insert into VENTES values ('ref_client_2', 'serviette', 'puma', 58);
Insert into VENTES values ('ref_client_1', 'serviette', 'lacoste', 64);
Insert into VENTES values ('ref_client_2', 'serviette', 'adidas', 82);

Insert into VENTES values ('ref_client_2', 'crayon', 'hb', 12);
Insert into VENTES values ('ref_client_5', 'crayon', 'reynolds', 25);
Insert into VENTES values ('ref_client_3', 'crayon', 'reynolds', 150);
Insert into VENTES values ('ref_client_1', 'crayon', 'bic', 36);
Insert into VENTES values ('ref_client_4', 'crayon', 'bic', 27);
Insert into VENTES values ('ref_client_6', 'crayon', 'hb', 16);

Insert into VENTES values ('ref_client_4', 'cahier', 'clairefontaine', 25);
Insert into VENTES values ('ref_client_2', 'cahier', 'carrefour', 76);
Insert into VENTES values ('ref_client_5', 'cahier', 'office dp', 153);
Insert into VENTES values ('ref_client_3', 'cahier', 'carrefour',81);
Insert into VENTES values ('ref_client_1', 'cahier', 'esselte',50);
/**/
Commit;
/**/
create table dept(  
  deptno     number(2,0),  
  dname      varchar2(14),  
  loc        varchar2(13),  
  constraint pk_dept primary key (deptno)  
);

create table emp(  
  empno    number(4,0),  
  ename    varchar2(10),  
  job      varchar2(9),  
  mgr      number(4,0),  
  hiredate date,  
  sal      number(7,2),  
  comm     number(7,2),  
  deptno   number(2,0),  
  constraint pk_emp primary key (empno),  
  constraint fk_deptno foreign key (deptno) references dept (deptno)  
);

/**/
insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

/**/
INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,to_date('13-07-87','dd-mm-rr')-85,3000,NULL,20);
INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO emp VALUES (7876,'ADAMS','CLERK',7788,to_date('13-07-87', 'dd-mm-rr')-51,1100,NULL,20);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

COMMIT;

/**/
--**********************************--
-- Calcul de statistics d'une table --
--**********************************--
execute dbms_stats.gather_table_stats(ownname => 'DWH', tabname => 'VENTES', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');

--**********************************--
-- Calcul de statistics d'un indexe --
--**********************************--
execute dbms_stats.gather_index_stats(ownname => 'DWH', indname => 'IDX_VENTES_CLI', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE);

--**********************************--
-- Affichage d'un plan d'exécution  --
--**********************************--

SQL> explain plan for
	SELECT ref_client, ref_produit, ref_fournisseur, SUM(montant)
	FROM ventes
	GROUP BY CUBE (ref_client, ref_produit, ref_fournisseur);

Expliqué. Explained.

SQL> SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY); 

spool off

