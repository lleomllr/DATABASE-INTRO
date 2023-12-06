CREATE OR REPLACE TRIGGER t2
    BEFORE INSERT OR UPDATE ON INSCRIPTION
    FOR EACH ROW

DECLARE 
    maxeff MODULE%ROWTYPE; 

BEGIN
    SELECT * INTO maxeff FROM MODULE WHERE codMod=:new.codMod; 
    UPDATE MODULE SET effectif = effectif + 1 WHERE codMod=:new.codMod; 

    IF maxeff.effectif > maxeff.effectifMax THEN 
        RAISE_APPLICATION_ERROR(-20300, 'Erreur'); 
    END IF; 
END; 
/



    