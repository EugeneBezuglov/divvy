WITH table_count(count) AS (
    VALUES
        ((SELECT COUNT(*) FROM feb2022)),
        ((SELECT COUNT(*) FROM mar2022)),
        ((SELECT COUNT(*) FROM apr2022)),
        ((SELECT COUNT(*) FROM may2022)),
        ((SELECT COUNT(*) FROM jun2022)),
        ((SELECT COUNT(*) FROM jul2022)),
        ((SELECT COUNT(*) FROM aug2022)),
        ((SELECT COUNT(*) FROM sep2022)),
        ((SELECT COUNT(*) FROM oct2022)),
        ((SELECT COUNT(*) FROM nov2022)),
        ((SELECT COUNT(*) FROM dec2022)),
        ((SELECT COUNT(*) FROM jan2023))
)
SELECT SUM(count) FROM table_count;