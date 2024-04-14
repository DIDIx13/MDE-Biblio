CREATE OR REPLACE TRIGGER Personne_BIR
	BEFORE INSERT ON personnes FOR EACH ROW
	DECLARE
	vl_newrec personnes%ROWTYPE;

	BEGIN

vl_newrec.num := :NEW.num;
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
vl_newrec.nom := :NEW.nom;
vl_newrec.prenom := :NEW.prenom;
vl_newrec.email := :NEW.email;
vl_newrec.dateNaissance := :NEW.dateNaissance;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
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
vl_newrec.isbn := :NEW.isbn;
vl_newrec.codeInterne := :NEW.codeInterne;
vl_newrec.libelle := :NEW.libelle;
vl_newrec.ajUser := :NEW.ajUser;
vl_newrec.ajDate := :NEW.ajDate;
vl_newrec.moUser := :NEW.moUser;
vl_newrec.moDate := :NEW.moDate;

vl_oldrec.num := :OLD.num;
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
