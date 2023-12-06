CREATE OR REPLACE TRIGGER t3
    BEFORE INSERT OR UPDATE ON EXAMEN 
    FOR EACH ROW

DECLARE 
    nb_inscrits INSCRIPTION%ROWTYPE; 

BEGIN
    SELECT COUNT(*) INTO nb_inscrits FROM ETUDIANT
    WHERE codMod = :new.codMod; 

    IF nb_inscrits = 0 THEN 
        RAISE_APPLICATION_ERROR(-20500, 'Aucun étudiant inscrit'); 
    END IF; 
END;
/
