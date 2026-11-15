USE academy;

create table classes(
    id int primary key auto_increment,
    class_name varchar(50) not null,
    places tinyint unsigned not null
);

create table student_groups(
    id int primary key auto_increment,
    group_name varchar(50) not null,
    stud_count tinyint,
    speciality varchar(50) not null
);

create table teachers(
    id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(20) unique,
    created_at date
);

create table students(
    id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(20) unique,
    student_group_id int not null,
    birthday_date date,
    created_at date,

    foreign key (student_group_id)
    references student_groups(id)
);

create table subjects(
    id int primary key auto_increment,
    sub_name varchar(50) not null,
    hours decimal(4,1) not null,
    teacher_id int not null,

    foreign key (teacher_id)
    references teachers(id)
);

create table lessons(
    id int primary key auto_increment,
    theme_name varchar(50) not null,
    stud_count tinyint,
    subject_id int not null,
    stud_group_id int not null,
    teacher_id int not null,
    class_id int not null,
    date_at datetime,

    foreign key (subject_id)
    references subjects(id),
    foreign key (stud_group_id)
    references student_groups(id),
    foreign key (teacher_id)
    references teachers(id),
    foreign key (class_id)
    references classes(id)
);

create table student_grades(
    id int primary key auto_increment,
    value_grade tinyint not null,
    teacher_id int not null,
    student_id int not null,
    subject_id int not null,
    lesson_id int not null,
    created_at datetime,

    foreign key (teacher_id)
    references teachers(id),
    foreign key (student_id)
    references students(id),
    foreign key (subject_id)
    references subjects(id),
    foreign key (lesson_id)
    references lessons(id)
);

create table schedule_entries (
    id int primary key auto_increment,
    date_day date not null,
    lesson_number tinyint unsigned not null,
    stud_group_id int not null,
    lesson_id int not null,
    created_at datetime default current_timestamp,

    unique key uq_group_day_slot (date_day, lesson_number, stud_group_id),
    foreign key (stud_group_id) references student_groups(id),
    foreign key (lesson_id) references lessons(id),

    check (lesson_number between 1 and 8)
);
