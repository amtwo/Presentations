BEGIN
    BEGIN
        SELECT REPLACE(REPLACE('abc123','a','z'),1,9);
    END;
END;