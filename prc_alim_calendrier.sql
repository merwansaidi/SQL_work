CREATE OR REPLACE PROCEDURE PRC_ALIM_TAB_CALENDRIER
IS
--/**/
--/***************************************/
--/* Déclaration des variales utilisées */
--/***************************************/
--/**/
v_date_debut DATE;
v_date_fin   DATE;
BEGIN
--/********************************/
--/* Purge de la table CALENDRIER */
--/********************************/
--/**/
    DELETE calendrier;
--/**/
--/***************************************/
--/* Alimentation de la table CALENDRIER */
--/***************************************/
	IF v_date_debut IS NULL THEN
	   v_date_debut := TRUNC(TO_DATE('01/01/2010','DD/MM/YYYY'));
	END IF;
--/**/
	IF v_date_fin IS NULL THEN
	   v_date_fin := TRUNC(TO_DATE('31/12/2018','DD/MM/YYYY'));
	END IF;
--/**/
    WHILE v_date_debut <= to_date(v_date_fin)
	LOOP
	  INSERT INTO CALENDRIER (DATE_JOUR, ANNEE, TRIMESTRE, MOIS, SEMAINE, FLG_FERIE, FLG_AUTRE)
	  VALUES (v_date_debut,TO_CHAR(v_date_debut,'YYYY'), TO_CHAR(v_date_debut,'Q'),
	  		  TO_CHAR(v_date_debut,'MM'), TO_CHAR(v_date_debut,'WW'),0,0);
      v_date_debut := v_date_debut + 1;
	END LOOP;
--/**/
--/*******************************/
--/* Validation des transactions */
--/*******************************/
    COMMIT;
--/**/
--/**************************/
--/* Gestion des exceptions */
--/**************************/
    EXCEPTION
	   WHEN DUP_VAL_ON_INDEX THEN
	   --/**/
	   --/*******************************/
	   --/* Annulation des transactions */
	   --/*******************************/
	   --/**/
	   	 ROLLBACK;
	     RAISE_APPLICATION_ERROR(-20000, 'Impossible d''insérer des lignes.'||TO_CHAR(SQLCODE)||' : '||SUBSTR(SQLERRM,1,100));
	   WHEN OTHERS THEN
	   --/**/
	   --/*******************************/
	   --/* Annulation des transactions */
	   --/*******************************/
	   --/**/
	   	 ROLLBACK;
	     RAISE_APPLICATION_ERROR(-20010, 'Erreur Oracle inattendue : '||TO_CHAR(SQLCODE)||' : '||SUBSTR(SQLERRM,1,100));
--/**/
--/**/
END PRC_ALIM_TAB_CALENDRIER;
/

CREATE OR REPLACE TRIGGER TRG_CTL_SAM_DIM
BEFORE INSERT OR UPDATE
ON CALENDRIER
FOR EACH ROW
BEGIN
  IF TO_CHAR(:new.date_jour,'D') in ('1','7') THEN
     :new.flg_autre := '1';
  ELSE 
     :new.flg_autre := '0';
END IF;
END;
/
