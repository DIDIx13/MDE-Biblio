ALTER TABLE ouvrages 
  DROP CONSTRAINT NID1_Ouvrage_numeroReference;
ALTER TABLE langues 
  DROP CONSTRAINT NID1_Langue_libelle;
ALTER TABLE titres 
  DROP CONSTRAINT NID2_Titre_codeInterne;
ALTER TABLE titres 
  DROP CONSTRAINT NID1_Titre_isbn;
ALTER TABLE titres 
  ADD CONSTRAINT NID1_Titre_isbn 
    UNIQUE (isbn);
ALTER TABLE titres 
  ADD CONSTRAINT NID2_Titre_codeInterne 
    UNIQUE (codeInterne);
ALTER TABLE langues 
  ADD CONSTRAINT NID1_Langue_libelle 
    UNIQUE (libelle);
ALTER TABLE ouvrages 
  ADD CONSTRAINT NID1_Ouvrage_numeroReference 
    UNIQUE (Titre_exemplaire_num, numeroReference);
CREATE INDEX FK1_Personne_Emprunt_effectue 
  ON personnes (Emprunt_effectue_num);
