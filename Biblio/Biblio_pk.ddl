ALTER TABLE titres ADD CONSTRAINT PK_Titre PRIMARY KEY (num);
ALTER TABLE Ecrire ADD CONSTRAINT PK_Ecrire PRIMARY KEY (Titre_num, Personne_num);
ALTER TABLE reservations ADD CONSTRAINT PK_Reserv PRIMARY KEY (num);
