SET search_path = TP3;
-- 1) Lister les le numéro et nom des cliniques, leur adresse et leur gestionnaire, ordonnés par le numéro de clinique
SELECT NumeroClinique, nomClinique, Rue, Ville, Province, CodePostale, NumeroGestionnaire FROM Clinique ORDER BY NumeroClinique;

-- 2) Quels sont les noms des employés de plus de 40 ans ordonnés par nom ?
SELECT Nom FROM Personnel WHERE (DateDeNaissance <= '1981-04-20');

-- 3) Lister les noms des animaux dans toutes les cliniques ainsi que le nombre de fois où ils apparaissent. Par exemple Charlie, 3 
SELECT nom, COUNT(*) FROM Animal GROUP BY nom;

-- 4) Lister les numéros et noms des propriétaires d’animaux ainsi que les détails de leurs animaux dans une clinique donnée (à vous de la choisir)
SELECT DISTINCT p.NumeroProprietaire, p.Nom, 
a.NumeroAnimal, a.nom, a.TypeAnimal, a.Espece, a.Espece, a.Taille, a.Poids, a.Description, a.DateNaissance, a.DateInscription, a.Etat, a.NumeroClinique
FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND a.NumeroClinique = 'CLIN1'; 

-- 5) Lister l’ensemble des examens d’un animal donné en utilisant sa clé primaire
SELECT * FROM Examen WHERE NumeroAnimal = '011';

-- 6) Lister le détail des traitements d’un animal suite à un examen donné 
SELECT t.*, d.QuantiteTraitement, d.DateDebut, d.dateFin FROM Traitement t, ExamenTraitement d WHERE d.NumeroTraitement = t.NumeroTraitement AND d.NumeroExamen = '25';

-- 7) Lister le salaire total des employés par clinique ordonné par numéro de clinique
SELECT NumeroClinique, SUM(Salaire) FROM Personnel GROUP BY NumeroClinique ORDER BY NumeroClinique; 

-- 8) Lister le nombre total d’animaux par type dans chaque clinique. Par exemple : C1, chat, 40. 
SELECT NumeroClinique, TypeAnimal, COUNT(*) FROM Animal GROUP BY NumeroClinique, TypeAnimal ORDER BY NumeroClinique;

-- 9) Lister le coût minimum, maximum et moyen des traitements
SELECT MIN(Cout), MAX(Cout), AVG(Cout) FROM Traitement;

-- 10) Quels sont les propriétaires dont le nom contient « blay » ?
SELECT * FROM ProprietaireAnimal WHERE Nom LIKE '%blay%';

-- 11) Supprimez le vétérinaire « Jean Tremblay » qui travaille dans la clinique dont l’identificateur est C01.
DELETE FROM Personnel WHERE Nom = 'Jean Tremblay' AND NumeroClinique = 'CLI1' AND Fonction = 'Veterinaire';

-- 12) Lister les détails des propriétaires qui ont un chat et un chien
SELECT p.* FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND a.TypeAnimal = 'Chat' Intersect
SELECT p.*  FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND a.TypeAnimal = 'Chien';

-- 13) Lister les détails des propriétaires qui ont un chat ou un chien 
SELECT Distinct p.* FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND (a.TypeAnimal = 'Chat' or a.TypeAnimal = 'Chien');

-- 14) Lister les détails des propriétaires qui ont un chat mais pas de chien vacciné contre la grippe (la condition vacciné contre la grippe ne s’applique qu’aux chiens)
SELECT p.* FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND a.TypeAnimal = 'Chat' EXCEPT
(SELECT p.* FROM ProprietaireAnimal p, Animal a WHERE p.NumeroProprietaire = a.NumeroProprietaire AND a.TypeAnimal ='Chien' AND a.NumeroAnimal IN
(SELECT NumeroAnimal FROM Examen WHERE NumeroExamen  IN (SELECT NumeroExamen FROM ExamenTraitement WHERE NumeroTraitement = 'T112')));

-- 15) Lister tous les animaux d’une clinique donnée avec leurs traitements s’ils existent. Dans le cas contraire, affichez null.
SELECT DISTINCT a.*, tr.* FROM Animal a LEFT JOIN Examen e using (NumeroAnimal) LEFT JOIN
(SELECT t.*, d.QuantiteTraitement, d.DateDebut, d.dateFin, d.NumeroExamen FROM Traitement t, ExamenTraitement d WHERE d.NumeroTraitement = t.NumeroTraitement) AS tr
using(NumeroExamen) WHERE a.NumeroClinique = 'CLIN1';