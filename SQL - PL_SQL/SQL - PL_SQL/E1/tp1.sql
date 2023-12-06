
DROP TABLE EMPLOYE;
DROP TABLE SERVICE;

CREATE TABLE SERVICE
(
SerNo integer CONSTRAINT pk_SERVICE PRIMARY KEY,
Nom varchar(50),
Lieu varchar(50),
NbEmployes integer DEFAULT 0
);

CREATE TABLE EMPLOYE
(EmpNo integer CONSTRAINT pk_EMPLOYE PRIMARY KEY,
Nom varchar(25) CONSTRAINT nEmp_connu NOT NULL,
Prenom varchar(25) CONSTRAINT pEmp_connu NOT NULL,
Fonction varchar(25) CONSTRAINT f_valide CHECK(Fonction IN('Président','Gérant','Secrétaire','Vendeur')),
Chef integer CONSTRAINT fk_EMPLOYE REFERENCES EMPLOYE,
DateEmbauche date CONSTRAINT d_connu NOT NULL,
Salaire float DEFAULT 0,
Commission number(8,2),
SerNo integer REFERENCES SERVICE ON DELETE CASCADE,
CONSTRAINT unicite UNIQUE(Nom,Prenom)
);
