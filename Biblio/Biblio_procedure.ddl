create or replace PACKAGE UTIL IS
MYTRUE  CONSTANT CHAR := 'Y';
MYFALSE CONSTANT CHAR := 'N';
FUNCTION EQUALORNULL (arg1 IN NUMBER, arg2 IN NUMBER) RETURN VARCHAR2;
FUNCTION GETBOOLEAN(arg IN VARCHAR2) RETURN BOOLEAN;

END;
/
CREATE OR REPLACE PACKAGE BODY UTIL IS
FUNCTION EQUALORNULL (arg1 IN NUMBER, arg2 IN NUMBER) RETURN VARCHAR2 IS
BEGIN
  IF (arg1 = arg2) OR ( (arg1 IS NULL) AND (arg2 IS NULL)) THEN
    RETURN UTIL.MYTRUE;
  ELSE
    RETURN UTIL.MYFALSE;
  END IF;
END;


FUNCTION GETBOOLEAN(arg IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
  IF arg IS NULL THEN 
    RETURN NULL;
  ELSE
    IF arg = 'Y' THEN
      RETURN true;
    ELSE 
      IF arg = 'N' THEN 
        RETURN false;
      ELSE
       raise_application_error(-20001, 'La valeur ' + arg + ' ne peut pas être convertie en un type boolean/logique');
      END IF;
    END IF;
  END IF; 
END;


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Personne_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT personnes%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT personnes%ROWTYPE
						  , pio_oldrec IN OUT personnes%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN personnes%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_personnes  IS TABLE OF personnes%ROWTYPE
INDEX BY PLS_INTEGER;
vg_personnes type_personnes;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Personne_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	IF pio_crtrec.num IS NULL THEN
	SELECT Personne_SEQPK.NEXTVAL
	INTO pio_crtrec.num
	FROM DUAL;
END IF;
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.nom , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.nom , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.nom , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: nom , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: token');
END IF;
IF INSTR( pio_crtrec.nom, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: nom , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: token');
END IF;
IF (INSTR( pio_crtrec.prenom , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.prenom , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.prenom , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: prenom , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: token');
END IF;
IF INSTR( pio_crtrec.prenom, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: prenom , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: token');
END IF;
IF (INSTR( pio_crtrec.email , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.email , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.email , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: email , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: email');
END IF;
IF INSTR( pio_crtrec.email, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: email , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: email');
END IF;
IF INSTR(pio_crtrec.email, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: email , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: email');
END IF;
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: personnes , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT personnes%ROWTYPE,
							pio_oldrec IN OUT personnes%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN personnes%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO personnes_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num

		);
	ELSE
		INSERT INTO personnes_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num
,Emprunt_effectue_num
,nom
,prenom
,email
,dateNaissance
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num
,pi_crtrec.Emprunt_effectue_num
,pi_crtrec.nom
,pi_crtrec.prenom
,pi_crtrec.email
,pi_crtrec.dateNaissance
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Titre_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT titres%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT titres%ROWTYPE
						  , pio_oldrec IN OUT titres%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN titres%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_titres  IS TABLE OF titres%ROWTYPE
INDEX BY PLS_INTEGER;
vg_titres type_titres;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Titre_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	IF pio_crtrec.num IS NULL THEN
	SELECT Titre_SEQPK.NEXTVAL
	INTO pio_crtrec.num
	FROM DUAL;
END IF;
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.isbn , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.isbn , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.isbn , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: isbn , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.isbn, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: isbn , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.isbn, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: isbn , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.codeInterne , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.codeInterne , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.codeInterne , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: codeInterne , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.codeInterne, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: codeInterne , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.codeInterne, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: codeInterne , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.libelle , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.libelle , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.libelle , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: libelle , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: token');
END IF;
IF INSTR( pio_crtrec.libelle, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: libelle , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: token');
END IF;
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: titres , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT titres%ROWTYPE,
							pio_oldrec IN OUT titres%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN titres%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO titres_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num

		);
	ELSE
		INSERT INTO titres_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num
,Langue_est_num
,isbn
,codeInterne
,libelle
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num
,pi_crtrec.Langue_est_num
,pi_crtrec.isbn
,pi_crtrec.codeInterne
,pi_crtrec.libelle
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Ecrire_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT Ecrire%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT Ecrire%ROWTYPE
						  , pio_oldrec IN OUT Ecrire%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN Ecrire%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_Ecrire  IS TABLE OF Ecrire%ROWTYPE
INDEX BY PLS_INTEGER;
vg_Ecrire type_Ecrire;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Ecrire_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	
pio_crtrec.estReference := UPPER(pio_crtrec.estReference);
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: Ecrire , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT Ecrire%ROWTYPE,
							pio_oldrec IN OUT Ecrire%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN Ecrire%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO Ecrire_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,Titre_num
,Personne_num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.Titre_num
,pi_crtrec.Personne_num

		);
	ELSE
		INSERT INTO Ecrire_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,Titre_num
,Personne_num
,estReference
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.Titre_num
,pi_crtrec.Personne_num
,pi_crtrec.estReference
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Reserv_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT reservations%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT reservations%ROWTYPE
						  , pio_oldrec IN OUT reservations%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN reservations%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_reservations  IS TABLE OF reservations%ROWTYPE
INDEX BY PLS_INTEGER;
vg_reservations type_reservations;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Reserv_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	IF pio_crtrec.num IS NULL THEN
	SELECT Reserv_SEQPK.NEXTVAL
	INTO pio_crtrec.num
	FROM DUAL;
END IF;
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: reservations , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT reservations%ROWTYPE,
							pio_oldrec IN OUT reservations%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN reservations%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO reservations_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num

		);
	ELSE
		INSERT INTO reservations_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num
,Personne_membre_num
,Titre_pour_num
,dateHeureReservation
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num
,pi_crtrec.Personne_membre_num
,pi_crtrec.Titre_pour_num
,pi_crtrec.dateHeureReservation
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Langue_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT langues%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT langues%ROWTYPE
						  , pio_oldrec IN OUT langues%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN langues%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_langues  IS TABLE OF langues%ROWTYPE
INDEX BY PLS_INTEGER;
vg_langues type_langues;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Langue_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	IF pio_crtrec.num IS NULL THEN
	SELECT Langue_SEQPK.NEXTVAL
	INTO pio_crtrec.num
	FROM DUAL;
END IF;
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.libelle , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.libelle , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.libelle , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: libelle , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: token');
END IF;
IF INSTR( pio_crtrec.libelle, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: libelle , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: token');
END IF;
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: langues , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT langues%ROWTYPE,
							pio_oldrec IN OUT langues%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN langues%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO langues_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num

		);
	ELSE
		INSERT INTO langues_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num
,libelle
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num
,pi_crtrec.libelle
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Emprunt_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT emprunts%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT emprunts%ROWTYPE
						  , pio_oldrec IN OUT emprunts%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN emprunts%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_emprunts  IS TABLE OF emprunts%ROWTYPE
INDEX BY PLS_INTEGER;
vg_emprunts type_emprunts;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Emprunt_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	IF pio_crtrec.num IS NULL THEN
	SELECT Emprunt_SEQPK.NEXTVAL
	INTO pio_crtrec.num
	FROM DUAL;
END IF;
	
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: emprunts , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT emprunts%ROWTYPE,
							pio_oldrec IN OUT emprunts%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN emprunts%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO emprunts_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num

		);
	ELSE
		INSERT INTO emprunts_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,num
,Titre_exemplaire_num
,Ouvrage_concerne_numdep
,dateEmprunt
,dateRetourPrevu
,dateRetourEffectif
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.num
,pi_crtrec.Titre_exemplaire_num
,pi_crtrec.Ouvrage_concerne_numdep
,pi_crtrec.dateEmprunt
,pi_crtrec.dateRetourPrevu
,pi_crtrec.dateRetourEffectif
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
CREATE OR REPLACE PACKAGE Ouvrage_TAPIs IS
PROCEDURE autogen_column(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE autogen_column_ins(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE autogen_column_upd(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE uppercase_column(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE checktype_column(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE column_PEA(pio_crtrec IN OUT ouvrages%ROWTYPE);
PROCEDURE frozen_column(  pio_newrec IN OUT ouvrages%ROWTYPE
						  , pio_oldrec IN OUT ouvrages%ROWTYPE);
PROCEDURE tree_or_list_loop;
PROCEDURE tree_or_list_onlyone;
PROCEDURE ins_jn(		pi_crtrec IN ouvrages%ROWTYPE
					, 	pi_mode IN VARCHAR2         	);

TYPE type_ouvrages  IS TABLE OF ouvrages%ROWTYPE
INDEX BY PLS_INTEGER;
vg_ouvrages type_ouvrages;

vg_insteadof_call BOOLEAN := FALSE;

END;
/
CREATE OR REPLACE PACKAGE BODY Ouvrage_TAPIs IS


PROCEDURE autogen_column(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
END;

PROCEDURE autogen_column_ins(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	
	IF pio_crtrec.numdep IS NULL THEN
	SELECT NVL(MAX(numdep), 0) + 1
	INTO pio_crtrec.numdep
	FROM ouvrages
	WHERE (1=1)
	
 AND ouvrages.Titre_exemplaire_num = pio_crtrec.Titre_exemplaire_num;
END IF;
	
	
	pio_crtrec.ajUser := USER;
pio_crtrec.ajDate := SYSDATE;
	
END;

PROCEDURE autogen_column_upd(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	pio_crtrec.moUser := USER;
pio_crtrec.moDate := SYSDATE;
END;


PROCEDURE uppercase_column(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE checktype_column(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	
IF (INSTR( pio_crtrec.numeroReference , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.numeroReference , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.numeroReference , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: numeroReference , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.numeroReference, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: numeroReference , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.numeroReference, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: numeroReference , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.ajUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.ajUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: ajUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.ajUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: ajUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.ajUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: ajUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
IF (INSTR( pio_crtrec.moUser , CHR(9)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(10)) > 0) OR 
(INSTR( pio_crtrec.moUser , CHR(13)) > 0) THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: moUser , mpdr.constraint.mess.err.datatype.string , Les caractères de contrôle ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR( pio_crtrec.moUser, '  ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: moUser , mpdr.constraint.mess.err.datatype.token , Deux espaces contigus ou plus ne sont pas autorisés pour une donnée de type: word');
END IF;
IF INSTR(pio_crtrec.moUser, ' ' ) > 0 THEN 
 raise_application_error(-20001, 'Table: ouvrages , Colonne: moUser , mpdr.constraint.mess.err.datatype.word , Les espaces ne sont pas autorisés pour une donnée de type: word');
END IF;
END;

PROCEDURE column_PEA(pio_crtrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	
END;

PROCEDURE frozen_column(	pio_newrec IN OUT ouvrages%ROWTYPE,
							pio_oldrec IN OUT ouvrages%ROWTYPE) IS
BEGIN
	NULL;
	
END;


PROCEDURE tree_or_list_loop IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE tree_or_list_onlyone IS
v_temp NUMBER;
BEGIN
	NULL;
	
END;

PROCEDURE ins_jn(		pi_crtrec IN ouvrages%ROWTYPE
					, 	pi_mode IN VARCHAR2         	) IS

BEGIN
	IF pi_mode = 'DEL' THEN
		INSERT INTO ouvrages_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,Titre_exemplaire_num
,numdep

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.Titre_exemplaire_num
,pi_crtrec.numdep

		);
	ELSE
		INSERT INTO ouvrages_JN 
			(JN_DATETIME
,JN_OPERATION
,JN_USER
,JN_SESSION
,JN_APPL
,JN_NOTES

			,Titre_exemplaire_num
,numdep
,numeroReference
,dateAchat
,prixAchat
,ajUser
,ajDate
,moUser
,moDate

		)
		VALUES 
			(SYSDATE
,pi_mode
,USER
,userenv('sessionid')
,NULL
,NULL

			,pi_crtrec.Titre_exemplaire_num
,pi_crtrec.numdep
,pi_crtrec.numeroReference
,pi_crtrec.dateAchat
,pi_crtrec.prixAchat
,pi_crtrec.ajUser
,pi_crtrec.ajDate
,pi_crtrec.moUser
,pi_crtrec.moDate

		);
	END IF;	
END;	


BEGIN
	NULL;
END;
/
