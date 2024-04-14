CREATE OR REPLACE TRIGGER Personne_BIR
	BEFORE INSERT ON personnes FOR EACH ROW
	DECLARE
	vl_newrec personnes%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Emprunt_effectue_num := :NEW.Emprunt_effectue_num;
vl_newrec.nom := :NEW.nom;
vl_newrec.prenom := :NEW.prenom;
vl_newrec.email := :NEW.email;
vl_newrec.dateNaissance := :NEW.dateNaissance;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Personne_TAPIs.autogen_column_ins(vl_newrec);
		Personne_TAPIs.autogen_column(vl_newrec);
		Personne_TAPIs.checktype_column(vl_newrec);
		Personne_TAPIs.uppercase_column(vl_newrec);
		Personne_TAPIs.column_PEA(vl_newrec);
		Personne_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.num := vl_newrec.num;
:NEW.Emprunt_effectue_num := vl_newrec.Emprunt_effectue_num;
:NEW.nom := vl_newrec.nom;
:NEW.prenom := vl_newrec.prenom;
:NEW.email := vl_newrec.email;
:NEW.dateNaissance := vl_newrec.dateNaissance;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Personne_BUR
	BEFORE UPDATE ON personnes FOR EACH ROW
	DECLARE
	vl_newrec personnes%ROWTYPE;
	vl_oldrec personnes%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Emprunt_effectue_num := :NEW.Emprunt_effectue_num;
vl_newrec.nom := :NEW.nom;
vl_newrec.prenom := :NEW.prenom;
vl_newrec.email := :NEW.email;
vl_newrec.dateNaissance := :NEW.dateNaissance;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
vl_oldrec.Emprunt_effectue_num := :OLD.Emprunt_effectue_num;
vl_oldrec.nom := :OLD.nom;
vl_oldrec.prenom := :OLD.prenom;
vl_oldrec.email := :OLD.email;
vl_oldrec.dateNaissance := :OLD.dateNaissance;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Personne_TAPIs.autogen_column_upd(vl_newrec);
		Personne_TAPIs.autogen_column(vl_newrec);
		Personne_TAPIs.checktype_column(vl_newrec);
		Personne_TAPIs.uppercase_column(vl_newrec);
		Personne_TAPIs.column_PEA(vl_newrec);
		Personne_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Personne_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.num := vl_newrec.num;
:NEW.Emprunt_effectue_num := vl_newrec.Emprunt_effectue_num;
:NEW.nom := vl_newrec.nom;
:NEW.prenom := vl_newrec.prenom;
:NEW.email := vl_newrec.email;
:NEW.dateNaissance := vl_newrec.dateNaissance;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Personne_BIU
BEFORE INSERT OR UPDATE ON personnes

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Personne_TAPIs.vg_personnes
 	-- from personnes ;
END;
;
/
CREATE OR REPLACE TRIGGER Personne_BDR
	BEFORE DELETE ON personnes FOR EACH ROW
	DECLARE
	 	vl_oldrec personnes%ROWTYPE;

	BEGIN

vl_oldrec.num := :OLD.num;
vl_oldrec.Emprunt_effectue_num := :OLD.Emprunt_effectue_num;
vl_oldrec.nom := :OLD.nom;
vl_oldrec.prenom := :OLD.prenom;
vl_oldrec.email := :OLD.email;
vl_oldrec.dateNaissance := :OLD.dateNaissance;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Personne_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Personne_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON personnes
	DECLARE
	BEGIN
		Personne_TAPIs.tree_or_list_loop();
		Personne_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Titre_BIR
	BEFORE INSERT ON titres FOR EACH ROW
	DECLARE
	vl_newrec titres%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Langue_est_num := :NEW.Langue_est_num;
