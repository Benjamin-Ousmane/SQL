SET search_path = TP3;
INSERT INTO Clinique VALUES
	('CLIN1', '693 Rue Germaine-Guevremont', 'Montreal', 'QC', 'H4N3L1', '5143334176', '514350987', 'Clinique Germaine', '111'),
	('CLIN2', '154 Av Ballantyne', 'Montreal', 'QC', 'H4X2C1', '5144864374', '5147396747', 'Clinique Ballantyne', '112'),
	('CLIN3', '2828 Av Willowdale', 'Montreal', 'QC', 'H3T1H5', '5147313795', '5149397087', 'Clinique Willowdale', '113');
	
INSERT INTO Personnel VALUES
	('111', 'Maro Azizi', '11807 Grenet Street Montreal QC H4J 2H9', '5143310383', '1999-10-06', '309590271', 'M', 'Gestionnaire', 120000, 'CLIN1'),
	('112', 'Jean Paul Sartre', '5555 Dudemaine Montréal QC H4J 1P2', '5147458465', '1950-01-01', '335081154', 'M', 'Gestionnaire', 120000, 'CLIN2'),
	('113', 'Pauline Dupuis','1445 Fort Montreal QC H3H 2C3', '5149335584', '1995-01-02', '458374006', 'F', 'Gestionnaire', 120000, 'CLIN3'),
	('114', 'John Dubois', '251 Milton Montreal QC H2X 1V7', '5142841218', '1980-04-06', '258321074', 'M', 'Personnel entretien', 35000, 'CLIN1'),
	('115', 'Jean Tremblay', '4400 West Hill Montreal QC H4B 2Z5', '5144835242', '1994-05-14', '460039357', 'M', 'Veterinaire', 80000, 'CLIN1'),
	('116', 'Lola Maillard', '3780 Barclay Montreal QC H3S 1K7', '5147378002', '1992-02-14', '456412980', 'F', 'Veterinaire', 85000, 'CLIN2'),
	('117', 'Marie Joelle', '5620 de Salaberry Montreal QC H4J 1J7', '5143311392', '1989-03-01', '596830695', 'F', 'Veterinaire', 75000, 'CLIN3'),
	('118', 'Aya Zeghaida', '3800 Bouchette Montreal QC H3S 1J2', '4383808235', '1985-08-20', '137798120', 'F', 'Secretaire', 35000, 'CLIN3');
	
INSERT INTO ProprietaireAnimal VALUES
	('000', 'Curtis Lblayes', '3970 Plamondon Montreal QC H3S 1M2', '5147370988', 'CLIN1'),
	('001', 'Marco Reus', '1400 Cr Merit Montreal QC H3P 3N6', '5147375304', 'CLIN1'),
	('002', 'Garry Kasparov', '7905 Mountain Sights Montreal QC H4P 2B1', '5147379745', 'CLIN2'),
	('003', 'Bobby Fisher', '4000 Bannantyne Montreal QC H4G 3H4', '5147626422', 'CLIN3'),
	('004', 'Mikhael Tal', '2300 Gold Montreal QC H4M 1S4 ', '5147442597', 'CLIN3');

INSERT INTO Animal VALUES
	('011', 'Chipo', 'Chat', 'Siamois', 50, 25, 'en surpoids', '2018-02-14', '2018-02-20', 'Vivant', 'CLIN1','000'),
	('012', 'Rex', 'Chien', 'Berger Allemand', 70, 40, 'Agite', '2017-05-14', '2018-10-10', 'Vivant', 'CLIN1', '000'),
	('013', 'Max', 'Chien', 'Labradore', 60, 35, 'Gentil', '2020-01-01', '2020-03-01', 'Vivant', 'CLIN1', '001'),
	('016', 'Miaou', 'Chat', 'Bengal', 10, 25, 'Curieux', '2005-02-12', '2005-05-12', 'Decede', 'CLIN1','000'),
	('011', 'Alpha', 'Chat', 'Persant', 45, 15, 'Docile', '2005-05-12', '2005-05-12', 'Decede', 'CLIN2','002'),
	('014', 'Alpha', 'Chat', 'Sphynx', 25, 5, 'Tres petite', '2019-04-20', '2019-05-20', 'Vivant', 'CLIN3', '003'),
	('015', 'Rex', 'Chien', 'Rottweiler', 100, 50, 'Costaud', '2005-05-14', '2015-05-14', 'Vivant', 'CLIN3', '004');

INSERT INTO Examen VALUES
	('25', '2021-04-20', '15:00:00', 'Patte casse', '011', 'CLIN1', '115'),
	('26', '2021-02-02', '12:00:00', 'Vaccin', '012', 'CLIN1', '115'),
	('27', '2021-01-02', '13:00:00', 'Vaccin', '013', 'CLIN1', '115'),
	('28', '2021-01-02', '08:00:00', 'Grippe', '014', 'CLIN3', '117'),
	('29', '2021-04-03', '10:00:00', 'Examen Annuelle', '011', 'CLIN1', '115'),
	('30', '2021-03-01', '16:00:00', 'Examen Annuelle', '014', 'CLIN3', '117'),
	('31', '2021-01-17', '09:00:00', 'Chiurgie', '015', 'CLIN3', '117');
	
INSERT INTO Traitement VALUES
	('T110', 'Traitement à la Pénicilline', 50),
	('T112', 'Vaccination contre la grippe', 70),
	('T111', 'Examen de base', 25),
	('T113', 'Antibiotiques', 55);
	
INSERT INTO ExamenTraitement VALUES
	(2, '2021-04-20', '2021-05-20', '25', 'T113'),
	(1, '2021-02-02', '2021-02-22', '26', 'T112'),
	(1, '2021-01-02', '2021-01-02', '27', 'T112'),
	(2, '2021-01-02', '2021-08-02', '28', 'T113'),
	(1, '2021-04-03', '2021-04-03', '29', 'T111'),
	(1, '2021-03-01', '2021-03-01', '30', 'T111'),
	(3, '2021-01-17', '2021-03-17', '31', 'T113');