DROP DATABASE IF EXISTS online_bus_rezervacija;
CREATE DATABASE online_bus_rezervacija;
USE online_bus_rezervacija;


DROP TABLE IF EXISTS tvrtka_prijevoznik;
CREATE TABLE tvrtka_prijevoznik(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ime_prijevoznika VARCHAR(20)

);



DROP TABLE IF EXISTS kolodvor; 
CREATE TABLE kolodvor(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ime VARCHAR(32) NOT NULL

    );
    
DROP TABLE IF EXISTS  tvrtka_kolodvor; /*veza izmedju tvrtke i kolodvora*/
CREATE TABLE tvrtka_kolodvor(
	id_kolodvor INTEGER NOT NULL,
	id_tvrtka_prijevoznik INTEGER NOT NULL,
	FOREIGN KEY (id_kolodvor) REFERENCES kolodvor (id),
	FOREIGN KEY (id_tvrtka_prijevoznik) REFERENCES tvrtka_prijevoznik (id)
      
    );
    
DROP TABLE IF EXISTS radno_vrijeme;
CREATE TABLE radno_vrijeme(
	id	INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_kolodvor INTEGER NOT NULL,
	dan VARCHAR(12),
    pocetak VARCHAR(5),
    kraj VARCHAR(5),
    FOREIGN KEY (id_kolodvor) REFERENCES kolodvor (id)

);

DROP TABLE IF EXISTS bus;
CREATE TABLE bus(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_tvrtka_prijevoznik INTEGER NOT NULL,
	registracija VARCHAR(32) NOT NULL,
	broj_busa VARCHAR(3) NOT NULL,
	broj_sjedala_busa VARCHAR(3) NOT NULL,
    FOREIGN KEY (id_tvrtka_prijevoznik)  REFERENCES tvrtka_prijevoznik (id)
);

DROP TABLE IF EXISTS kupac;
CREATE TABLE kupac(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_kolodvor INTEGER,
	ime VARCHAR(32) NOT NULL,
	prezime VARCHAR(32) NOT NULL,
	broj_telefona VARCHAR(16) NOT NULL UNIQUE,
	email VARCHAR(64) NOT NULL UNIQUE,
	FOREIGN KEY (id_kolodvor) REFERENCES kolodvor (id)
);

DROP TABLE IF EXISTS vozac;
CREATE TABLE vozac(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_bus INTEGER,
	ime VARCHAR(32) NOT NULL,
	prezime VARCHAR(32) NOT NULL,
    FOREIGN KEY (id_bus) REFERENCES bus (id)
	
);

DROP TABLE IF EXISTS rezervacija;
CREATE TABLE rezervacija(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_kolodvor INTEGER,
    id_kupac INTEGER,
    broj_rezervacije VARCHAR(10),
	datum_rezervacije DATETIME NOT NULL,
	/*povratna_informacija VARCHAR (64) NOT NULL,*/
    FOREIGN KEY (id_kolodvor) REFERENCES kolodvor (id),
    FOREIGN KEY (id_kupac) REFERENCES kupac (id)
); 

DROP TABLE IF EXISTS rezervacija_stavka;
CREATE TABLE rezervacija_stavka(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_rezervacija INTEGER NOT NULL,
	id_bus INTEGER NOT NULL,
    broj_sjedala VARCHAR(2),
	FOREIGN KEY (id_bus) REFERENCES bus (id),
    FOREIGN KEY (id_rezervacija) REFERENCES rezervacija (id)
     );
     
DROP TABLE IF EXISTS karta;
CREATE TABLE karta(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_rezervacija INTEGER,
    FOREIGN KEY (id_rezervacija) REFERENCES rezervacija (id)
);

DROP TABLE IF EXISTS racun;
CREATE TABLE racun(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_rezervacija INTEGER NOT NULL,
    id_kupac INTEGER NOT NULL,
	datum DATETIME NOT NULL,
    nacin_placanja VARCHAR(10),
	FOREIGN KEY (id_rezervacija) REFERENCES rezervacija (id),
	FOREIGN KEY (id_kupac) REFERENCES kupac (id)

);