vl_newrec.isbn := :NEW.isbn;
vl_newrec.codeInterne := :NEW.codeInterne;
vl_newrec.libelle := :NEW.libelle;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Titre_TAPIs.autogen_column_ins(vl_newrec);
		Titre_TAPIs.autogen_column(vl_newrec);
		Titre_TAPIs.checktype_column(vl_newrec);
		Titre_TAPIs.uppercase_column(vl_newrec);
		Titre_TAPIs.column_PEA(vl_newrec);
		Titre_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.num := vl_newrec.num;
:NEW.Langue_est_num := vl_newrec.Langue_est_num;
:NEW.isbn := vl_newrec.isbn;
:NEW.codeInterne := vl_newrec.codeInterne;
:NEW.libelle := vl_newrec.libelle;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Titre_BUR
	BEFORE UPDATE ON titres FOR EACH ROW
	DECLARE
	vl_newrec titres%ROWTYPE;
	vl_oldrec titres%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Langue_est_num := :NEW.Langue_est_num;
vl_newrec.isbn := :NEW.isbn;
vl_newrec.codeInterne := :NEW.codeInterne;
vl_newrec.libelle := :NEW.libelle;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
vl_oldrec.Langue_est_num := :OLD.Langue_est_num;
vl_oldrec.isbn := :OLD.isbn;
vl_oldrec.codeInterne := :OLD.codeInterne;
vl_oldrec.libelle := :OLD.libelle;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Titre_TAPIs.autogen_column_upd(vl_newrec);
		Titre_TAPIs.autogen_column(vl_newrec);
		Titre_TAPIs.checktype_column(vl_newrec);
		Titre_TAPIs.uppercase_column(vl_newrec);
		Titre_TAPIs.column_PEA(vl_newrec);
		Titre_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Titre_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.num := vl_newrec.num;
:NEW.Langue_est_num := vl_newrec.Langue_est_num;
:NEW.isbn := vl_newrec.isbn;
:NEW.codeInterne := vl_newrec.codeInterne;
:NEW.libelle := vl_newrec.libelle;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Titre_BIU
BEFORE INSERT OR UPDATE ON titres

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Titre_TAPIs.vg_titres
 	-- from titres ;
END;
;
/
CREATE OR REPLACE TRIGGER Titre_BDR
	BEFORE DELETE ON titres FOR EACH ROW
	DECLARE
	 	vl_oldrec titres%ROWTYPE;

	BEGIN

vl_oldrec.num := :OLD.num;
vl_oldrec.Langue_est_num := :OLD.Langue_est_num;
vl_oldrec.isbn := :OLD.isbn;
vl_oldrec.codeInterne := :OLD.codeInterne;
vl_oldrec.libelle := :OLD.libelle;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Titre_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Titre_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON titres
	DECLARE
	BEGIN
		Titre_TAPIs.tree_or_list_loop();
		Titre_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Ecrire_BIR
	BEFORE INSERT ON Ecrire FOR EACH ROW
	DECLARE
	vl_newrec Ecrire%ROWTYPE;

	BEGIN

vl_newrec.Titre_num := :NEW.Titre_num;
vl_newrec.Personne_num := :NEW.Personne_num;
vl_newrec.estReference := :NEW.estReference;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Ecrire_TAPIs.autogen_column_ins(vl_newrec);
		Ecrire_TAPIs.autogen_column(vl_newrec);
		Ecrire_TAPIs.checktype_column(vl_newrec);
		Ecrire_TAPIs.uppercase_column(vl_newrec);
		Ecrire_TAPIs.column_PEA(vl_newrec);
		Ecrire_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.Titre_num := vl_newrec.Titre_num;
:NEW.Personne_num := vl_newrec.Personne_num;
:NEW.estReference := vl_newrec.estReference;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Ecrire_BUR
	BEFORE UPDATE ON Ecrire FOR EACH ROW
	DECLARE
	vl_newrec Ecrire%ROWTYPE;
	vl_oldrec Ecrire%ROWTYPE;

	BEGIN

