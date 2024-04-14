CREATE INDEX FK1_Ecrire_Titre 
  ON Ecrire (Titre_num);
CREATE INDEX FK2_Ecrire_Personne 
  ON Ecrire (Personne_num);
CREATE INDEX FK1_Reserv_Personne_membre 
  ON reservations (Personne_membre_num);
CREATE INDEX FK2_Reserv_Titre_pour 
  ON reservations (Titre_pour_num);
