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