vl_newrec.Titre_num := :NEW.Titre_num;
vl_newrec.Personne_num := :NEW.Personne_num;
vl_newrec.estReference := :NEW.estReference;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.Titre_num := :OLD.Titre_num;
vl_oldrec.Personne_num := :OLD.Personne_num;
vl_oldrec.estReference := :OLD.estReference;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Ecrire_TAPIs.autogen_column_upd(vl_newrec);
		Ecrire_TAPIs.autogen_column(vl_newrec);
		Ecrire_TAPIs.checktype_column(vl_newrec);
		Ecrire_TAPIs.uppercase_column(vl_newrec);
		Ecrire_TAPIs.column_PEA(vl_newrec);
		Ecrire_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Ecrire_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.Titre_num := vl_newrec.Titre_num;
:NEW.Personne_num := vl_newrec.Personne_num;
:NEW.estReference := vl_newrec.estReference;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Ecrire_BIU
BEFORE INSERT OR UPDATE ON Ecrire

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Ecrire_TAPIs.vg_Ecrire
 	-- from Ecrire ;
END;
;
/
CREATE OR REPLACE TRIGGER Ecrire_BDR
	BEFORE DELETE ON Ecrire FOR EACH ROW
	DECLARE
	 	vl_oldrec Ecrire%ROWTYPE;

	BEGIN

vl_oldrec.Titre_num := :OLD.Titre_num;
vl_oldrec.Personne_num := :OLD.Personne_num;
vl_oldrec.estReference := :OLD.estReference;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Ecrire_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Ecrire_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON Ecrire
	DECLARE
	BEGIN
		Ecrire_TAPIs.tree_or_list_loop();
		Ecrire_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Reserv_BIR
	BEFORE INSERT ON reservations FOR EACH ROW
	DECLARE
	vl_newrec reservations%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Personne_membre_num := :NEW.Personne_membre_num;
vl_newrec.Titre_pour_num := :NEW.Titre_pour_num;
vl_newrec.dateHeureReservation := :NEW.dateHeureReservation;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Reserv_TAPIs.autogen_column_ins(vl_newrec);
		Reserv_TAPIs.autogen_column(vl_newrec);
		Reserv_TAPIs.checktype_column(vl_newrec);
		Reserv_TAPIs.uppercase_column(vl_newrec);
		Reserv_TAPIs.column_PEA(vl_newrec);
		Reserv_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.num := vl_newrec.num;
:NEW.Personne_membre_num := vl_newrec.Personne_membre_num;
:NEW.Titre_pour_num := vl_newrec.Titre_pour_num;
:NEW.dateHeureReservation := vl_newrec.dateHeureReservation;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Reserv_BUR
	BEFORE UPDATE ON reservations FOR EACH ROW
	DECLARE
	vl_newrec reservations%ROWTYPE;
	vl_oldrec reservations%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Personne_membre_num := :NEW.Personne_membre_num;
vl_newrec.Titre_pour_num := :NEW.Titre_pour_num;
vl_newrec.dateHeureReservation := :NEW.dateHeureReservation;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
vl_oldrec.Personne_membre_num := :OLD.Personne_membre_num;
vl_oldrec.Titre_pour_num := :OLD.Titre_pour_num;
vl_oldrec.dateHeureReservation := :OLD.dateHeureReservation;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Reserv_TAPIs.autogen_column_upd(vl_newrec);
		Reserv_TAPIs.autogen_column(vl_newrec);
		Reserv_TAPIs.checktype_column(vl_newrec);
		Reserv_TAPIs.uppercase_column(vl_newrec);
		Reserv_TAPIs.column_PEA(vl_newrec);
		Reserv_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Reserv_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.num := vl_newrec.num;
:NEW.Personne_membre_num := vl_newrec.Personne_membre_num;
:NEW.Titre_pour_num := vl_newrec.Titre_pour_num;
:NEW.dateHeureReservation := vl_newrec.dateHeureReservation;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Reserv_BIU
BEFORE INSERT OR UPDATE ON reservations

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Reserv_TAPIs.vg_reservations
 	-- from reservations ;
END;
;
/
CREATE OR REPLACE TRIGGER Reserv_BDR
	BEFORE DELETE ON reservations FOR EACH ROW
	DECLARE
	 	vl_oldrec reservations%ROWTYPE;

	BEGIN

