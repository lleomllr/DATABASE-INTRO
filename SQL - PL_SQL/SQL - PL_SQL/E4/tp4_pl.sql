DECLARE
    CURSOR cursC IS SELECT * FROM Action FOR UPDATE OF Statut;
BEGIN
    for i in cursC 
    LOOP 
        IF i.Op = 'u' THEN
            UPDATE Temp SET Valeur=i.Nouv_valeur WHERE Ligne=i.Ligne;
            IF SQL%NOTFOUND THEN
                INSERT INTO Temp (Ligne, Valeur) VALUES (i.Ligne, i.Nouv_valeur);
                UPDATE Action SET Statut='ligne non trouve : valeur inseree' WHERE CURRENT OF cursC;
            ELSE 
                UPDATE Action SET Statut='mise a jour : succes' WHERE CURRENT OF cursC;
            END IF; 
        ELSE IF i.Op = 'd' THEN
               UPDATE Temp SET Valeur=i.Nouv_valeur WHERE Ligne=i.Ligne;
            IF SQL%NOTFOUND THEN
                INSERT INTO Temp (Ligne, Valeur) VALUES (i.Ligne, i.Nouv_valeur);
                UPDATE Action SET Statut='ligne non trouve : valeur inseree' WHERE CURRENT OF cursC;
            ELSE 
                UPDATE Action SET Statut='mise a jour : succes' WHERE CURRENT OF cursC;
            END IF;
        ELSE IF i.Op = 'i' THEN
            BEGIN 
            
                INSERT INTO Temp (Ligne, Valeur) VALUES (i.Ligne, i.Nouv_valeur); 
                UPDATE Action SET Statut='insertion : succes' WHERE CURRENT OF cursC;

            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN 
                    UPDATE Action SET Statut='erreur : doublon' WHERE CURRENT OF cursC; 

            END;
        ELSE
            UPDATE Action SET Statut='operateur invalide : aucune action' WHERE CURRENT OF cursC;
        END IF;
        END IF;
        END IF;
    END LOOP;
END;
/            