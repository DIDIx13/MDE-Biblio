-- Ajouter un membre à votre nom
INSERT INTO PERSONNES(NOM, PRENOM, EMAIL, DATENAISSANCE)
VALUES ('Ameli', 'Darwin', 'darwin.ameli@he-arc.ch', NULL);

-- Le membre Fabrice Camus réserve le titre "SQL2 : Initiation..."
INSERT INTO RESERVATIONS(Personne_membre_num, Titre_pour_num, dateHeureReservation)
VALUES (
    (SELECT NUM FROM PERSONNES WHERE (NOM='Camus' AND PRENOM='Fabrice')), 
    (SELECT NUM FROM TITRES WHERE (LIBELLE='SQL 2: Initiation, programmation')), 
    SYSDATE
);

-- Vous réservez le titre "Modèle physique de données relationnel: PostgreSQL"
INSERT INTO RESERVATIONS(Personne_membre_num, Titre_pour_num, dateHeureReservation)
VALUES (
    (SELECT NUM FROM PERSONNES WHERE (NOM='Ameli' AND PRENOM='Darwin')), 
    (SELECT NUM FROM TITRES WHERE (LIBELLE='Modèle physique de données relationnel: PostgreSQL')), 
    SYSDATE
);

-- Ajouter un titre de votre choix avec toutes les données nécessaires (titre+auteur)
INSERT INTO TITRES(ISBN, CODEINTERNE, LIBELLE) 
VALUES ('2233445566', 'MDEBiblio', 'BlablaBiblio');

INSERT INTO ECRIRE(TIT_NUM, PERS_NUM, ESTREFERENCE)
VALUES (
    (SELECT NUM FROM TITRES WHERE (ISBN='2233445566')), 
    (SELECT NUM FROM PERSONNES WHERE (NOM='Ameli' AND PRENOM='Darwin')),
    'Y'
);

-- Afficher la liste des titres avec son(ses) auteur(s)
SELECT 
    T.LIBELLE AS Titre, 
    P.NOM AS Nom, 
    P.PRENOM AS Prenom
FROM 
    TITRES T
INNER JOIN 
    ECRIRE E ON T.NUM = E.TIT_NUM
INNER JOIN 
    PERSONNES P ON E.PERS_NUM = P.NUM;

-- Afficher les détails de la colonne estreference dans la table Ecrire
SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'ECRIRE' AND COLUMN_NAME = 'ESTREFERENCE';