vl_oldrec.num := :OLD.num;
vl_oldrec.Personne_membre_num := :OLD.Personne_membre_num;
vl_oldrec.Titre_pour_num := :OLD.Titre_pour_num;
vl_oldrec.dateHeureReservation := :OLD.dateHeureReservation;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Reserv_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Reserv_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON reservations
	DECLARE
	BEGIN
		Reserv_TAPIs.tree_or_list_loop();
		Reserv_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Langue_BIR
	BEFORE INSERT ON langues FOR EACH ROW
	DECLARE
	vl_newrec langues%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.libelle := :NEW.libelle;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Langue_TAPIs.autogen_column_ins(vl_newrec);
		Langue_TAPIs.autogen_column(vl_newrec);
		Langue_TAPIs.checktype_column(vl_newrec);
		Langue_TAPIs.uppercase_column(vl_newrec);
		Langue_TAPIs.column_PEA(vl_newrec);
		Langue_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.num := vl_newrec.num;
:NEW.libelle := vl_newrec.libelle;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Langue_BUR
	BEFORE UPDATE ON langues FOR EACH ROW
	DECLARE
	vl_newrec langues%ROWTYPE;
	vl_oldrec langues%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.libelle := :NEW.libelle;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
vl_oldrec.libelle := :OLD.libelle;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Langue_TAPIs.autogen_column_upd(vl_newrec);
		Langue_TAPIs.autogen_column(vl_newrec);
		Langue_TAPIs.checktype_column(vl_newrec);
		Langue_TAPIs.uppercase_column(vl_newrec);
		Langue_TAPIs.column_PEA(vl_newrec);
		Langue_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Langue_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.num := vl_newrec.num;
:NEW.libelle := vl_newrec.libelle;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Langue_BIU
BEFORE INSERT OR UPDATE ON langues

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Langue_TAPIs.vg_langues
 	-- from langues ;
END;
;
/
CREATE OR REPLACE TRIGGER Langue_BDR
	BEFORE DELETE ON langues FOR EACH ROW
	DECLARE
	 	vl_oldrec langues%ROWTYPE;

	BEGIN

vl_oldrec.num := :OLD.num;
vl_oldrec.libelle := :OLD.libelle;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Langue_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Langue_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON langues
	DECLARE
	BEGIN
		Langue_TAPIs.tree_or_list_loop();
		Langue_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Emprunt_BIR
	BEFORE INSERT ON emprunts FOR EACH ROW
	DECLARE
	vl_newrec emprunts%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Titre_exemplaire_num := :NEW.Titre_exemplaire_num;
vl_newrec.Ouvrage_concerne_numdep := :NEW.Ouvrage_concerne_numdep;
vl_newrec.dateEmprunt := :NEW.dateEmprunt;
vl_newrec.dateRetourPrevu := :NEW.dateRetourPrevu;
vl_newrec.dateRetourEffectif := :NEW.dateRetourEffectif;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Emprunt_TAPIs.autogen_column_ins(vl_newrec);
		Emprunt_TAPIs.autogen_column(vl_newrec);
		Emprunt_TAPIs.checktype_column(vl_newrec);
		Emprunt_TAPIs.uppercase_column(vl_newrec);
		Emprunt_TAPIs.column_PEA(vl_newrec);
		Emprunt_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.num := vl_newrec.num;
:NEW.Titre_exemplaire_num := vl_newrec.Titre_exemplaire_num;
:NEW.Ouvrage_concerne_numdep := vl_newrec.Ouvrage_concerne_numdep;
:NEW.dateEmprunt := vl_newrec.dateEmprunt;
:NEW.dateRetourPrevu := vl_newrec.dateRetourPrevu;
:NEW.dateRetourEffectif := vl_newrec.dateRetourEffectif;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Emprunt_BUR
	BEFORE UPDATE ON emprunts FOR EACH ROW
	DECLARE
	vl_newrec emprunts%ROWTYPE;
	vl_oldrec emprunts%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
