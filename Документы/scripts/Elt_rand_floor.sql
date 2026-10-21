SET l1 = (SELECT id FROM lessons ORDER BY RAND() LIMIT 1);

SELECT ELT(FLOOR(RAND() * 10) + 1,
           'Informatics','Mathematics','Physics','Chemistry','Biology',
           'Economics','Law','Medicine','Engineering','Linguistics');
