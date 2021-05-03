DROP SCHEMA IF EXISTS TP3 Cascade;
CREATE SCHEMA TP3;
SET search_path = TP3; 

CREATE Type Fonction as ENUM ('Veterinaire', 'Gestionnaire', 'Infirmiere', 'Secretaire', 'Personnel entretien');

CREATE Type Etat as ENUM ('Vivant', 'Decede');

CREATE TABLE Clinique (
	NumeroClinique VARCHAR Primary Key,
	Rue VARCHAR NOT NULL,
	Ville VARCHAR NOT NULL,
	Province VARCHAR NOT NULL,
	CodePostale VARCHAR(6) NOT NULL,
	NumeroTelephone VARCHAR NOT NULL,
	NumeroTelecopieur VARCHAR NOT NULL ,
	nomClinique VARCHAR NOT NULL,
	NumeroGestionnaire VARCHAR NOT NULL
);

CREATE TABLE Personnel (
	NumeroPersonnel VARCHAR Primary Key,
	Nom VARCHAR NOT NULL,
	adresse VARCHAR NOT NULL,
	NumeroTelephone VARCHAR NOT NULL,
	DateDeNaissance DATE NOT NULL,
	NAS VARCHAR NOT NULL,
	Sexe VARCHAR(1) NOT NULL,
	Fonction Fonction NOT NULL,
	Salaire integer NOT NULL CHECK (Salaire >0),
	NumeroClinique  VARCHAR NOT NULL REFERENCES Clinique (NumeroClinique) ON DELETE CASCADE
);

CREATE TABLE ProprietaireAnimal (
	NumeroProprietaire VARCHAR NOT NULL,
	Nom VARCHAR NOT NULL,
	Adresse VARCHAR NOT NULL,
	NumeroTelephone VARCHAR NOT NULL,
	NumeroClinique VARCHAR NOT NULL REFERENCES Clinique (NumeroClinique) ON DELETE CASCADE,
	PRIMARY KEY (NumeroProprietaire, NumeroClinique)
);

CREATE TABLE Animal (
	NumeroAnimal VARCHAR NOT NULL,
	Nom VARCHAR NOT NULL,
	TypeAnimal VARCHAR NOT NULL,
	Espece VARCHAR NOT NULL,
	Taille int NOT NULL,
	Poids int NOT NULL,
	Description VARCHAR NOT NULL,
	DateNaissance Date NOT NULL,
	DateInscription DATE NOT NULL CHECK (DateInscription >= DateNaissance),
	Etat Etat NOT NULL,
	NumeroClinique VARCHAR NOT NULL REFERENCES Clinique (NumeroClinique) ON DELETE CASCADE,
	NumeroProprietaire VARCHAR NOT NULL,
	Foreign Key (NumeroProprietaire, NumeroClinique) REFERENCES ProprietaireAnimal ON DELETE CASCADE,
	Primary Key (NumeroAnimal, NumeroClinique)
);

CREATE TABLE Examen (
	NumeroExamen VARCHAR Primary Key,
	Date Date NOT NULL,
	Heure Time NOT NULL,
	Description VARCHAR NOT NULL,
	NumeroAnimal VARCHAR NOT NULL,
	NumeroClinique VARCHAR NOT NULL,
	NumeroVeterinaire VARCHAR NOT NULL REFERENCES Personnel(NumeroPersonnel) ON DELETE CASCADE,
	Foreign Key (NumeroAnimal, NumeroClinique) REFERENCES Animal ON DELETE CASCADE
);

CREATE TABLE Traitement (
	NumeroTraitement VARCHAR Primary Key,
	Description VARCHAR NOT NULL,
	Cout integer NOT NULL
);

CREATE TABLE ExamenTraitement (
	QuantiteTraitement integer NOT NULL,
	DateDebut DATE NOT NULL,
	DateFin Date NOT NULL CHECK (DateFin >= DateDebut) ,
	NumeroExamen VARCHAR NOT NULL REFERENCES Examen(NumeroExamen) ON DELETE CASCADE,
	NumeroTraitement VARCHAR NOT NULL REFERENCES Traitement(NumeroTraitement) ON DELETE CASCADE,
	Primary Key(NumeroExamen, NumeroTraitement)
);

CREATE FUNCTION CheckVeterinaire(VARCHAR, VARCHAR)
RETURNS VARCHAR AS $$
SELECT NumeroPersonnel FROM Personnel  empl WHERE empl.Fonction = 'Veterinaire' AND $1 = empl.NumeroClinique AND $2 = empl.NumeroPersonnel;
$$ LANGUAGE SQL;

CREATE FUNCTION CheckGestionnaire(VARCHAR, VARCHAR)
RETURNS VARCHAR AS $$
SELECT NumeroPersonnel FROM Personnel empl WHERE empl.Fonction = 'Gestionnaire' AND $1 = empl.NumeroClinique AND $2 = empl.NumeroPersonnel;
$$ LANGUAGE SQL;
	
ALTER TABLE Clinique
ADD CONSTRAINT ManagerFK FOREIGN KEY (NumeroGestionnaire) REFERENCES Personnel(NumeroPersonnel)
	ON UPDATE CASCADE
	ON DELETE SET NULL
	DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Clinique
ADD CONSTRAINT CheckGest CHECK (NumeroGestionnaire = CheckGestionnaire(NumeroClinique, NumeroGestionnaire));

ALTER TABLE Examen
ADD CONSTRAINT CheckVet CHECK (NumeroVeterinaire  = CheckVeterinaire(NumeroClinique, NumeroVeterinaire));