vl_newrec.Titre_exemplaire_num := :NEW.Titre_exemplaire_num;
vl_newrec.Ouvrage_concerne_numdep := :NEW.Ouvrage_concerne_numdep;
vl_newrec.dateEmprunt := :NEW.dateEmprunt;
vl_newrec.dateRetourPrevu := :NEW.dateRetourPrevu;
vl_newrec.dateRetourEffectif := :NEW.dateRetourEffectif;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
vl_oldrec.Titre_exemplaire_num := :OLD.Titre_exemplaire_num;
vl_oldrec.Ouvrage_concerne_numdep := :OLD.Ouvrage_concerne_numdep;
vl_oldrec.dateEmprunt := :OLD.dateEmprunt;
vl_oldrec.dateRetourPrevu := :OLD.dateRetourPrevu;
vl_oldrec.dateRetourEffectif := :OLD.dateRetourEffectif;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Emprunt_TAPIs.autogen_column_upd(vl_newrec);
		Emprunt_TAPIs.autogen_column(vl_newrec);
		Emprunt_TAPIs.checktype_column(vl_newrec);
		Emprunt_TAPIs.uppercase_column(vl_newrec);
		Emprunt_TAPIs.column_PEA(vl_newrec);
		Emprunt_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Emprunt_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.num := vl_newrec.num;
:NEW.Titre_exemplaire_num := vl_newrec.Titre_exemplaire_num;
:NEW.Ouvrage_concerne_numdep := vl_newrec.Ouvrage_concerne_numdep;
:NEW.dateEmprunt := vl_newrec.dateEmprunt;
:NEW.dateRetourPrevu := vl_newrec.dateRetourPrevu;
:NEW.dateRetourEffectif := vl_newrec.dateRetourEffectif;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Emprunt_BIU
BEFORE INSERT OR UPDATE ON emprunts

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Emprunt_TAPIs.vg_emprunts
 	-- from emprunts ;
END;
;
/
CREATE OR REPLACE TRIGGER Emprunt_BDR
	BEFORE DELETE ON emprunts FOR EACH ROW
	DECLARE
	 	vl_oldrec emprunts%ROWTYPE;

	BEGIN

vl_oldrec.num := :OLD.num;
vl_oldrec.Titre_exemplaire_num := :OLD.Titre_exemplaire_num;
vl_oldrec.Ouvrage_concerne_numdep := :OLD.Ouvrage_concerne_numdep;
vl_oldrec.dateEmprunt := :OLD.dateEmprunt;
vl_oldrec.dateRetourPrevu := :OLD.dateRetourPrevu;
vl_oldrec.dateRetourEffectif := :OLD.dateRetourEffectif;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Emprunt_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Emprunt_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON emprunts
	DECLARE
	BEGIN
		Emprunt_TAPIs.tree_or_list_loop();
		Emprunt_TAPIs.tree_or_list_onlyone();
	END;
;
/
CREATE OR REPLACE TRIGGER Ouvrage_BIR
	BEFORE INSERT ON ouvrages FOR EACH ROW
	DECLARE
	vl_newrec ouvrages%ROWTYPE;

	BEGIN

vl_newrec.Titre_exemplaire_num := :NEW.Titre_exemplaire_num;
vl_newrec.numdep := :NEW.numdep;
vl_newrec.numeroReference := :NEW.numeroReference;
vl_newrec.dateAchat := :NEW.dateAchat;
vl_newrec.prixAchat := :NEW.prixAchat;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;
		Ouvrage_TAPIs.autogen_column_ins(vl_newrec);
		Ouvrage_TAPIs.autogen_column(vl_newrec);
		Ouvrage_TAPIs.checktype_column(vl_newrec);
		Ouvrage_TAPIs.uppercase_column(vl_newrec);
		Ouvrage_TAPIs.column_PEA(vl_newrec);
		Ouvrage_TAPIs.ins_jn(vl_newrec, 'INS');

