CREATE TABLE Temp(
    Ligne INTEGER PRIMARY KEY NOT NULL,
    Valeur INTEGER
);

CREATE TABLE Action(
    Ligne INTEGER PRIMARY KEY NOT NULL,
    Op VARCHAR(2),
    Nouv_valeur INTEGER,
    Statut VARCHAR(50)
);

