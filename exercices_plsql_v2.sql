--*************************--
-- Cr�ation des tables     --
--*************************--

CREATE TABLE Segment
(indIP VARCHAR2(11),
nomSegment VARCHAR2(20) CONSTRAINT nn_nomSegment NOT NULL,
etage NUMBER(2),
CONSTRAINT pk_Segment PRIMARY KEY (indIP));

CREATE TABLE Salle
(nSalle VARCHAR2(7),
nomSalle VARCHAR2(20) CONSTRAINT nn_nomSalle NOT NULL,
nbPoste NUMBER(2), indIP VARCHAR2(11),
CONSTRAINT pk_salle PRIMARY KEY (nSalle));

CREATE TABLE Poste
(nPoste VARCHAR2(7),
nomPoste VARCHAR2(20) CONSTRAINT nn_nomPoste NOT NULL,
indIP VARCHAR2(11), ad VARCHAR2(3),
typePoste VARCHAR2(9), nSalle VARCHAR2(7),
CONSTRAINT pk_Poste PRIMARY KEY (nPoste),
CONSTRAINT ck_ad CHECK (ad BETWEEN '0' AND '255'));

CREATE TABLE Logiciel
(nLog VARCHAR2(5),
nomLog VARCHAR2(20) CONSTRAINT nn_nomLog NOT NULL,
dateAch DATE, version VARCHAR2(7),
typeLog VARCHAR2(9), prix NUMBER(6,2),
CONSTRAINT pk_Logiciel PRIMARY KEY (nLog),
CONSTRAINT ck_prix CHECK (prix >= 0));

CREATE TABLE Installer
(nPoste VARCHAR2(7), nLog VARCHAR2(5),
numIns NUMBER(5), dateIns DATE DEFAULT SYSDATE,
delai INTERVAL DAY(5) TO SECOND(2),
CONSTRAINT pk_Installer PRIMARY KEY(nPoste,nLog));

CREATE TABLE Types
(typeLP VARCHAR2(9), nomType VARCHAR2(20),
CONSTRAINT pk_types PRIMARY KEY(typeLP));


CREATE TABLE Tab_Poste_Gen
(nPoste VARCHAR2(7),
nomPoste VARCHAR2(20) NOT NULL,
indIP VARCHAR2(11), 
ad VARCHAR2(3),
typePoste VARCHAR2(9),
nSalle VARCHAR2(7),
nomSegment VARCHAR2(20) ,
nomType VARCHAR2(20)
);

--**************************--
-- Insertion de donn�es     --
--**************************--

INSERT INTO Segment VALUES ('130.120.80','Brin RDC',NULL);
INSERT INTO Segment VALUES ('130.120.81','Brin 1er �tage',NULL);
INSERT INTO Segment VALUES ('130.120.82','Brin 2�me �tage',NULL);

INSERT INTO Salle VALUES ('s01','Salle 1',3,'130.120.80');
INSERT INTO Salle VALUES ('s02','Salle 2',2,'130.120.80');
INSERT INTO Salle VALUES ('s03','Salle 3',2,'130.120.80');
INSERT INTO Salle VALUES ('s11','Salle 11',2,'130.120.81');
INSERT INTO Salle VALUES ('s12','Salle 12',1,'130.120.81');
INSERT INTO Salle VALUES ('s21','Salle 21',2,'130.120.82');
INSERT INTO Salle VALUES ('s22','Salle 22',0,'130.120.83');
INSERT INTO Salle VALUES ('s23','Salle 23',0,'130.120.83');

INSERT INTO Poste VALUES ('p1','Poste 1','130.120.80','01','TX','s01');
INSERT INTO Poste VALUES ('p2','Poste 2','130.120.80','02','UNIX','s01');
INSERT INTO Poste VALUES ('p3','Poste 3','130.120.80','03','TX','s01');
INSERT INTO Poste VALUES ('p4','Poste 4','130.120.80','04','PCWS','s02');
INSERT INTO Poste VALUES ('p5','Poste 5','130.120.80','05','PCWS','s02');
INSERT INTO Poste VALUES ('p6','Poste 6','130.120.80','06','UNIX','s03');
INSERT INTO Poste VALUES ('p7','Poste 7','130.120.80','07','TX','s03');
INSERT INTO Poste VALUES ('p8','Poste 8','130.120.81','01','UNIX','s11');
INSERT INTO Poste VALUES ('p9','Poste 9','130.120.81','02','TX','s11');
INSERT INTO Poste VALUES ('p10','Poste 10','130.120.81','03','UNIX','s12');
INSERT INTO Poste VALUES ('p11','Poste 11','130.120.82','01','PCNT','s21');
INSERT INTO Poste VALUES ('p12','Poste 12','130.120.82','02','PCWS','s21');

