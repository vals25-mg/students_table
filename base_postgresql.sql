-- Create the database
CREATE DATABASE eleve_major;
\c eleve_major;

-- Create the annee_scolaire table (from MySQL)
CREATE TABLE annee_scolaire (
    id SERIAL PRIMARY KEY,
    annee_debut INTEGER NOT NULL,
    annee_fin INTEGER NOT NULL
);

-- Create the filiere table (from MySQL, for filiere definitions)
CREATE TABLE filiere (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- Create the eleve table (from PostgreSQL)
CREATE TABLE eleve (
    id VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    redoublement INTEGER DEFAULT 0
);

-- Create the inscription table (replacing the PostgreSQL filiere table to avoid naming conflict)
CREATE TABLE inscription (
    id SERIAL PRIMARY KEY,
    id_annee_scolaire INTEGER NOT NULL,
    id_filiere INTEGER NOT NULL,
    id_eleve VARCHAR(10) NOT NULL,
    moyenne DOUBLE PRECISION NOT NULL,
    FOREIGN KEY (id_annee_scolaire) REFERENCES annee_scolaire(id),
    FOREIGN KEY (id_filiere) REFERENCES filiere(id),
    FOREIGN KEY (id_eleve) REFERENCES eleve(id)
);

-- Insert data into annee_scolaire
INSERT INTO annee_scolaire (annee_debut, annee_fin)
VALUES
    (2024, 2025),
    (2025, 2026),
    (2026, 2027);

-- Insert data into filiere
INSERT INTO filiere (nom)
VALUES
    ('Informatique'),
    ('Mathématiques'),
    ('Agronomie');

-- Insert data into eleve
INSERT INTO eleve (id, nom, redoublement)
VALUES
    ('E001', 'Alice', 0),
    ('E002', 'Bob', 1),
    ('E003', 'Charlie', 0),
    ('E004', 'Diana', 0),
    ('E005', 'Ethan', 1),
    ('E006', 'Fiona', 0),
    ('E007', 'George', 0),
    ('E008', 'Hannah', 1),
    ('E009', 'Ian', 0),
    ('E010', 'Jane', 0);

-- Insert data into inscription
INSERT INTO inscription (id_annee_scolaire, id_filiere, id_eleve, moyenne)
VALUES
    (1, 1, 'E001', 15.5),
    (1, 2, 'E002', 12.0),
    (1, 3, 'E003', 14.0),
    (2, 1, 'E004', 16.0),
    (2, 2, 'E005', 11.5),
    (2, 3, 'E006', 13.0),
    (3, 1, 'E007', 14.5),
    (3, 2, 'E008', 10.0),
    (3, 3, 'E009', 15.0),
    (1, 1, 'E010', 13.5);

create or replace view v_inscriptions as
select
    inscription.id,
    inscription.id_eleve,
    eleve.nom,
    eleve.redoublement,
    inscription.id_filiere,
    filiere.nom as filiere_nom,
    annee_scolaire.annee_debut,
    annee_scolaire.annee_fin,
    inscription.moyenne
from inscription
join eleve on inscription.id_eleve = eleve.id
join filiere on inscription.id_filiere = filiere.id
join annee_scolaire on inscription.id_annee_scolaire = annee_scolaire.id;
