ALTER TABLE langues ADD CONSTRAINT PK_Langue PRIMARY KEY (num);
ALTER TABLE emprunts ADD CONSTRAINT PK_Emprunt PRIMARY KEY (num);
ALTER TABLE ouvrages ADD CONSTRAINT PK_Ouvrage PRIMARY KEY (Titre_exemplaire_num, numdep);
