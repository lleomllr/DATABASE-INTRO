CREATE OR REPLACE t6
    BEFORE INSERT OR UPDATE ON INSCRIPTION
    FOR EACH ROW
 
DECLARE 
    note_min number;
    note_etudiant number; 
    pre_requis_null EXCEPTION

BEGIN 
    FOR pre_requis IN (SELECT codModPrereq, noteMin
                       FROM PREREQUIS
                       WHERE codMod =:new.codMod)
    LOOP
        SELECT note INTO note_etudiant
        FROM RESULTAT
        WHERE numEtu =:new.numEtud AND codMod = pre_requis.codModPrereq; 
    
        IF note_etudiant < pre_requis.note_min THEN 
            RAISE pre_requis_null; 
        END IF; 
    END LOOP; 

    EXCEPTION 
        WHEN pre_requis_null THEN 
            RAISE_APPLICATION_ERROR(-20250, "Impossible"); 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20168, "ERREUR"); 
END; 
/