DROP TABLE IF EXISTS racun_stavke;
CREATE TABLE racun_stavke(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_racun INTEGER NOT NULL,
	artikl TEXT,
	iznos DECIMAL(9,2),
	popust DECIMAL(4,2),
	pdv DECIMAL(4,2),
	ukupno DECIMAL(9,2),
    FOREIGN KEY (id_racun) REFERENCES racun (id)
);

DROP TABLE IF EXISTS raspored_putovanja;
CREATE TABLE raspored_putovanja(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_bus INTEGER,
	datum_putovanja DATE,
	pocetak_mjesta_putovanja VARCHAR(32) NOT NULL,
	destinacija VARCHAR(32) NOT NULL,
    FOREIGN KEY (id_bus) REFERENCES bus (id)
);

DROP TABLE IF EXISTS prtljaga;
CREATE TABLE prtljaga(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_bus INTEGER,
	tezina_prtljage_kilogrami VARCHAR(2) NOT NULL,
	cijena_prtljage NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (id_bus) REFERENCES bus (id)
);



INSERT INTO tvrtka_prijevoznik VALUES 	(1,'Arriva'), 
					(2,'Flixbus'),
					(3,'Čagalj tours'),	
					(4,'Brioni'),
					(5,'Čazmatrans'),
					(6,'Rudi express'),
					(7,'Slavonija bus'),
					(8,'Vincek'),
					(9,'Croatia Bus'),
					(10,'Ines tours'),
					(11,'Autotrans'),
					(12,'APP'),
					(13,'AP Varaždin'),
					(14,'Adriana Cavtat');	
                                        
INSERT INTO kolodvor VALUES (15,'Poreč');

INSERT INTO radno_vrijeme VALUES(16,15,'Ponedjeljak',05,22),
								(17,15,'Utorak',05,22),
                                (18,15,'Srijeda',05,22),
                                (19,15,'Četvrtak',05,22),
                                (20,15,'Petak',05,22),
                                (21,15,'Subota',05,22),
                                (22,15,'Nedjelja',05,18);
							
INSERT INTO bus VALUES  (23,1,'ZG-1234-AB',1,60),
			(24,2,'ZG-0983-GF',2,50),
			(25,3,'KA-1525-GH',3,35),
		        (26,4,'PU-3845-CD',4,59),
			(27,5,'VU-4644-ZB',5,40),
			(28,6,'VA-0434-KL',6,45),
			(29,7,'RI-9834-PO',7,45),
			30,8,'DJ-0295-PE',8,55),
			(31,9,'OS-4535-DE',9,55),
			(32,10,'DU-3453-TR',10,59),
			(33,11,'GS-9860-LC',11,35),
			(34,12,'DA-5427-NM',12,40),
			(35,13,'SB-3453-FR',13,40),
			(36,14,'VŽ-6434-IU',14,59);
                        
INSERT INTO kupac VALUES (37,15,'Andrea','Horvatović',091456789,'ahorvat3@gmail.com'),
			 (38,15,'Željko','Matošević',095432452,'matosevicc@gmail.com'),
			 (39,15,'Matea','Čelik',091421545,'celic344@gmail.com'),
                         (40,15,'Ana','Babić',091111249,'babo90@gmail.com'),
                         (41,15,'Nick','Novak',091443434,'novak99@gmail.com'),
                         (42,15,'Julia','Knez',091004334,'knezjul@gmail.com'),
                         (43,15,'Mateo','Vuković',093255439,'vukov123@gmail.com'),
                         (44,15,'Ivan','Bašić',0914244453,'basicc33c@gmail.com'),
                         (45,15,'Marija','Lončar',091023054,'loncimar45@gmail.com'),
                         (46,15,'Sanja','Novosel',090238482,'selnovsanja12@gmail.com'),
                         (47,15,'Tanja','Tadić',0939838842,'ttadic@gmail.com'),
                         (48,15,'Pero','Muller',095342445,'mullerpero21@gmail.com'),
                         (49,15,'Milan','Jović',091234342,'milanjov45@gmail.com'),
                         (50,15,'Andrej','Geppert',0910234789,'geppertandro12@gmail.com');

