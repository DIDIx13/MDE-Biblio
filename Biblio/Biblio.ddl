CREATE SEQUENCE Titre_SEQPK CACHE 20;
CREATE SEQUENCE Ecrire_SEQPK CACHE 20;
CREATE SEQUENCE Reserv_SEQPK CACHE 20;
ALTER SEQUENCE Personne_SEQPK CACHE 20;
ALTER TABLE DARWIN_AMELI.REGISTRE
   DROP CONSTRAINT FK2_REGISTRE_PERSONNE;
ALTER TABLE DARWIN_AMELI.PERSONNES 
  DROP CONSTRAINT PK_PERSONNE;
ALTER TABLE personnes 
  ADD num number(9) NOT NULL;
ALTER TABLE personnes 
  modify nom varchar2(50);
ALTER TABLE personnes 
  modify prenom varchar2(50);
ALTER TABLE personnes 
  modify email varchar2(120) NULL;
ALTER TABLE personnes 
  ADD dateNaissance date;
ALTER TABLE personnes 
  ADD ajUser varchar2(70);
ALTER TABLE personnes 
  ADD ajDate timestamp(0);
ALTER TABLE personnes 
  ADD moUser varchar2(70);
ALTER TABLE personnes 
  ADD moDate timestamp(0);
ALTER TABLE personnes 
  ADD PRIMARY KEY(num);
CREATE TABLE titres (
  num         number(9) NOT NULL, 
  isbn        varchar2(13) NOT NULL, 
  codeInterne varchar2(15) NOT NULL, 
  libelle     varchar2(100) NOT NULL, 
  ajUser      varchar2(70), 
  ajDate      timestamp(0), 
  moUser      varchar2(70), 
  moDate      timestamp(0), 
  CONSTRAINT PK_Titre 
    PRIMARY KEY (num), 
  CONSTRAINT NID1_Titre_isbn 
    UNIQUE (isbn), 
  CONSTRAINT NID2_Titre_codeInterne 
    UNIQUE (codeInterne), 
  CONSTRAINT Titre_num_DATATYPE 
    CHECK ((num>0)));
CREATE TABLE Ecrire (
  Titre_num    number(9) NOT NULL, 
  Personne_num number(9) NOT NULL, 
  estReference varchar2(1) NOT NULL, 
  ajUser       varchar2(70), 
  ajDate       timestamp(0), 
  moUser       varchar2(70), 
  moDate       timestamp(0), 
  CONSTRAINT PK_Ecrire 
    PRIMARY KEY (Titre_num, 
  Personne_num), 
  CONSTRAINT Ecrire_estReference_DATATYPE 
    CHECK ((estReference = 'Y') OR (estReference = 'N')));
CREATE TABLE reservations (
  num                  number(9) NOT NULL, 
  Personne_membre_num  number(9) NOT NULL, 
  Titre_pour_num       number(9) NOT NULL, 
  dateHeureReservation timestamp(0) NOT NULL, 
  ajUser               varchar2(70), 
  ajDate               timestamp(0), 
  moUser               varchar2(70), 
  moDate               timestamp(0), 
  CONSTRAINT PK_Reserv 
    PRIMARY KEY (num), 
  CONSTRAINT Reserv_num_DATATYPE 
    CHECK ((num>0)));
CREATE TABLE personnes_JN (
  JN_DATETIME   timestamp(0), 
  JN_OPERATION  varchar2(3), 
  JN_USER       varchar2(70), 
  JN_SESSION    varchar2(200), 
  JN_APPL       varchar2(200), 
  JN_NOTES      varchar2(200), 
  num           number(9), 
  nom           varchar2(50), 
  prenom        varchar2(50), 
  email         varchar2(120), 
  dateNaissance date, 
  ajUser        varchar2(70), 
  ajDate        timestamp(0), 
  moUser        varchar2(70), 
  moDate        timestamp(0));
CREATE TABLE titres_JN (
  JN_DATETIME  timestamp(0), 
  JN_OPERATION varchar2(3), 
  JN_USER      varchar2(70), 
  JN_SESSION   varchar2(200), 
  JN_APPL      varchar2(200), 
  JN_NOTES     varchar2(200), 
  num          number(9), 
  isbn         varchar2(13), 
  codeInterne  varchar2(15), 
  libelle      varchar2(100), 
  ajUser       varchar2(70), 
  ajDate       timestamp(0), 
  moUser       varchar2(70), 
  moDate       timestamp(0));
CREATE TABLE Ecrire_JN (
  JN_DATETIME  timestamp(0), 
  JN_OPERATION varchar2(3), 
  JN_USER      varchar2(70), 
  JN_SESSION   varchar2(200), 
  JN_APPL      varchar2(200), 
  JN_NOTES     varchar2(200), 
  Titre_num    number(9), 
  Personne_num number(9), 
  estReference varchar2(1), 
  ajUser       varchar2(70), 
  ajDate       timestamp(0), 
  moUser       varchar2(70), 
  moDate       timestamp(0));
CREATE TABLE reservations_JN (
  JN_DATETIME          timestamp(0), 
  JN_OPERATION         varchar2(3), 
  JN_USER              varchar2(70), 
  JN_SESSION           varchar2(200), 
  JN_APPL              varchar2(200), 
  JN_NOTES             varchar2(200), 
  num                  number(9), 
  Personne_membre_num  number(9), 
  Titre_pour_num       number(9), 
  dateHeureReservation timestamp(0), 
  ajUser               varchar2(70), 
  ajDate               timestamp(0), 
  moUser               varchar2(70), 
  moDate               timestamp(0));
CREATE INDEX FK1_Ecrire_Titre 
  ON Ecrire (Titre_num);
CREATE INDEX FK2_Ecrire_Personne 
  ON Ecrire (Personne_num);
CREATE INDEX FK1_Reserv_Personne_membre 
  ON reservations (Personne_membre_num);
CREATE INDEX FK2_Reserv_Titre_pour 
  ON reservations (Titre_pour_num);
ALTER TABLE reservations ADD CONSTRAINT FK2_Reserv_Titre_pour FOREIGN KEY (Titre_pour_num) REFERENCES titres (num);
ALTER TABLE reservations ADD CONSTRAINT FK1_Reserv_Personne_membre FOREIGN KEY (Personne_membre_num) REFERENCES personnes (num);
ALTER TABLE Ecrire ADD CONSTRAINT FK2_Ecrire_Personne FOREIGN KEY (Personne_num) REFERENCES personnes (num);
ALTER TABLE Ecrire ADD CONSTRAINT FK1_Ecrire_Titre FOREIGN KEY (Titre_num) REFERENCES titres (num);
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
