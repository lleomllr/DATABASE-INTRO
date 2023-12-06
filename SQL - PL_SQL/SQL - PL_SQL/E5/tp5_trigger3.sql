CREATE OR REPLACE TRIGGER t4
    BEFORE INSERT OR UPDATE ON INSCRIPTION
    FOR EACH ROW

DECLARE 
    inscrip_date date; 

BEGIN 
    SELECT dateInsc INTO inscrip_date
    FROM INSCRIPTION 
    WHERE numEtu =:new.numEtu AND codMod =:new.codMod; 

    IF inscrip_date > :new.to_date THEN 
        RAISE_APPLICATION_ERROR(-20387, "Impossible, l'examen est déjà passé :b"); 
    END IF; 
END; 
/