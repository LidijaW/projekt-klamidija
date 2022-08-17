
CREATE DATABASE online_bus_rezervacija;
USE online_bus_rezervacija;

CREATE TABLE bus(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ime VARCHAR(32) NOT NULL,
    broj_busa
	broj_sjedala_busa
    bus_karta
    tip_busa
    kapacitet
    raspored_putovanja_id
);

CREATE TABLE booking(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    kupac_id,
    rezervacija_id
    karta_id,
    datum,
    opis,
    nacin_placanja_id
	raspored_putovanja_id
);

CREATE TABLE kupac(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ime VARCHAR(32) NOT NULL,
    prezime VARCHAR(32) NOT NULL,
    broj_telefona VARCHAR(16) NOT NULL UNIQUE,
	email VARCHAR(64) NOT NULL UNIQUE,

);
CREATE DATABASE rezervacija(
	id,
    kupac_id,
    karta_id,
    datum_rezervacije,

);
CREATE TABLE karta(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    rezervacija_id
    ime_kupca
    prezime-kupca
	email_kupca
    opis_karte
);

CREATE TABLE vozac(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ime
    prezime
    bus_id
    broj_busa_id
    booking_karta_id
);

CREATE TABLE povratna_informacija(
	kupac_id
    ocjena_putovanja
    


);

CREATE TABLE raspored_putovanja(
	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	bus_id
    vozac_id
    datum_putovanja
    pocetak_mjesta_putovanja
	destinacija
);

CREATE DATABASE nacin_placanja(
	id,
    booking_id,
    kupac_id,
    karticno_placanje_id
    datum,
    cijena
    raspored putovanja_id
);
CREATE DATABASE karticno_placanje(
	id;
    paypal,
    mastercard,
    visa,
    american express,
    maestro
);
CREATE DATABASE prtljaga(
	id,
    kupac_id
    tezina_prtljage
    cijena_prtljage
);	

