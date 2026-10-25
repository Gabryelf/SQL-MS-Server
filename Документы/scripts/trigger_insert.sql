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

