
CREATE TABLE IF NOT EXISTS twofer (
    input TEXT,
    response TEXT
);

UPDATE twofer
SET response = CASE WHEN input IS NULL or input = '' THEN 'One for you, one for me.'
    ELSE 'One for ' || input || ', one for me.'
END;