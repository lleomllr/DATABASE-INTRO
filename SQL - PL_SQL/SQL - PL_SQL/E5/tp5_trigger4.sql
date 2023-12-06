CREATE OR REPLACE TRIGGER t5
    BEFORE INSERT OR UPDATE ON PREREQUIS 
    FOR EACH ROW

DECLARE
    compt number; 

BEGIN 
    SELECT COUNT(*)
    INTO compt
    FROM (SELECT codMod FROM PREREQUIS
          CONNECT BY PRIOR codMod = codModPrereq
          START WITH codMod = :new.codMod)
    WHERE codMod =:new.codModPrereq; 

    IF compt > 0 THEN 
        RAISE_APPLICATION_ERROR(-20003, "Il y a un circuit dans la table PREREQUIS"); 
    END IF; 
END; 
/