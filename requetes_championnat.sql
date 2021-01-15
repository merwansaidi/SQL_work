=================
-- TD du 21/04 --
=================

Afficher le classement des équipes à domicile.
-- Utilisation de la fonction sign(score_equipe_domicile - score_equipe_exterieure) 
-- Decode (res,1,3,0,1,-1,0)

Select e.Nom_Equipe ,SUM(decode(sign(m.score_equipe_domicile-m.score_equipe_exterieure),1,3,0,1,0)) AS NbPoint
 FROM Match m, Equipe e
WHERE E.ref_equipe = m.equipe_domicile
GROUP BY e.nom_equipe
ORDER BY NbPoint desc;

===========================================================================
-- Afficher score a domicile et exterieur et faire le classement globale --
===========================================================================

explain plan for 
SELECT Nom_Equipe , sum(NbPoint) AS Nb_Point from (
    Select e.Nom_Equipe ,SUM(decode(sign(m.score_equipe_domicile - m.score_equipe_exterieure),1,3,0,1,0)) AS NbPoint FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_domicile
    GROUP BY e.nom_equipe
    UNION
    Select e.Nom_Equipe ,SUM(decode(sign(m.score_equipe_exterieure -  m.score_equipe_domicile),1,3,0,1,0)) AS NbPoint FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_exterieure
    GROUP BY e.nom_equipe)
GROUP BY Nom_Equipe
ORDER BY (Nb_Point) DESC;

=============================================================================
-- Afficher l'équipe qui a mis le plus de but à l'extérieur et à domicile  --
=============================================================================

SELECT Nom_Equipe , sum(NbPoint) AS Nb_Point from (
    Select e.Nom_Equipe ,SUM(score_equipe_domicile) AS NbPoint FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_domicile
    GROUP BY e.nom_equipe
    UNION
    Select e.Nom_Equipe ,SUM(score_equipe_exterieure) AS NbPoint FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_exterieure
    GROUP BY e.nom_equipe)
GROUP BY Nom_Equipe
ORDER BY (Nb_Point) DESC

=========================================================================================
-- Afficher l’équipe qui a une meilleure defense (qui a encaissé le moin de but a dom) --
=========================================================================================

SELECT Nom_Equipe , sum(NbPoint) AS Nb_Point from (
     Select e.Nom_Equipe ,SUM(score_equipe_exterieure) AS NbPoint FROM Match m, Equipe e
     WHERE E.ref_equipe = m.equipe_domicile
     GROUP BY e.nom_equipe
    UNION
     Select e.Nom_Equipe ,SUM(score_equipe_domicile) AS NbPoint FROM Match m, Equipe e
     WHERE E.ref_equipe = m.equipe_exterieure
     GROUP BY e.nom_equipe)
GROUP BY Nom_Equipe
ORDER BY (Nb_Point) DESC;


--Trouver la bête noir : l’équipe contre laquel on a encaissé le moin de point :

=========================================================================================
-- Afficher nombre de point encaisser, marquer et la différence (marquer - encaisser)  --
=========================================================================================

SELECT Nom_Equipe , sum(NbPoint) AS Nb_Point, sum(marquer) as marquer, sum(encaisser) as encaisser, sum(difference) as difference
-- ,count(nb_match) as nb_match 
from (
    Select e.Nom_Equipe,SUM(decode(sign(m.score_equipe_domicile - m.score_equipe_exterieure),1,3,0,1,0)) AS NbPoint,SUM(score_equipe_domicile) as Marquer, sum(score_equipe_exterieure) as encaisser, sum(score_equipe_domicile - score_equipe_exterieure) as difference
--,count(id_match) as nb_match
    FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_domicile
    GROUP BY e.nom_equipe
    UNION
    Select e.Nom_Equipe ,SUM(decode(sign(m.score_equipe_exterieure-  m.score_equipe_domicile),1,3,0,1,0)) AS NbPoint, sum(score_equipe_exterieure) as marquer,SUM(score_equipe_domicile) as encaisser,sum(score_equipe_exterieure- score_equipe_domicile) as difference
-- ,count(id_match) as nb_match  
    FROM Match m, Equipe e
    WHERE E.ref_equipe = m.equipe_exterieure
    GROUP BY e.nom_equipe)
GROUP BY Nom_Equipe
ORDER BY (Nb_Point) DESC, difference desc;

