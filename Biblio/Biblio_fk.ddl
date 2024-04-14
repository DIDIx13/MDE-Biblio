ALTER TABLE reservations ADD CONSTRAINT FK1_Reserv_Personne_membre FOREIGN KEY (Personne_membre_num) REFERENCES personnes (num);
ALTER TABLE Ecrire ADD CONSTRAINT FK2_Ecrire_Personne FOREIGN KEY (Personne_num) REFERENCES personnes (num);
ALTER TABLE personnes ADD CONSTRAINT FK1_Personne_Emprunt_effectue FOREIGN KEY (Emprunt_effectue_num) REFERENCES emprunts (num);