--INSERT INTO Logiciel VALUES ('log1','Oracle 7',to_date('13/05/1995','DD/MM/YYYY'),'6.2','UNIX',3000);
--INSERT INTO Logiciel VALUES ('log2','Oracle 8',to_date('15/09/1999','DD/MM/YYYY'),'8i','UNIX',5600);
--INSERT INTO Logiciel VALUES ('log3','SQL Server',to_date('12/04/1998','DD/MM/YYYY'),'7','PCNT',3000);
--INSERT INTO Logiciel VALUES ('log4','Front Page',to_date('03/06/1997','DD/MM/YYYY'),'5','PCWS',500);
--INSERT INTO Logiciel VALUES ('log5','WinDev',to_date('12/05/1997','DD/MM/YYYY'),'5','PCWS',750);
--INSERT INTO Logiciel VALUES ('log6','SQL*Net',to_date('02/03/2001','DD/MM/YYYY'),'2.0','UNIX',500);
--INSERT INTO Logiciel VALUES ('log7','I. I. S.',to_date('12/04/2002','DD/MM/YYYY'),'2','PCNT',900);
--INSERT INTO Logiciel VALUES ('log8','DreamWeaver',to_date('21/09/2003','DD/MM/YYYY'),'2.0','BeOS',1400);

INSERT INTO Types VALUES ('TX', 'Terminal X-Window');
INSERT INTO Types VALUES ('UNIX','Syst�me Unix');
INSERT INTO Types VALUES ('PCNT','PC Windows NT');
INSERT INTO Types VALUES ('PCWS','PC Windows');
INSERT INTO Types VALUES ('NC', 'Network Computer');

--**************************--
-- Gestion d�une s�quence   --
--**************************--

CREATE SEQUENCE sequenceIns
INCREMENT BY 1 START WITH 1
MAXVALUE 10000 NOCYCLE;

