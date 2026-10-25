CREATE TRIGGER trg_shedules_auto_date
BEFORE INSERT ON shedules
FOR EACH ROW
BEGIN
    IF NEW.date_day IS NULL THEN
        SET NEW.date_day = (
            SELECT DATE_ADD(COALESCE(MAX(date_day), '2026-01-01'), INTERVAL 1 DAY)
            FROM shedules
        );
    END IF;
END

--Заполнение существующей таблицы по порядку
SET @start = '2026-01-01';
SET @row = -1;

UPDATE shedules
SET date_day = DATE_ADD(@start, INTERVAL (@row := @row + 1) DAY)
ORDER BY id;