:NEW.Titre_exemplaire_num := vl_newrec.Titre_exemplaire_num;
:NEW.numdep := vl_newrec.numdep;
:NEW.numeroReference := vl_newrec.numeroReference;
:NEW.dateAchat := vl_newrec.dateAchat;
:NEW.prixAchat := vl_newrec.prixAchat;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Ouvrage_BUR
	BEFORE UPDATE ON ouvrages FOR EACH ROW
	DECLARE
	vl_newrec ouvrages%ROWTYPE;
	vl_oldrec ouvrages%ROWTYPE;

	BEGIN

vl_newrec.Titre_exemplaire_num := :NEW.Titre_exemplaire_num;
vl_newrec.numdep := :NEW.numdep;
vl_newrec.numeroReference := :NEW.numeroReference;
vl_newrec.dateAchat := :NEW.dateAchat;
vl_newrec.prixAchat := :NEW.prixAchat;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.Titre_exemplaire_num := :OLD.Titre_exemplaire_num;
vl_oldrec.numdep := :OLD.numdep;
vl_oldrec.numeroReference := :OLD.numeroReference;
vl_oldrec.dateAchat := :OLD.dateAchat;
vl_oldrec.prixAchat := :OLD.prixAchat;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Ouvrage_TAPIs.autogen_column_upd(vl_newrec);
		Ouvrage_TAPIs.autogen_column(vl_newrec);
		Ouvrage_TAPIs.checktype_column(vl_newrec);
		Ouvrage_TAPIs.uppercase_column(vl_newrec);
		Ouvrage_TAPIs.column_PEA(vl_newrec);
		Ouvrage_TAPIs.frozen_column(vl_newrec, vl_oldrec);
		Ouvrage_TAPIs.ins_jn(vl_newrec, 'UPD');

:NEW.Titre_exemplaire_num := vl_newrec.Titre_exemplaire_num;
:NEW.numdep := vl_newrec.numdep;
:NEW.numeroReference := vl_newrec.numeroReference;
:NEW.dateAchat := vl_newrec.dateAchat;
:NEW.prixAchat := vl_newrec.prixAchat;
:NEW.ajUser := vl_newrec.ajUser;
:NEW.ajDate := vl_newrec.ajDate;
:NEW.moUser := vl_newrec.moUser;
:NEW.moDate := vl_newrec.moDate;
	END;
;
/
CREATE OR REPLACE TRIGGER Ouvrage_BIU
BEFORE INSERT OR UPDATE ON ouvrages

BEGIN

	NULL;
	-- Seulement si nécessaire!
 	-- select * bulk collect into Ouvrage_TAPIs.vg_ouvrages
 	-- from ouvrages ;
END;
;
/
CREATE OR REPLACE TRIGGER Ouvrage_BDR
	BEFORE DELETE ON ouvrages FOR EACH ROW
	DECLARE
	 	vl_oldrec ouvrages%ROWTYPE;

	BEGIN

vl_oldrec.Titre_exemplaire_num := :OLD.Titre_exemplaire_num;
vl_oldrec.numdep := :OLD.numdep;
vl_oldrec.numeroReference := :OLD.numeroReference;
vl_oldrec.dateAchat := :OLD.dateAchat;
vl_oldrec.prixAchat := :OLD.prixAchat;
vl_oldrec.ajUser := :OLD.ajUser;
vl_oldrec.ajDate := :OLD.ajDate;
vl_oldrec.moUser := :OLD.moUser;
vl_oldrec.moDate := :OLD.moDate;
		Ouvrage_TAPIs.ins_jn(vl_oldrec, 'DEL');
	END;
;
/
CREATE OR REPLACE TRIGGER Ouvrage_AIUD
	AFTER INSERT OR UPDATE OR DELETE ON ouvrages
	DECLARE
	BEGIN
		Ouvrage_TAPIs.tree_or_list_loop();
		Ouvrage_TAPIs.tree_or_list_onlyone();
	END;
;
/
