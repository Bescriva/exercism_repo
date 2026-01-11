
CREATE TABLE IF NOT EXISTS twofer (
    input TEXT,
    response TEXT
);

UPDATE twofer
SET response = 'One for ' || COALESCE(NULLIF(input, ''), 'you') || ', one for me.'