INSERT INTO vozac VALUES (51,23,'Matko','Bosek'),
			 (52,24,'Đenis','Umiljenović'),
                         (53,25,'Marijan','Kaštela'),
                         (54,26,'Laura','Delać'),
                         (55,27,'Dragana','Straga'),
                         (56,28,'Dragan','Pintarić'),
                         (57,29,'Petar','Ladan'),
                         (58,30,'Zrinko','Vuleša'),
                         (59,31,'Oliver','Boroša'),
                         (60,32,'Željko','Lovrić'),
                         (61,33,'Ivan','Kokot'),
                         (62,34,'Mateo','Krmek'),
                         (63,35,'Bepo','Mohorić'),
                         (64,36,'Mauro','Pavličić');
                         
INSERT INTO rezervacija VALUES (65,15,38,1000-0001,STR_TO_DATE('12.05.2022.', '%d.%m.%Y.')),
			       (66,15,38,1000-0002,STR_TO_DATE('02.03.2022.', '%d.%m.%Y.')),
                               (67,15,39,1000-0003,STR_TO_DATE('15.12.2021.', '%d.%m.%Y.')),
                               (68,15,41,1000-0005,STR_TO_DATE('19.10.2021.', '%d.%m.%Y.')),
                               (69,15,42,1000-0006,STR_TO_DATE('04.10.2021.', '%d.%m.%Y.')),
                               (70,15,43,1000-0007,STR_TO_DATE('13.6.2022.', '%d.%m.%Y.')),
                               (71,15,44,1000-0008,STR_TO_DATE('02.7.2021.', '%d.%m.%Y.')),
                               (72,15,38,1000-0009,STR_TO_DATE('02.8.2022.', '%d.%m.%Y.')),
                               (73,15,46,1000-0010,STR_TO_DATE('02.9.2021.', '%d.%m.%Y.')),
                               (74,15,38,1000-0011,STR_TO_DATE('20.1.2022.', '%d.%m.%Y.')),
                               (75,15,48,1000-0012,STR_TO_DATE('14.2.2021.', '%d.%m.%Y.')),
                               (76,15,44,1000-0013,STR_TO_DATE('10.2.2021.', '%d.%m.%Y.')),
                               (77,15,50,1000-0014,STR_TO_DATE('27.3.2021.', '%d.%m.%Y.'));							

INSERT INTO rezervacija_stavka VALUES(78,65,23,2),
									 (79,66,24,1),
									 (80,67,25,2),
									 (81,68,26,4),
								     (82,69,27,2),
									 (83,70,27,1),
								     (84,71,29,4),
									 (85,72,30,2),
									 (86,73,23,2),
									 (87,74,24,1),
									 (88,75,36,1),
									 (89,76,34,1),
									 (90,77,31,2);                       

INSERT INTO karta VALUES(91,65),
						(92,66),
                        (93,67),
                        (94,68),
                        (95,69),
                        (96,70),
                        (97,71),
                        (98,72),
                        (99,73),
                        (100,74),
                        (101,75),
                        (102,76),
                        (103,77);
                        
                        
INSERT INTO racun VALUES(104,65,38,STR_TO_DATE('12.05.2022.', '%d.%m.%Y.'),'kartica'),
						(105,66,38,STR_TO_DATE('02.03.2022.', '%d.%m.%Y.'),'kartica'),
                        (106,67,39,STR_TO_DATE('15.12.2021.', '%d.%m.%Y.'),'kartica'),
                        (107,68,41,STR_TO_DATE('19.10.2021.', '%d.%m.%Y.'),'kartica'),
                        (108,69,42,STR_TO_DATE('04.10.2021.', '%d.%m.%Y.'),'gotovina'),
                        (109,70,43,STR_TO_DATE('13.6.2022.', '%d.%m.%Y.'),'gotovina'),
                        (110,71,44,STR_TO_DATE('02.7.2021.', '%d.%m.%Y.'),'gotovina'),
                        (111,72,38,STR_TO_DATE('02.8.2022.', '%d.%m.%Y.'),'kartica'),
                        (112,73,46,STR_TO_DATE('02.9.2021.', '%d.%m.%Y.'),'gotovina'),
                        (113,74,38,STR_TO_DATE('20.1.2022.', '%d.%m.%Y.'),'kartica'),
                        (114,75,40,STR_TO_DATE('14.2.2021.', '%d.%m.%Y.'),'kartica'),
                        (115,76,44,STR_TO_DATE('10.2.2021.', '%d.%m.%Y.'),'kartica'),
                        (116,77,50,STR_TO_DATE('27.3.2021.', '%d.%m.%Y.'),'gotovina');


