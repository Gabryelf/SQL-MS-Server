USE academy;

INSERT INTO classes(class_name, places)
VALUES ('501 violet', 24),
	   ('502 ground', 22),
       ('403 yellow', 18);
       
INSERT INTO student_groups(group_name, stud_count, speciality)
VALUES('РПО-1', 16, 'разработчик 4 года'),
	  ('РПО-2', 16, 'разработчик 4 года'),
      ('ГД-1', 14, 'графический дизайн 3 года');
      
INSERT INTO teachers(full_name, email, phone, created_at)
VALUES('Иванов Иван Петрович', 'ivanov@mail.com', '+79785353555', '2022-05-05'),
	  ('Петров Василий Петрович', 'petrov@mail.com', '+79785353745', '2023-05-05'),
      ('Соколова Анна Ивановна', 'sokolova_an@mail.com', '+79785453211', '2022-06-05');
      
INSERT INTO students(full_name, email, phone, student_group_id, birthday_date, created_at)
VALUES('Козлов Иван Петрович', 'kozlov_123@mail.com', '+79785358755', 1, '2000-05-05', '2022-05-05'),
	  ('Соболев Василий Петрович', 'ssobolev@mail.com', '+79785353095', 2, '2001-04-12','2023-05-05'),
      ('Зайцева Анна Ивановна', 'zayceva@mail.com', '+79785453001', 3, '2000-12-05', '2022-06-05');
