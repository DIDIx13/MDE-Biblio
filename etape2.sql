-- a. Ajouter des ouvrages pour le livre SQL2
INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('01', SYSDATE, 20.50, (SELECT num FROM TITRES WHERE LIBELLE = 'SQL 2: Initiation, programmation'));

INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('02', SYSDATE, 20.50, (SELECT num FROM TITRES WHERE LIBELLE = 'SQL 2: Initiation, programmation'));

-- b. Ajouter des ouvrages pour les livres MCD et MPD-R PostgreSQL
INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('01', SYSDATE, 25.00, (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle conceptuel de données'));

INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('02', SYSDATE, 25.00, (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle conceptuel de données'));

INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('03', SYSDATE, 25.00, (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle conceptuel de données'));

INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('02', SYSDATE, 30.00, (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle physique de données relationnel: PostgreSQL'));

INSERT INTO OUVRAGE(numeroReference, dateAchat, prixAchat, Titre_exemplaire_num)
VALUES ('03', SYSDATE, 30.00, (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle physique de données relationnel: PostgreSQL'));

-- c. Créer plusieurs emprunts avec les données de votre choix
INSERT INTO EMPRUNT (num, dateEmprunt, dateRetourPrevu, dateRetourEffectif, Personne_membre_num, Titre_exemplaire_num)
VALUES (1, SYSDATE, SYSDATE + 7, NULL, (SELECT num FROM PERSONNES WHERE NOM = 'Ameli' AND PRENOM = 'Darwin'), (SELECT num FROM OUVRAGE WHERE numeroReference = '01' AND Titre_exemplaire_num = (SELECT num FROM TITRES WHERE LIBELLE = 'SQL 2: Initiation, programmation')));

INSERT INTO EMPRUNT (num, dateEmprunt, dateRetourPrevu, dateRetourEffectif, Personne_membre_num, Titre_exemplaire_num)
VALUES (2, SYSDATE, SYSDATE + 7, NULL, (SELECT num FROM PERSONNES WHERE NOM = 'Camus' AND PRENOM = 'Fabrice'), (SELECT num FROM OUVRAGE WHERE numeroReference = '02' AND Titre_exemplaire_num = (SELECT num FROM TITRES WHERE LIBELLE = 'SQL 2: Initiation, programmation')));

INSERT INTO EMPRUNT (num, dateEmprunt, dateRetourPrevu, dateRetourEffectif, Personne_membre_num, Titre_exemplaire_num)
VALUES (3, SYSDATE, SYSDATE + 7, SYSDATE + 8, (SELECT num FROM PERSONNES WHERE NOM = 'Sunier' AND PRENOM = 'Pierre-André'), (SELECT num FROM OUVRAGE WHERE numeroReference = '01' AND Titre_exemplaire_num = (SELECT num FROM TITRES WHERE LIBELLE = 'Modèle conceptuel de données')));

-- d. Afficher la liste des membres qui n’ont pas rendu leur emprunt dans les temps
SELECT P.NOM, P.PRENOM
FROM PERSONNES P
INNER JOIN EMPRUNT E ON P.NUM = E.PERSONNE_NUM
WHERE E.dateRetourPrevu < SYSDATE
AND E.dateRetourEffectif IS NULL;

-- e. Afficher la liste des ouvrages pour le titre MCD
SELECT CONCAT(T.CODEINTERNE, '-', O.numeroReference) AS CodeInventaire
FROM TITRES T
INNER JOIN OUVRAGE O ON T.NUM = O.TITRE_EXEMPLAIRE_NUM
WHERE T.LIBELLE = 'Modèle conceptuel de données';
