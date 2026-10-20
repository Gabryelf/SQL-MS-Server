USE academy;

DROP PROCEDURE IF EXISTS fill_teachers;

DELIMITER $$

CREATE PROCEDURE fill_teachers(IN p_count INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= p_count DO
        INSERT INTO teachers (full_name, email, phone, created_at)
        VALUES (
            CONCAT('Teacher ', i),                    -- имя
            CONCAT('teacher', i, '@academy.test'),    -- email
            CONCAT('790000000', LPAD(i, 2, '0')),     -- телефон
            CURDATE() - INTERVAL i DAY                -- дата
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
