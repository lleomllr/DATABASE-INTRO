CREATE OR REPLACE TRIGGER trigger1 
    BEFORE UPDATE ON PREREQUIS

BEGIN
    IF :old.noteMin != :new.noteMin THEN RAISE_APPLICATION_ERROR(-20500, "impossible"); 
    END IF; 
END; 
/