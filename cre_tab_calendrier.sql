create table Calendrier
(
    DATE_JOUR        DATE                   not null,
    ANNEE            number(4)              null    ,
    TRIMESTRE           number(1)              null    ,
    MOIS            number(2)              null    ,
    SEMAINE            number(2)              null    ,
    FLG_FERIE        number(1)              null    ,
    FLG_AUTRE        number(1)              null    ,
    constraint PK_CALENDRIER primary key (DATE_JOUR)
    USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
    STORAGE(INITIAL 32K NEXT 32K MINEXTENTS 1 MAXEXTENTS 500 PCTINCREASE 0) 
    TABLESPACE USERS) 
    STORAGE(INITIAL 64K NEXT 64K MINEXTENTS 1 MAXEXTENTS 1000 PCTINCREASE 0) 
    TABLESPACE USERS
;
