DROP TABLE RESULTAT;
DROP TABLE EXAMEN;
DROP TABLE PREREQUIS;
DROP TABLE INSCRIPTION;
DROP TABLE MODULE;
DROP TABLE ETUDIANT;

-- Création des tables 

CREATE TABLE ETUDIANT
(numEtu number CONSTRAINT pk_etudiant PRIMARY KEY,
nom varchar2(40),
prenom varchar2(40), 
datenaiss date, 
moyenne real
);

CREATE TABLE MODULE
(codMod number CONSTRAINT pk_module PRIMARY KEY,
nomMod varchar2(15),
effectifMax number DEFAULT 30,
effectif number DEFAULT 30
);

CREATE TABLE EXAMEN
(codMod number, 
codExam number, 
dateExam date,
CONSTRAINT pk_examen PRIMARY KEY (codMod, codExam),
CONSTRAINT fk_examen FOREIGN KEY (codMod) REFERENCES MODULE(codMod)
);

CREATE TABLE INSCRIPTION
(numEtu number,
codMod number,
dateInsc date default sysdate,
CONSTRAINT pk_inscription PRIMARY KEY (codMod, numEtud),
CONSTRAINT fk_inscription_etudiant FOREIGN KEY (numEtud) REFERENCES ETUDIANT(numEtu),
CONSTRAINT fk_inscription_module FOREIGN KEY (codMod) REFERENCES MODULE
(codMod)
);

CREATE TABLE PREREQUIS
(codMod number,
codModPrereq number,
noteMin number(2) DEFAULT 10 NOT NULL,
CONSTRAINT pk_prerequis PRIMARY KEY (codMod, codModPrereq),
CONSTRAINT fk_prerequis_codmod FOREIGN KEY (codMod) REFERENCES MODULE(codMod),
CONSTRAINT fk_prerequis_codmodprereq FOREIGN KEY (codModPrereq) REFERENCES
MODULE(codMod)
);

CREATE TABLE RESULTAT
(codMod number,
codExam number,
numEtu number,
note number(4, 2),
CONSTRAINT pk_resultat PRIMARY KEY (codMod, numEtu, codExam),
CONSTRAINT fk_resultat_examen FOREIGN KEY (codMod, codExam) REFERENCES EXAMEN (codMod, codExam),
CONSTRAINT fk_resultat_inscription FOREIGN KEY (codMod, numEtu) REFERENCES
INSCRIPTION(codMod,numEtud)
);

-- Insertion des données

INSERT INTO MODULE(codMod, nomMod) VALUES (1, 'Oracle'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (2, 'C++'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (3, 'C'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (4, 'Algo'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (5, 'Merise'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (6, 'PL/SQL Oracle'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (7, 'mySQL'); 
INSERT INTO MODULE(codMod, nomMod) VALUES (8, 'Algo avancee'); 

INSERT INTO PREREQUIS (codMod, codModPrereq) VALUES (1, 5); 
INSERT INTO PREREQUIS (codMod, codModPrereq) VALUES (2, 3); 
INSERT INTO PREREQUIS VALUES (6, 1, 12); 
INSERT INTO PREREQUIS (codMod, codModPrereq) VALUES (6, 5); 
INSERT INTO PREREQUIS (codMod, codModPrereq) VALUES (8, 5); 
INSERT INTO PREREQUIS (codMod, codModPrereq) VALUES (7, 5);

INSERT INTO ETUDIANT VALUES
((SELECT nvl(MAX(numEtu), 0) + 1 FROM ETUDIANT), 'Fourier','Joseph',NULL, NULL);

INSERT INTO INSCRIPTION VALUES (1, 1, '01-SEP-2023');

INSERT INTO EXAMEN VALUES
(
(SELECT codMod FROM MODULE WHERE nomMod = 'Oracle'),1, to_date('11012024',
'ddmmyyyy')
);

INSERT INTO EXAMEN VALUES (1, 2, SYSDATE);

COMMIT;

-- Pour tester la contrainte numéro 1
SELECT * FROM PREREQUIS;
UPDATE PREREQUIS SET noteMin = 2;
SELECT * FROM PREREQUIS;

-- Pour tester la contrainte numéro 2
SELECT * FROM MODULE;
INSERT INTO INSCRIPTION VALUES (1, 4, SYSDATE);

-- possible
UPDATE MODULE SET effectif = 25 WHERE codMod = 3;
INSERT INTO INSCRIPTION VALUES (1, 3, SYSDATE);
SELECT * FROM MODULE;

-- Pour tester la contrainte numéro 3
SELECT * FROM EXAMEN;
SELECT * FROM INSCRIPTION;
INSERT INTO EXAMEN VALUES (4, 1, SYSDATE);
SELECT * FROM EXAMEN;

-- Pour tester la contrainte numéro 4
-- possible
INSERT INTO RESULTAT VALUES(1, 2, 1, NULL);
-- Impossible
UPDATE INSCRIPTION SET dateInsc = '11-JAN-2025' 
WHERE numEtud = 1 AND codMod = 1;
INSERT INTO RESULTAT VALUES(1, 1, 1, NULL);

-- Pour tester la contrainte numéro 5
INSERT INTO PREREQUIS VALUES(5, 1, 5); -- Création d'un circuit
INSERT INTO PREREQUIS VALUES(4, 5, 5); -- Pas de circuit
-- création d'un plus grand circuit;
INSERT INTO PREREQUIS VALUES(1, 2, 13); -- Pas de circuit
INSERT INTO PREREQUIS VALUES(2, 6, 13); -- Circuit


-- Pour tester la contrainte numéro 6
SELECT * FROM PREREQUIS;
INSERT INTO INSCRIPTION VALUES (1, 2, SYSDATE); -- prérequis nécessaire
INSERT INTO INSCRIPTION VALUES (1, 5, SYSDATE); -- pas de prérequis OK