INSERT INTO Installer VALUES
('p2', 'log1', sequenceIns.NEXTVAL,to_date('13/05/2001','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p2', 'log2', sequenceIns.NEXTVAL,to_date('10/07/1999','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p4', 'log5', sequenceIns.NEXTVAL,to_date('02/05/2001','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p6', 'log6', sequenceIns.NEXTVAL,to_date('05/04/2005','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p6', 'log1', sequenceIns.NEXTVAL,to_date('12/06/2004','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p8', 'log2', sequenceIns.NEXTVAL,to_date('25/10/2003','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p8', 'log6', sequenceIns.NEXTVAL,to_date('30/12/2010','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p11','log3', sequenceIns.NEXTVAL,to_date('09/11/2008','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p12','log4', sequenceIns.NEXTVAL,to_date('19/02/2009','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p11','log7', sequenceIns.NEXTVAL,to_date('22/08/2000','DD/MM/YYYY'),NULL);
INSERT INTO Installer VALUES
('p7', 'log7', sequenceIns.NEXTVAL,to_date('20/01/2002','DD/MM/YYYY'),NULL);

--**************************--
-- Modification de donn�es  --
--**************************--

UPDATE Segment SET etage=0 WHERE indIP = '130.120.80';
UPDATE Segment SET etage=1 WHERE indIP = '130.120.81';
UPDATE Segment SET etage=2 WHERE indIP = '130.120.82';

--**************************--
-- Ajout de colonnes				--
--**************************--

ALTER TABLE Segment ADD (nbSalle NUMBER(2), nbPoste NUMBER(2));
ALTER TABLE Logiciel ADD nbInstall NUMBER(2);
ALTER TABLE Poste ADD nbLog NUMBER(2);

--**************************--
-- Modification de colonnes --
--**************************--

ALTER TABLE Salle MODIFY nomSalle VARCHAR2(30);
ALTER TABLE Segment MODIFY nomSegment VARCHAR(20);

--*******************************--
-- Suppression des contraintes	 --
--*******************************--
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_indIP_Segment;
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_nSalle_Salle;
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_typePoste_Types;
ALTER TABLE Installer DROP CONSTRAINT fk_Installer_nPoste_Poste;
ALTER TABLE Installer DROP CONSTRAINT fk_Installer_nLog_Logiciel;

--**************************--
-- Ajout de contraintes			--
--**************************--
ALTER TABLE Poste
ADD CONSTRAINT fk_Poste_indIP_Segment FOREIGN KEY(indIP)
REFERENCES Segment(indIP);

ALTER TABLE Poste
ADD CONSTRAINT fk_Poste_nSalle_Salle FOREIGN KEY(nSalle)
REFERENCES Salle(nSalle);

ALTER TABLE Poste
ADD CONSTRAINT fk_Poste_typePoste_Types FOREIGN KEY(typePoste)
REFERENCES Types(typeLP);

ALTER TABLE Installer
ADD CONSTRAINT fk_Installer_nPoste_Poste FOREIGN KEY(nPoste)
REFERENCES Poste(nPoste);

ALTER TABLE Installer
ADD CONSTRAINT fk_Installer_nLog_Logiciel FOREIGN KEY(nLog)
REFERENCES Logiciel(nLog) ;

--*************************--
-- Traitements des rejets  --
--*************************--

CREATE TABLE exceptions(row_id rowid,
                        owner varchar2(30),
                        table_name varchar2(30),
                        constraint varchar2(30));

ALTER TABLE Logiciel
ADD CONSTRAINT fk_Logiciel_typeLog_Types FOREIGN KEY(typeLog)
REFERENCES Types(typeLP) EXCEPTIONS INTO exceptions;

SELECT * from exceptions;

select typ.* 
from Types typ, exceptions excp
where excp.row_id = typ.rowid;

select logic.* 
from logiciel logic, exceptions excp
where excp.row_id = logic.rowid


ALTER TABLE Salle
ADD CONSTRAINT fk_Salle_indIP_Segment FOREIGN KEY(indIP)
REFERENCES Segment(indIP) EXCEPTIONS INTO exceptions;



R�solution des rejets en :

� s�lectionnant les enregistrements de la table exceptions.
DELETE FROM exceptions;

� supprimant les enregistrements de la table exceptions.
DELETE FROM exceptions;

� supprimant les enregistrements de la table Salle qui ne respectent pas la contrainte.
DELETE FROM Salle WHERE indIP NOT IN (SELECT indIP FROM Segment);

� ajoutant le type de logiciel (�BeOS�, �Syst�me Be�)
INSERT INTO Types VALUES ('BeOS','Syst�me Be');
L�ajout des deux contraintes de cl� �trang�re ne envoie plus d�erreur et la table "exceptions" reste vide.


--**********************************--
-- Calcul de statistics d'une table --
--**********************************--
execute dbms_stats.gather_table_stats(ownname => 'ORAUSE99', tabname => 'nom_de_la_table', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');

--**********************************--
-- Calcul de statistics d'un indexe --
--**********************************--
execute dbms_stats.gather_index_stats(ownname => 'ORAUSE99', indname => 'nom_indexe', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE);

--**********************************--
-- Affichage d'un plan d'ex�cution  --
--**********************************--

execute dbms_stats.gather_table_stats(ownname => 'ORAUSE99', tabname => 'POSTE', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');

SQL> SET AUTOTRACE ON

sql> SET AUTOTRACE TRACE EXPLAIN ON

SELECT s.nomSegment
FROM Segment s, Poste p
WHERE s.indIP = p.indIP
AND p.typePoste = 'TX'
GROUP BY s.nomSegment
HAVING COUNT(*)=3;


SQL> explain plan for
SELECT s.nomSegment
FROM Segment s, Poste p
WHERE s.indIP = p.indIP
AND p.typePoste = 'TX'
GROUP BY s.nomSegment
HAVING COUNT(*)=3;

Expliqu�. Explained.

SQL> SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY); 


SQL> EXPLAIN PLAN SET STATEMENT_ID = 'SQL_TEST_1' FOR
	SELECT s.nomSegment
	FROM Segment s, Poste p
	WHERE s.indIP = p.indIP
	AND p.typePoste = 'TX'
	GROUP BY s.nomSegment
	HAVING COUNT(*)=3;


 /****************************************************************/
/* Create EXPLAIN_OUT procedure. User must pass STATEMENT_ID to */
/* to procedure, to uniquely identify statement.                */
/****************************************************************/
CREATE OR REPLACE PROCEDURE explain_out 
   (statement_id IN VARCHAR2) AS 
   -- Retrieve information from PLAN_TABLE into cursor EXPLAIN_ROWS.
   CURSOR explain_rows IS 
      SELECT level, id, position, operation, options,
         object_name 
      FROM plan_table 
      WHERE statement_id = explain_out.statement_id 
      CONNECT BY PRIOR id = parent_id 
         AND statement_id = explain_out.statement_id 
      START WITH id = 0
       ORDER BY id; 
BEGIN 
   -- Loop through information retrieved from PLAN_TABLE:
   FOR line IN explain_rows LOOP 
      -- At start of output, include heading with estimated cost.
      IF line.id = 0 THEN 
         DBMS_OUTPUT.PUT_LINE ('Plan for statement '
            || statement_id
            || ', estimated cost = ' || line.position); 
      END IF; 
      -- Output formatted information. LEVEL determines indention level.
      DBMS_OUTPUT.PUT_LINE (lpad(' ',2*(line.level-1)) ||
         line.operation || ' ' || line.options || ' ' || 
         line.object_name); 
   END LOOP; 
END; 
/

--************************************************--
-- Le script de destruction des tables devient :  --
--************************************************--

--*******************************--
-- Suppression des contraintes	 --
--*******************************--
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_indIP_Segment;
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_nSalle_Salle;
ALTER TABLE Poste DROP CONSTRAINT fk_Poste_typePoste_Types;
ALTER TABLE Installer DROP CONSTRAINT fk_Installer_nPoste_Poste;
ALTER TABLE Installer DROP CONSTRAINT fk_Installer_nLog_Logiciel;

--DROP TABLE Installer purge;
--DROP TABLE Logiciel purge;
--DROP TABLE Poste purge;
--DROP TABLE Types purge;
--DROP TABLE Salle purge;
--DROP TABLE Segment purge;



exec dbms_stats.create_stat_table ( ownname => user , stattab => 'temp_stat' ) ;

exec dbms_stats.export_table_stats ( ownname => user , stattab => 'temp_stat', 
									tabname => 'mytable', statid => 'stats03252011') ;

FTP stats to to new database by exporting the table temp_stat table

exec dbms_stats.import_table_stats ( ownname => user , stattab => 'temp_stat', tabname => 'customer_fact' )