INSERT INTO racun_stavke VALUES (117,104,'POREČ-RIJEKA',100.00,00.00,05.00,105.00),	
							    (118,105,'POREČ-ZAGREB',194.00, 00.00,05.00,199.00),
								(119,106,'POREČ-PULA',60.00,00.00 ,05.00,65.00),
								(120,107,'POREČ-PAZIN',40.00 , 00.00,05.00,45.00),
								(121,108,'POREČ-PULA',55.00 ,00.00,05.00,60.00),
								(122,109,'POREČ-ZAGREB',194.00 ,00.00,05.00,199.00),
								(123,110,'POREČ-SPLIT',298.00,00.15,05.00,257.55),
								(125,112,'POREČ-POŽEGA',253.00,00.00,05.00,258.00),
								(124,111,'POREČ-OSIJEK',298.00 , 00.00,05.00,303.00),
								(126,113,'POREČ-PULA',60.00,00.00,05.00,65.00),
								(127,114,'POREČ-RIJEKA',100.00,00.05,05.00,95.75),
								(128,115,'POREČ-ROVINJ',40.00 ,00.00,10.00,45.00),
								(129,116,'POREČ-VARAŽDIN',200.00,00.25,05.00,153.75);

INSERT INTO raspored_putovanja VALUES(130,23,STR_TO_DATE('12.05.2022.', '%d.%m.%Y.'),'POREČ' ,'RIJEKA'),
									 (131,24,STR_TO_DATE('02.03.2022.', '%d.%m.%Y.'),'POREČ','ZAGREB'),
                                     (132,25,STR_TO_DATE('15.12.2021.', '%d.%m.%Y.'),'POREČ','PULA'),
                                     (133,26,STR_TO_DATE('19.10.2021.', '%d.%m.%Y.'),'POREČ','PAZIN'),
                                     (134,27,STR_TO_DATE('04.10.2021.', '%d.%m.%Y.'),'POREČ','PULA'),
                                     (135,28,STR_TO_DATE('13.6.2022.', '%d.%m.%Y.'),'POREČ','ZAGREB'),
                                     (136,29,STR_TO_DATE('02.7.2021.', '%d.%m.%Y.'),'POREČ','SPLIT'),
                                     (137,30,STR_TO_DATE('02.8.2022.', '%d.%m.%Y.'),'POREČ','POŽEGA'),
                                     (138,31,STR_TO_DATE('02.9.2021.', '%d.%m.%Y.'),'POREČ','OSIJEK'),
                                     (139,32,STR_TO_DATE('20.1.2022.', '%d.%m.%Y.'),'POREČ','PULA'),
                                     (140,33,STR_TO_DATE('14.2.2021.', '%d.%m.%Y.'),'POREČ','RIJEKA'),
                                     (141,35,STR_TO_DATE('10.2.2021.', '%d.%m.%Y.'),'POREČ','ROVINJ'),
                                     (142,36,STR_TO_DATE('27.3.2021.', '%d.%m.%Y.'),'POREČ','VARAŽDIN');
/* 34 smo maknuli*/


/*po kili cemo uzeti 15kn*/
INSERT INTO prtljaga VALUES(143,23,2,30.00),
							(144,24,3,45.00),
                            (145,25,2,30.00),
                            (146,26,3,45.00),
                            (147,27,2,30.00),
                            (148,28,2,30.00),
                            (149,29,3,45.00),
                            (150,30,1,15.00),
                            (151,31,2,30.00),
                            (152,32,3,45.00),
                            (153,33,3,45.00),
                            (154,35,2,30.00);


