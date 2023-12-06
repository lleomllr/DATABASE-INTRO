 CREATE VIEW Vue1 AS
SELECT
    S.SerNo,
    S.Nom,
    S.Lieu,
    MIN(E.Salaire) AS SalaireMin,
    MAX(E.Salaire) AS SalaireMax
FROM
    SERVICE S
JOIN
    EMPLOYE E ON S.SerNo = E.SerNo
GROUP BY
    S.SerNo, S.Nom, S.Lieu;



CREATE VIEW Vue2 AS SELECT 
     E.SerNo,
     E.Nom,
     E.Prenom,
     E.Empno,
     E.Salaire*6.55957 AS SalaireFranc,
     E.Fonction,
     E.Commission*6.55957 AS CommisionFranc
FROM 
    EMPLOYE E;


SELECT * FROM Vue1;
SELECT * FROM Vue2;

INSERT INTO EMPLOYE VALUES(1,'FAREHAN','Jules','Président',NULL,'17-NOV-81',5000.00,NULL,30);

DELETE FROM Vue2 WHERE Prenom='Jules';

SELECT * FROM Vue2;

CREATE TRIGGER trigger1
INSTEAD OF INSERT ON Vue2
FOR EACH ROW
BEGIN
     INSERT INTO EMPLOYE(EmpNo,Nom,Prenom,Fonction,Chef,DateEmbauche,Salaire,Commission)
     VALUES(:New_EmpNo, :New_Nom , :Nom_Prenom,
      :New_Fonction, :New_SerNo, NULL , SysDate,
      :New_SalaireFranc/6.55957,:New_CommissionFRanc/6.559557);
END;



INSERT INTO Vue2 VALUES(5,'leao','Rafael','vendeur',20,5000.00,200);

SELECT * FROM EMPLOYE;

CREATE OR REPLACE TRIGGER Insert_Employe
AFTER INSERT ON EMPLOYE