USE academy;
DROP PROCEDURE IF EXISTS fill_teachers;

DELIMITER $$

CREATE PROCEDURE fill_teachers(IN p_count INT)
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < p_count DO
        INSERT INTO teachers (full_name, email, phone, created_at)
        VALUES (
            CONCAT(
                ELT(1 + FLOOR(RAND() * 10),
                    'Ivan','Petr','Anna','Maria','Olga',
                    'Sergey','Dmitry','Elena','Alexey','Natalia'),
                ' ',
                ELT(1 + FLOOR(RAND() * 10),
                    'Ivanov','Petrov','Sidorov','Smirnov','Kuznetsov',
                    'Popov','Vasiliev','Sokolov','Mikhailov','Novikov')
            ),
            CONCAT('teacher', i, '_', UNIX_TIMESTAMP(), '@academy.test'),
            CONCAT('79', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            CURDATE() - INTERVAL FLOOR(RAND() * 365) DAY
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
