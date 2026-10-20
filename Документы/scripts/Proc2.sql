CREATE PROCEDURE fill_teachers(IN p_count INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= p_count DO
        INSERT INTO teachers (full_name, email, phone, created_at)
        VALUES (
            CONCAT('Teacher ', i),
            CONCAT('teacher', i, '@academy.test'),
            CONCAT('790000000', LPAD(i, 2, '0')),
            CURDATE() - INTERVAL i DAY
        );
        SET i = i + 1;
    END WHILE;
END
