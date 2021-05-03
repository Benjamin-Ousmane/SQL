SET search_path = TP3;
--Trigger
CREATE Function Save() RETURNS Trigger AS $$
BEGIN
	CREATE TABLE Historique (
		NumeroTraitement VARCHAR NOT NULL,
		DescriptionTraitement VARCHAR NOT NULL,
		Cout integer NOT NULL,
		QuantiteTraitement integer NOT NULL,
		DateDebut DATE NOT NULL,
		DateFin DATE NOT NULL,
		NumeroExamen VARCHAR NOT NULL,
		Date DATE NOT NULL,
		Heure TIME NOT NULL,
		DescriptionExamen VARCHAR NOT NULL,
		NumeroPersonnel VARCHAR NOT NULL
	);
	INSERT INTO Historique SELECT t.*, d.QuantiteTraitement, d.DateDebut, d.DateFin, e.NumeroExamen, e.Date, e.Heure, e.Description, e.NumeroVeterinaire
	FROM Traitement t JOIN ExamenTraitement d using (NumeroTraitement) JOIN Examen e using(NumeroExamen) WHERE e.NumeroAnimal = OLD.NumeroAnimal;
	RETURN OLD;
END; $$
language plpgsql;

CREATE TRIGGER Sauvegarde
BEFORE DELETE ON Animal for each row execute function Save();