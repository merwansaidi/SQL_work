=====================
--  GROUPING SETS  --
=====================
/**/
Calculating all possible subtotals in a cube, especially those with many dimensions, can be quite an intensive process.
If you don't need all the subtotals, this can represent a considerable amount of wasted effort. 
The following cube with three dimensions gives 8 levels of subtotals (GROUPING_ID: 0-7), 
/**/
Le calcul de tous les sous-totaux possibles dans un cube, en particulier ceux comportant de nombreuses dimensions,
peut être un processus très intensif. Si vous n''avez pas besoin de tous les sous-totaux, 
cela peut représenter une somme considérable d''efforts inutiles. 
Le cube suivant en trois dimensions donne 8 niveaux de sous-totaux (GROUPING_ID: 0-7),
/**/
==============
--  ROLLUP  --
==============
/**/
In addition to the regular aggregation results we expect from the GROUP BY clause, 
the ROLLUP extension produces group subtotals from right to left and a grand total. 
If "n" is the number of columns listed in the ROLLUP, there will be n+1 levels of subtotals.
/**/
Outre les résultats d''agrégation réguliers attendus de la clause GROUP BY, 
l''extension ROLLUP génère des sous-totaux de groupe de droite à gauche et un total général. 
Si "n" est le nombre de colonnes répertoriées dans le ROLLUP, il y aura n + 1 niveaux de sous-totaux.
/**/
==============
--  CUBE    --
==============
/**/
Outre les sous-totaux générés par l''extension ROLLUP, l''extension CUBE génère des sous-totaux 
pour toutes les combinaisons des dimensions spécifiées. 
Si "n" est le nombre de colonnes répertoriées dans le CUBE, il y aura 2n combinaisons sous-totales.
/**/
Outre les sous-totaux générés par l''extension ROLLUP, 
l''extension CUBE génère des sous-totaux pour toutes les combinaisons des dimensions spécifiées. 
Si "n" est le nombre de colonnes répertoriées dans le CUBE, il y aura 2n combinaisons sous-totales.
/**/
==============
--  RANK()  --
==============
/**/
Let''s assume we want to assign a sequential order, or rank, to people within a department based on salary, 
we might use the RANK function like.
/**/
Supposons que nous voulions attribuer un ordre séquentiel, ou un rang, aux personnes d’un département en fonction de leur salaire,
nous pourrions utiliser la fonction RANK comme.
/**/
SELECT empno,
       deptno,
       sal,
       RANK() OVER (PARTITION BY deptno ORDER BY sal) "rank"
FROM   emp;

     EMPNO     DEPTNO        SAL       rank
---------- ---------- ---------- ----------
      7934         10       1300          1
      7782         10       2450          2
      7839         10       5000          3
      7369         20        800          1
      7876         20       1100          2
      7566         20       2975          3
      7788         20       3000          4
      7902         20       3000          4
      7900         30        950          1
      7654         30       1250          2
      7521         30       1250          2
      7844         30       1500          4
      7499         30       1600          5
      7698         30       2850          6

================
-- DENSE_RANK --
================
/**/
The DENSE_RANK function acts like the RANK function except that it assigns consecutive ranks.
/**/
La fonction DENSE_RANK agit comme la fonction RANK sauf qu’elle attribue des rangs consécutifs.
/**/
SELECT empno,
       deptno,
       sal,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) "rank"
FROM   emp;

     EMPNO     DEPTNO        SAL       rank
---------- ---------- ---------- ----------
      7934         10       1300          1
      7782         10       2450          2
      7839         10       5000          3
      7369         20        800          1
      7876         20       1100          2
      7566         20       2975          3
      7788         20       3000          4
      7902         20       3000          4
      7900         30        950          1
      7654         30       1250          2
      7521         30       1250          2
      7844         30       1500          3
      7499         30       1600          4
      7698         30       2850          5

====================
-- FIRST and LAST --
====================
/**/
The FIRST and LAST functions can be used to return the first or last value from an ordered sequence.
Say we want to display the salary of each employee, along with the lowest and highest within their department we may use something like.
/**/
Les fonctions FIRST et LAST peuvent être utilisées pour renvoyer la première ou la dernière valeur d''une séquence ordonnée.
Supposons que nous voulions afficher le salaire de chaque employé, ainsi que le plus bas et le plus élevé de leur département,
nous pourrions utiliser une requête de ce genre.
/**/
SELECT empno,
       deptno,
       sal,
       MIN(sal) KEEP (DENSE_RANK FIRST ORDER BY sal) OVER (PARTITION BY deptno) "Lowest",
       MAX(sal) KEEP (DENSE_RANK LAST ORDER BY sal) OVER (PARTITION BY deptno) "Highest"
FROM   emp
ORDER BY deptno, sal;

     EMPNO     DEPTNO        SAL     Lowest    Highest
---------- ---------- ---------- ---------- ----------
      7934         10       1300       1300       5000
      7782         10       2450       1300       5000
      7839         10       5000       1300       5000
      7369         20        800        800       3000
      7876         20       1100        800       3000
      7566         20       2975        800       3000
      7788         20       3000        800       3000
      7902         20       3000        800       3000
      7900         30        950        950       2850
      7654         30       1250        950       2850
      7521         30       1250        950       2850
      7844         30       1500        950       2850
      7499         30       1600        950       2850
      7698         30       2850        950       2850

====================================
-- DENSE_RANK() with where clause --
====================================
/**/
As with the RANK analytic function, we can do a Top-N query on a per-department basis. 
The example below assigns the dense rank in the inline view, then uses that rank to restrict the rows 
to the top 2 (best paid) employees in each department.
/**/
Comme avec la fonction analytique RANK, nous pouvons effectuer une requête Top-N sur une base par département.
L''exemple ci-dessous attribue le rang dense dans la vue intégrée, puis utilise ce rang pour restreindre les lignes.
aux 2 meilleurs employés (les mieux payés) de chaque département.
/**/
SELECT *
FROM   (SELECT empno,
               deptno,
               sal,
               DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS myrank
        FROM   emp)
WHERE  myrank <= 2;

     EMPNO     DEPTNO        SAL     MYRANK
---------- ---------- ---------- ----------
      7839         10       5000          1
      7782         10       2450          2
      7788         20       3000          1
      7902         20       3000          1
      7566         20       2975          2
      7698         30       2850          1
      7499         30       1600          2


