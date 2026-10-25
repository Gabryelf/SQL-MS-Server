USE academy;

DROP FUNCTION IF EXISTS rand_string$$
CREATE FUNCTION rand_string(n INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE chars_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    DECLARE return_str VARCHAR(255) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str = CONCAT(return_str, SUBSTRING(chars_str, FLOOR(1 + RAND() * 52), 1));
        SET i = i + 1;
    END WHILE;
    RETURN return_str;
END

DROP FUNCTION IF EXISTS rand_num$$
CREATE FUNCTION rand_num(min_val INT, max_val INT) RETURNS INT
BEGIN
    RETURN FLOOR(min_val + RAND() * (max_val - min_val + 1));
END

DROP FUNCTION IF EXISTS rand_date$$
CREATE FUNCTION rand_date(start_date DATE, end_date DATE) RETURNS DATE
BEGIN
    RETURN DATE_ADD(start_date, INTERVAL FLOOR(RAND() * DATEDIFF(end_date, start_date) + 1) DAY);
END
