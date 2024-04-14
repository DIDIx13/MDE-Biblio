ALTER TABLE reservations ADD CONSTRAINT FK2_Reserv_Titre_pour FOREIGN KEY (Titre_pour_num) REFERENCES titres (num);
ALTER TABLE reservations ADD CONSTRAINT FK1_Reserv_Personne_membre FOREIGN KEY (Personne_membre_num) REFERENCES personnes (num);
ALTER TABLE Ecrire ADD CONSTRAINT FK2_Ecrire_Personne FOREIGN KEY (Personne_num) REFERENCES personnes (num);
ALTER TABLE Ecrire ADD CONSTRAINT FK1_Ecrire_Titre FOREIGN KEY (Titre_num) REFERENCES titres (num);
