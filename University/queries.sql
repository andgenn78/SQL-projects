--Create domain
--Короткие строки (ShortString) обычно используются для значений, отображаемых в таблицах в пользовательском интерфейсе
create domain ShortString as varchar(16);
create domain MediumString as varchar(64);
create domain LongString as varchar(256);
create domain TextString as varchar(16384);

--Краткие имена (ShortName) обычно используются для значений, отображаемых в таблицах в пользовательском интерфейсе
create domain ShortName as varchar(16);
create domain MediumName as varchar(64);
create domain LongName as varchar(128);

create domain PhoneNumber as varchar(32);
create domain EmailString as varchar(64) check (value like '%@%');
create domain URLString as varchar(128) check (value like 'http://%');

create domain CareerType as char(2)
	check (value in ('UG','PG','HY','RS','NA'));

create domain GradeType as char(2)
	check (value in (
		'AF', 'AS', 'CR', 'DF', 'DN', 'EC', 'FL', 'FN',
		'GP', 'HD', 'LE', 'NA', 'NC', 'NF', 'PC', 'PE',
		'PS', 'PT', 'RC', 'RD', 'RS', 'SS', 'SY', 'UF',
		'WA', 'WC', 'WD', 'WJ', 'XE',
		'A', 'B', 'C', 'D', 'E'
	));
    
    create domain CampusType as char(1)
	check (value in (
		'K', -- Kensington
		'P', -- COFA/Paddington
		'Z', -- ADFA/UniCollege
		'C', -- CBD (Sydney)
		'X'  -- External
	));
    
    create domain CourseYearType as integer
	check (value > 1945);
    
    
    
    
    --Create table
    --Страны: коды и названия стран
    create table Countries (
	id          integer, -- PG: serial (тип генератора объектов базы данных. Он используется для генерации последовательности целых чисел, которые часто используются в качестве первичного ключа таблицы.)
	code        char(3) not null unique,
	name        LongName not null,
	primary key (id)
);
    -- Здания: информация о здании
    -- например (1234, 'MB', 'Morven Brown Building', 'K', 'C20')
    -- (5678, 'K17', 'CSE Building', 'K', 'K17')
    -- (4321, 'EE', 'Здание электротехники', 'K', 'G17)
    create table Buildings (
	id          integer, -- PG: serial
	unswid      ShortString not null unique,
	name        LongName not null,
	campus      CampusType,
	gridref     char(4),
	primary key (id)
);

    -- Room_types: различные типы комнат в кампусе
    -- например, "Лекционный зал", "Учебная комната", "Офис", ...
    create table Room_types (
	id          integer, -- PG: serial
	description MediumString not null,
	primary key (id)
);
    
    -- Номера: информация о номере
    create table Rooms (
	id          integer, -- PG: serial
	unswid      ShortString not null unique,
	rtype       integer references Room_types(id),
	name        ShortName not null,
	longname    LongName,
	building    integer references Buildings(id),
	capacity    integer check (capacity >= 0),
	primary key (id)
);
 
 
    -- Объекты: вещи в комнатах (например, проектор данных, OHP и т. Д.)
    create table Facilities (
	id          integer, -- PG: serial
	description MediumString not null,
	primary key (id)
);

    -- Room_facilities: какие услуги доступны в каких комнатах
    create table Room_facilities (
	room        integer references Rooms(id),
	facility    integer references Facilities(id),
	primary key (room,facility)
);

    -- OrgUnit_types: виды организационных единиц в UNSW
    -- примеры: "Факультет", "Школа", "Подразделение",...
    -- используется для того, чтобы люди могли изобретать другие новые модули в будущем
    create table OrgUnit_types (
	id          integer, -- PG: serial
	name        ShortName not null,
	primary key (id)
);

    -- OrgUnits/Подразделения: организационные единицы (например, школы, факультеты, ...)
    -- "utype" классифицирует организационную единицу
    create table OrgUnits (
	id          integer, -- PG: serial
	utype       integer not null references OrgUnit_types(id),
	name        MediumString not null,
	longname    LongString,
	unswid      ShortString,
	phone       PhoneNumber,
	email       EmailString,
	website     URLString,
	starting    date, -- not null
	ending      date,
	primary key (id)
);

    -- OrgUnit_groups: как связаны организационные единицы
    -- позволяет создавать многоуровневую иерархию групп
    create table OrgUnit_groups (
	owner	    integer references OrgUnits(id),
	member      integer references OrgUnits(id),
	primary key (owner,member)
);

    -- Периоды обучения (они же термины, сессии)
    -- все даты должны быть не нулевыми, но у нас нет к ним доступа
    create table Semesters (
	id          integer, -- PG: serial
	unswid      integer not null unique,
	year        CourseYearType,
	term        char(2) not null check (term in ('S1','S2','X1','X2')),
	name        ShortName not null,
	longname    LongName not null,
	starting    date not null,
	ending      date not null,
	startBrk    date, -- start of mid-semester break (начало перерыва в середине семестра)
	endBrk      date, -- end of mid-semester break (конец перерыва в середине семестра)
	endWD       date, -- last date to withdraw without academic penalty (последняя дата для снятия без академического штрафа)
	endEnrol    date, -- last date to enrol without special permission (последняя дата для регистрации без специального разрешения)
	census      date, -- last date to withdraw without paying for course (последняя дата для снятия без оплаты курса)
	primary key (id)
);
  
  
  -- Public_holidays: дни, когда обычное обучение отменяется
  -- Это может быть сделано как однодневные / одноразовые события
  -- Нет первичного ключа; может быть несколько праздников (например, разные религии) в ту же дату
    create table Public_holidays (
	semester    integer references Semesters(id),
	description MediumString, -- e.g. Good Friday, Easter Day
	day         date
);

    -- Staff_roles: роли для персонала в организации UNSW. Обрабатывает классы заданий, в которых работают сотрудники
    -- например, "Младший преподаватель", "Профессор", "Помощник администратора", "Сотрудник по компьютерным системам", "Клерк", "Поставщик провизии"
    -- а также обрабатывает определенные роли для некоторых сотрудников, например, "вице-канцлер", "Декан", "Глава школы", "Директор по обучению", "Помощник администратора декана", "Школьный офис-менеджер", ...
    create table Staff_role_types (
	id          char(1),
	description ShortString,
	primary key (id)
);

    create table Staff_role_classes (
	id          char(1),
	description ShortString,
	primary key (id)
);

    create table Staff_roles (
	id          integer, -- PG: serial
	rtype       char(1) references Staff_role_types(id),
	rclass      char(1) references Staff_role_classes(id),
	name        LongString not null,
	description LongString,
	primary key (id)
);

    -- Люди:
    create table People (
	id          integer, -- PG: serial
	unswid      integer unique, -- staff/student id (can be null)
	password    ShortString not null,
	family      LongName,
	given       LongName not null,
	title       ShortName, -- e.g. "Prof", "A/Prof", "Dr", ...
	sortname    LongName not null,
	name        LongName not null,
	street      LongString,
	city        MediumString,
	state       MediumString,
	postcode    ShortString,
	country     integer references Countries(id),
	homephone   PhoneNumber, -- should be not null
	mobphone    PhoneNumber,
	email       EmailString not null,
	homepage    URLString,
	gender      char(1) check (gender in ('m','f')),
	birthday    date,
	origin      integer references Countries(id),  -- country where born
	primary key (id)
);

    -- Студент (подкласс): тип зачисления
    create table Students (
	id          integer references People(id),
	stype       varchar(5) check (stype in ('local','intl')),
	primary key (id)
);

    -- Student_groups: группы учащихся (используются при определении квот)
    -- использует SQL-запросы, хранящиеся в базе данных, для извлечения списков учащихся, принадлежащих к определенным классам
    create table Student_groups (
	id          integer, -- PG: serial
	name        LongName unique not null,
	definition  TextString not null, -- SQL query to get student(id)'s. Текстовая строка определения не равна нулю. SQL-запрос для получения идентификатора студента
	primary key (id)
);

    -- Персонал (подкласс): контактная информация по трудоустройству и в кампусе
    -- у всех сотрудников есть уникальный идентификатор персонала, отличный от их идентификатора человека
    -- любой, кто преподает класс, должен быть внесен в эту таблицу
    -- (обычно они вводятся в базу данных отдела кадров UNSW)
    create table Staff (
	id          integer references People(id),
	office      integer references Rooms(id),
	phone       PhoneNumber, -- full number, not just extension
	employed    date not null,
	supervisor  integer references Staff(id),
	primary key (id)
);

    -- Принадлежность: роли персонала и связь с организационными подразделениями
    -- большая часть персонала будет прикреплена только к одному подразделению
    -- "роль" будет описывать такие вещи, как "Профессор", "Глава школы", ...
    -- если это их класс работы для HR, IsPrimary имеет значение true
    create table Affiliations (
	staff       integer references Staff(id),
	orgUnit     integer references OrgUnits(id),
	role        integer references Staff_roles(id),
	isPrimary   boolean, -- является ли эта роль основой для их трудоустройства?
	starting    date not null, -- когда они приступили к выполнению этой роли
	ending      date,  -- когда они завершаются; null означает текущий
	primary key (staff,orgUnit,role,starting)
);

   -- Программы: академические детали дипломной программы
   -- поле "код" используется для совместимости с текущей практикой UNSW
   -- например, 3978 - это код для получения степени в области компьютерных наук
   create table Programs (
	id          integer, -- PG: serial
	code        char(4) not null, -- e.g. 3978, 3645, 3648
	name        LongName not null,
	uoc         integer check (uoc >= 0),
	offeredBy   integer references OrgUnits(id),
	career      CareerType,
	duration    integer,  -- #месяцы
	description TextString, -- PG: text
	firstOffer  integer references Semesters(id), -- должно быть не null
	lastOffer   integer references Semesters(id), -- null означает текущий
	primary key (id)
);

   -- Потоки: академические детали основного / второстепенного потока (потоков) в степени
    create table Streams (
	id          integer, -- PG: serial
	code        char(6) not null, -- e.g. COMPA1, SENGA1
	name        LongName not null,
	offeredBy   integer references OrgUnits(id),
	stype       ShortString,
	description TextString,
	firstOffer  integer references Semesters(id), -- should be not null
	lastOffer   integer references Semesters(id), -- null means current
	primary key (id)
);

    -- Degree_types: типы присуждения степеней
    create table Degree_types (
	id          integer, -- PG: serial
	unswid      ShortName not null unique, -- например, бакалавр, бакалавр (CompSci), BE, PhD
	name        MediumString not null,  -- e.g. например, бакалавр наук
	prefix      MediumString,
	career      CareerType,
	aqf_level   integer check (aqf_level > 0),
	primary key (id)
);

   -- Program_degrees: степени, присуждаемые за каждую программу
   -- параллельная степень будет иметь две записи для одной программы
    create table Program_degrees (
	program     integer references Programs(id),
	degree      integer references Degree_types(id),
	name        LongString not null,
	abbrev      MediumString,
	primary key (program,degree)
);

   -- Degrees_awarded: информация о присуждении степени студенту
    create table Degrees_awarded (
	student     integer references Students(id),
	program     integer references Programs(id),
	graduated   date,	
	primary key (student,program)
);

   -- Academic_standing: виды академического статуса в UNSW
   -- например, "хорошо", "испытательный срок 1", "испытательный срок 2",...
   -- Таблица перечисляемого типа
    create table Academic_standing (
	id          integer,
	standing    ShortName not null,
	notes       TextString,
	primary key (id)
);

   -- Темы: академические подробности курса (версия)
   -- "код" - это стандартный код курса UNSW (например, COMP3311)
   -- "firstOffer" и "lastOffer" указывают промежуток времени, в котором этот предмет был предложен студентам; если "Последнее предложение" равно нулю, тогда объект все еще выполняется
   -- Примечание: UNSW называет предметы "курсами"
    create table Subjects (
	id          integer, -- PG: serial
	code        char(8) not null,
-- PG: проверка (code ~ '[A-Z]{4}[0-9]{4}'),
	name        MediumName not null,
	longname    LongName,
	uoc         integer check (uoc >= 0),
	offeredBy   integer references OrgUnits(id),
	eftsload    float,
	career      CareerType,
	syllabus    TextString, -- PG: text
	contactHPW  float, -- contact hours per week. контакт часов в неделю
	_excluded   text,    -- plain text from MAPPS. обычный текст из MAPPS
	excluded    integer, -- references Acad_object_groups(id). ссылается на Acad_object_groups
	_equivalent text,    -- plain textfrom MAPPS.
	equivalent  integer, -- references Acad_object_groups(id)
	_prereq     text,    -- plain text from MAPPS
	prereq      integer, -- references Requirements(id)
	replaces    integer references Subjects(id),
	firstOffer  integer references Semesters(id), -- should be not null
	lastOffer   integer references Semesters(id), -- null means current
	primary key (id)
);

   -- Курс: информация о предложении предмета в данном семестре
    create table Courses (
	id          integer, -- PG: serial
	subject     integer not null references Subjects(id),
	semester    integer not null references Semesters(id),
	homepage    URLString,
	primary key (id)
);

   -- Course_staff: различные сотрудники, участвующие в курсе
   -- позволяет одному сотруднику иметь несколько ролей в курсе
    create table Course_staff (
	course      integer references Courses(id),
	staff       integer references Staff(id),
	role        integer references Staff_roles(id),
	primary key (course,staff,role)
);

  -- Курс_quotas: квоты для различных классов студентов в курсе
  -- если нет квоты, в этой таблице нет записи
  -- в качестве альтернативы, мы могли бы разрешить значение quota равным null и использовали это как механизм для указания "нет квоты"
    create table Course_quotas (
	course      integer references Courses(id),
	sgroup      integer references Student_groups(id),
	quota       integer not null,
	primary key (course,sgroup)
);

   -- Program_enrolments: зачисление студента на программу за один семестр
   -- "положение" относится к академическому положению студентов
   -- "wam" вычисляется по отметкам в регистрационных записях
    create table Program_enrolments (
	id          integer,
	student     integer not null references Students(id),
	semester    integer not null references Semesters(id),
	program     integer not null references Programs(id),
	wam         real,
	standing    integer references Academic_standing(id),
	advisor     integer references Staff(id),
	notes       TextString,
	primary key (id)
);
 
    -- Stream_enrolments: зачисление студентов в потоки за один семестр
    create table Stream_enrolments (
	partOf      integer references Program_enrolments(id),
	stream      integer references Streams(id),
	primary key (partOf,stream)
);

   -- Course_enrolments: зачисление студента на курс, предлагающий: нулевая оценка означает "зачислен в данный момент"
   -- если курс оценивается SY / FL, то отметка всегда остается нулевой
    create table Course_enrolments (
	student     integer references Students(id),
	course      integer references Courses(id),
	mark        integer check (mark >= 0 and mark <= 100),
	grade       GradeType,
	stuEval     integer check (stuEval >= 1 and stuEval <= 6),
	primary key (student,course)
);

    -- Course_enrolment_waitlist: списки ожидания для зачисления на курс
    -- записи остаются в этом списке только до тех пор, пока учащиеся не будут зачислены, и затем они удаляются
    -- "примененная" дата используется в качестве основы для FIFO распределение мест
    
    create table Course_enrolment_waitlist (
	student     integer references Students(id),
	course      integer references Courses(id),
	applied     timestamp not null,
	primary key (student,course)
);

    -- Книги: детали учебника
    create table Books (
	id          integer, -- PG: serial
	isbn        varchar(20) unique,
	title       LongString not null,
	authors     LongString not null,
	publisher   LongString not null,
	edition     integer,
	pubYear     integer not null check (pubYear > 1900),
	primary key (id)
);

   -- Course_books: связывает книги с курсами
   -- книги относятся к курсу, а не к предмету, потому что тексты
   -- может меняться со временем, даже если учебный план остается неизменным
    create table Course_books (
	course      integer references Courses(id),
	book        integer references Books(id),
	bktype      varchar(10) not null check (bktype in ('Text','Reference')),
	primary key (course,book)
);

   -- Тип класса: имена для разных типов классов, например, "Лекция", "Учебное пособие", "Лабораторный класс", ...
    create table Class_types (
	id          integer, -- PG: serial
	unswid      ShortString not null unique,
	name        MediumName not null,
	description MediumString,
	primary key (id)
);

   -- Классы: конкретное регулярное учебное мероприятие в курсе
   -- мы игнорируем потоки, так как они делают регистрацию класса слишком запутанной
   -- мы не допускаем, чтобы информация о дне / времени / месте была нулевой; это вынуждает нас уже организовать время / место, прежде чем мы введем их в систему
   -- еженедельные повторения обрабатываются (повторы = 1 или повторы равны нулю)
   -- мы предполагаем, что продолжительность всех занятий кратна 1 часу
   -- и не может начаться раньше 8 утра или закончиться после 11 вечера)
    create table Classes (
	id          integer, -- PG: serial
	course      integer not null references Courses(id),
	room        integer not null references Rooms(id),
	ctype       integer not null references Class_types(id),
	dayOfWk     integer not null check (dayOfWk >= 0 and dayOfWk <= 6),
	                                  -- Sun=0 Mon=1 Tue=2 ... Sat=6
	startTime   integer not null check (startTime >= 8 and startTime <= 22),
	endTime     integer not null check (endTime >= 9 and endTime <= 23),
	                                  -- time of day, between 8am and 11pm
	startDate   date not null,
	endDate     date not null,
	repeats     integer, -- every X weeks
	primary key (id)
);

    -- Class_teachers: кто какой класс преподает
    create table Class_teachers (
	class       integer references Classes(id),
	teacher     integer references Staff(id),
	primary key (class,teacher)
);

    -- Class_enrolments: зачисление одного ученика в класс
    create table Class_enrolments (
	student     integer references Students(id),
	class       integer references Classes(id),
	primary key (student,class)
);

     -- Class_enrolment_waitlist: списки ожидания для зачисления в класс
    create table Class_enrolment_waitlist (
	student     integer references Students(id),
	class       integer references Classes(id),
	applied     timestamp not null,
	primary key (student,class)
);

    -- External_subjects: представляет курсы из других учреждений
    -- используется для обеспечения согласованности при присвоении статуса advanced
    -- если студент X получает продвинутую оценку на основе курса Y в Z,
    -- тогда более поздний студент, который прошел курс Y в Z, может быть дан тот же продвинутый статус
    -- чтобы сделать это правильно, нам нужно настроить таблицу внешних учреждений и использовать внешний ключ... в нынешнем виде, если люди присуждают кредиты за один и тот же курс, но пишут либо название курса или название учебного заведения по-другому, это будет рассматриваться как другой курс
    create table External_subjects (
	id          integer,
	extsubj     LongName not null,
	institution LongName not null,
	yearOffered CourseYearType,
	equivTo     integer not null references Subjects(id),
--	creator     integer not null references Staff(id),
--	created     date not null,
	primary key (id)
);

   -- Вариации: замена одного предмета или другого в программе
-- обрабатывает несколько случаев (которые более или менее похожи):
-- продвинутый уровень для курсов, изучаемых либо в UNSW, либо в другом месте
-- замена одного курса другим для удовлетворения требований
-- освобождение от одного курса, для использования в качестве предварительного условия
-- в случае исключений кредит программе не предоставляется;
-- субъект записывается для использования в качестве предварительного запроса
-- замена предназначена для одного предмета в соответствии с требованиями из одного потока
-- в этой единственной таблице представлены два поднабора:
-- субъект является внутренним субъектом UNSW (внутренняя эквивалентность)
-- субъект находится за пределами UNSW (внешняя эквивалентность)
-- не могу войти в продвинутый статус, не сказав, кто вы, поскольку Продвинутый уровень - это все равно что получить пропуск на курсе UNSW
-- если бы мы хотели записать внешние предметы, используемые в качестве основы для предварительных условий, но не для получения кредита (т.е. Освобождения), мы бы добавили новое поле, чтобы указать, что кредит не был задействован
    create domain VariationType as ShortName
	check (value in ('advstanding','substitution','exemption'));

    create table Variations (
	student     integer references Students(id),
	program     integer references Programs(id),
	subject     integer references Subjects(id),
	vtype       VariationType not null,
	intEquiv    integer references Subjects(id),
	extEquiv    integer references External_subjects(id),
	yearPassed  CourseYearType,
	mark        integer check (mark > 0), -- if we know it
	approver    integer not null references Staff(id),
	approved    date not null,
	primary key (student,program,subject),
	constraint  TwoCases check
	              ((intEquiv is null and extEquiv is not null)
	              or
	               (intEquiv is not null and extEquiv is null))
);

-- Acad_object_groups: группы различных типов академических объектов
-- академические объекты = курсы, потоки ИЛИ программы

-- различные типы академических объектов, которые можно сгруппировать
-- каждая группа состоит из набора объектов одного и того же типа
    create domain AcadObjectGroupType as ShortName
	check (value in (
		'subject',      -- группа субъектов
		'stream',       -- группа потоков
		'program'       -- группа программ
	));



   -- как интерпретировать комбинации объектов в группах
    create domain AcadObjectGroupLogicType as ShortName
	check (value in ( 'and', 'or'));
   -- как определяются группы
    create domain AcadObjectGroupDefType as ShortName
	check (value in ('enumerated', 'pattern', 'query'));
    
    
    create table Acad_object_groups (
	id          integer,
	name        LongName,
	gtype       AcadObjectGroupType not null,
	glogic      AcadObjectGroupLogicType,
	gdefBy      AcadObjectGroupDefType not null,
	negated     boolean default false,
	parent      integer, -- ссылается на Acad_object_groups(id),
	definition  TextString, -- if pattern or query-based group. если группа на основе шаблона или запроса
	primary key (id)
);


    --оператор ALTER TABLE используется для добавления, изменения или очищения / удаления столбцов в таблице.
    alter table Acad_object_groups
	add foreign key (parent) references Acad_object_groups(id);
    
    alter table Subjects
	add foreign key (excluded) references Acad_object_groups(id);

    alter table Subjects
	add foreign key (equivalent) references Acad_object_groups(id);
    
    --Каждый вид Академической объектной группы требует своего собственного отношения членства
    create table Subject_group_members (
	subject     integer references Subjects(id),
	ao_group    integer references Acad_object_groups(id),
	primary key (subject,ao_group)
);


    create table Stream_group_members (
	stream      integer references Streams(id),
	ao_group    integer references Acad_object_groups(id),
	primary key (stream,ao_group)
);


    create table Program_group_members (
	program     integer references Programs(id),
	ao_group    integer references Acad_object_groups(id),
	primary key (program,ao_group)
);


-- Q1: ...
create or replace view familyname --создание или замена представления
as
	select people.family --выбор
	from people 
	where people.family not like '% %' and family not like '%-%' ----(где) – указывает записи, которые должны войти в результирующую таблицу (фильтр записей) 
	group by people.family --(группировать по) – группирует записи по значениям определенных столбцов
	having count(people.family) = 1 --(имеющие, при условии) – указывает группы записей, которые должны войти в результирующую таблицу (фильтр групп)
	order by people.family desc --(сортировать по) – сортирует (упорядочивает) записи. Значение desc сортирует от высоких значений к низким
;

create or replace view maxlength
as
	select max(length(family)) from familyname --Выбор максимальной длины для столбцов
;

create or replace view Q1(familyName)
as
	select family 
	from familyname
	where length(familyname.family) = (select * from maxlength)
;


-- Q2: ...
create or replace view subjectsemester
as
	select subjects.code,substring(cast(semesters.year as varchar),3)||semesters.term 
	from courses,subjects,semesters
	where 
	subjects.id = courses.subject and 
	semesters.id = courses.semester and 
	courses.id in 
	(
		select course
		from course_enrolments
		where 
		grade = 'A' OR grade = 'B' OR grade = 'C'
		group by course
	)
	order by subjects.code
;

create or replace view Q2(subject,semester)
as
	select * from subjectsemester
;


-- Q3: ...
create or replace view calratio
as
	select cast(uoc/eftsload as numeric(4,1)) as ratio, count(id) as nsubjects
	from subjects
	where eftsload != null or eftsload !=0
	group by cast(uoc/eftsload as NUMERIC(4,1))
	order by ratio
;

create or replace view Q3(ratio,nsubjects)
as
	select ratio,nsubjects from calratio order by ratio
;


-- Q4: ...
create or replace view Q4(orgunit)
as
	select distinct orgunits.longname
	from orgunits
	where id
	not in(
		select orgunits.id
		from orgunit_groups,orgunits
		where 
		orgunit_groups.member = orgunits.id
	)
	order by orgunits.longname
;


-- Q5: ...
create or replace view findyear 
as
	select subjects.code as code, subjects.longname as title, semesters.year as year
	from courses, subjects,semesters
	where courses.subject = subjects.id and 
			courses.semester = semesters.id and 
			subjects.code ilike 'COMP%' and year between 2008 and 2010
;

create or replace view Q5(code, title)
as
	select distinct code,title
	from findyear as f1
	where year = 2008 and
	not exists(
		select code,title,year from findyear where year = 2009 and code = f1.code
	)
	and
	not exists(
		select code,title,year from findyear where year = 2010 and code = f1.code
	)
;


-- Q6: ...
create or replace view findbyyearterm(code,title,stueval,year,term)
as 
select subjects.code,subjects.name,course_enrolments.stueval,semesters.year,semesters.term
from courses,course_enrolments,subjects,semesters
where courses.subject = subjects.id and 
	  course_enrolments.course = courses.id and 
	  courses.semester = semesters.id
order by subjects.code
;

create type EvalRecord as (code text, title text, rating numeric(4,2)); -- регистрирует новый тип данных для использования в текущей базе данных.

create or replace function findEvalOfSubjects(integer,text) returns setof EvalRecord --создаёт новую функцию, либо заменяет определение уже существующей.
as $$ --Долларовые кавычки - это специфичная для PostgreSQL замена одинарных кавычек, чтобы избежать экранирования вложенных одинарных кавычек (рекурсивно). 
declare --позволяет пользователю создавать курсоры, с помощью которых можно выбирать по очереди некоторое количество строк из результата большого запроса.
	r record; curcode varchar := ''; er EvalRecord;
	counter integer := 0;  stuNumberEval float := 0; sumStuEval float := 0;
	tempCode varchar := ''; tempTitle varchar := ''; tempMax float := 0;
	maxStuEval float := 0;
begin
	for r in (select * from findbyyearterm where year = $1 and term = $2)
	loop --организует безусловный цикл, который повторяется до бесконечности, пока не будет прекращён операторами exit или return.
			if (r.code <> curcode) then -- <> не равно
				if (curcode <> '') then
					if (counter > 10 and 3*stuNumberEval >= counter) then
						tempMax = cast(sumStuEval/stuNumberEval as numeric(4,2)); --Во многих случаях требуется преобразовать значение одного типа данных в другой. PostgreSQL предоставляет нам CAST оператор, который позволяет нам это делать.
						if (tempMax >= maxStuEval) then
							maxStuEval = tempMax; er.code = tempCode; er.title = tempTitle; er.rating = tempMax;
							return next er;
						end if;
					end if;
				end if;
				curcode := r.code; counter := 0; stuNumberEval := 0; sumStuEval := 0;
			end if;
			if (r.stueval is not null) then
				sumStuEval := sumStuEval + r.stueval; stuNumberEval := stuNumberEval + 1;
			end if;
			counter := counter + 1; tempCode = r.code; tempTitle = r.title;
	end loop;
end;
$$ language plpgsql;

create or replace function Q6(integer,text) 
	returns setof EvalRecord --Функции могут возвращать не только одно значение/строку, но и набор значений/строк. Для этого в заголовке функции перед типом возвращаемых данных надо вставить ключевое слово SETOF. В теле же функции надо использовать выражение RETURN NEXT для возврата каждой строки. Это выражение можно вызывать несколько раз и результатом каждого вызова будет новая строка в выходном наборе данных. Для выхода из процедуры надо использовать ключевое слово RETURN без параметров. Количество строк, возвращаемых хранимыми процедурами, может быть любым (от нуля до бесконечности).
as $$
declare 
	r record;
	el EvalRecord;
begin
	for r in (select * from findEvalOfSubjects($1,$2) where rating = (select max(rating) from findEvalOfSubjects($1,$2)))
	loop
			el = r;
			return next el;
	end loop;
end;
$$ language plpgsql
;



create or replace function
	proj1_table_exists(tname text) returns boolean
as $$
declare
	_check integer := 0;
begin
	select count(*) into _check from pg_class --Функция COUNT возвращает количество строк, соответствующих определенному условию запроса. 
	where relname=tname and relkind='r';
	return (_check = 1);
end;
$$ language plpgsql;

create or replace function
	proj1_view_exists(tname text) returns boolean
as $$
declare
	_check integer := 0;
begin
	select count(*) into _check from pg_class
	where relname=tname and relkind='v';
	return (_check = 1);
end;
$$ language plpgsql;

create or replace function
	proj1_function_exists(tname text) returns boolean
as $$
declare
	_check integer := 0;
begin
	select count(*) into _check from pg_proc
	where proname=tname;
	return (_check > 0);
end;
$$ language plpgsql;

-- proj1_check_result:
-- определение соответствующего сообщения на основе количества
-- избыточные и отсутствующие кортежи в выводе пользователя по сравнению с ожидаемым результатом

create or replace function
	proj1_check_result(nexcess integer, nmissing integer) returns text
as $$
begin
	if (nexcess = 0 and nmissing = 0) then --Оператор IF-THEN-ELSIF в основном используется, когда из набора альтернатив следует выбрать одну альтернативу, где каждая альтернатива имеет свои собственные условия, которые должны быть выполнены.
		return 'correct';
	elsif (nexcess > 0 and nmissing = 0) then
		return 'too many result tuples';
	elsif (nexcess = 0 and nmissing > 0) then
		return 'missing result tuples';
	elsif (nexcess > 0 and nmissing > 0) then
		return 'incorrect result tuples';
	end if;
end;
$$ language plpgsql;

-- proj1_check:
-- сравнение выходных данных пользовательского представления / функции с ожидаемыми выходными данными
-- возвращение строки (текстовое сообщение), содержащую анализ результатов

create or replace function
	proj1_check(_type text, _name text, _res text, _query text) returns text
as $$
declare
	nexcess integer;
	nmissing integer;
	excessQ text;
	missingQ text;
begin
	if (_type = 'view' and not proj1_view_exists(_name)) then
		return 'No '||_name||' view; did it load correctly?';
	elsif (_type = 'function' and not proj1_function_exists(_name)) then
		return 'No '||_name||' function; did it load correctly?';
	elsif (not proj1_table_exists(_res)) then
		return _res||': No expected results!';
	else
		excessQ := 'select count(*) '||
			   'from (('||_query||') except '||
			   '(select * from '||_res||')) as X';
		-- raise notice 'Q: %',excessQ;
		execute excessQ into nexcess;
		missingQ := 'select count(*) '||
			    'from ((select * from '||_res||') '||
			    'except ('||_query||')) as X';
		-- raise notice 'Q: %',missingQ;
		execute missingQ into nmissing;
		return proj1_check_result(nexcess,nmissing);
	end if;
	return '???';
end;
$$ language plpgsql;

-- proj1_rescheck:
-- сравнение выходных данных пользовательской функции с ожидаемым результатом
-- возвращение строки (текстовое сообщение), содержащую анализ результатов

create or replace function
	proj1_rescheck(_type text, _name text, _res text, _query text) returns text
as $$
declare
	_sql text;
	_chk boolean;
begin
	if (_type = 'function' and not proj1_function_exists(_name)) then
		return 'No '||_name||' function; did it load correctly?';
	elsif (_res is null) then
		_sql := 'select ('||_query||') is null';
		-- raise notice 'SQL: %',_sql;
		execute _sql into _chk;
		-- raise notice 'CHK: %',_chk;
	else
		_sql := 'select ('||_query||') = '||quote_literal(_res);
		-- raise notice 'SQL: %',_sql;
		execute _sql into _chk;
		-- raise notice 'CHK: %',_chk;
	end if;
	if (_chk) then
		return 'correct';
	else
		return 'incorrect result';
	end if;
end;
$$ language plpgsql;

-- check_all:
-- выполнение всех проверок и возвращение таблицы результатов

drop type if exists TestingResult cascade;
create type TestingResult as (test text, result text);

create or replace function
	check_all() returns setof TestingResult
as $$
declare
	i int;
	testQ text;
	result text;
	out TestingResult;
	tests text[] := array[
				'q1', 'q2', 'q3', 'q4', 'q5', 'q6'
				];
begin
	for i in array_lower(tests,1) .. array_upper(tests,1)
	loop
		testQ := 'select check_'||tests[i]||'()';
		execute testQ into result; --Часто требуется динамически формировать команды внутри функций на pgSQL, то есть такие команды, в которых при каждом выполнении могут использоваться разные таблицы или типы данных. Обычно pgSQL кеширует планы выполнения, но в случае с динамическими командами это не будет работать. Для исполнения динамических команд предусмотрен оператор EXECUTE. Предложение INTO указывает, куда должны быть помещены результаты SQL-команды, возвращающей строки. 
		out := (tests[i],result);
		return next out;
	end loop;
	return;
end;
$$ language plpgsql;


-- Функции проверки для конкретных тестовых примеров в проекте Project 1

create or replace function check_q1() returns text
as $chk$
select proj1_check('view','q1','q1_expected',
                   $$select * from q1$$)
$chk$ language sql;

create or replace function check_q2() returns text
as $chk$
select proj1_check('view','q2','q2_expected',
                   $$select * from q2 order by semester, subject$$)
$chk$ language sql;

create or replace function check_q3() returns text
as $chk$
select proj1_check('view','q3','q3_expected',
                   $$select * from q3 order by ratio$$)
$chk$ language sql;

create or replace function check_q4() returns text
as $chk$
select proj1_check('view','q4','q4_expected',
                   $$select * from q4 order by orgunit$$)
$chk$ language sql;

create or replace function check_q5() returns text
as $chk$
select proj1_check('view','q5','q5_expected',
                   $$select * from q5 order by code$$)
$chk$ language sql;

create or replace function check_q6() returns text
as $chk$
select proj1_check('function','q6','q6_expected',
                   $$select * from q6(2007,'S2')$$)
$chk$ language sql;


-- Таблицы ожидаемых результатов для тестовых примеров


drop table if exists q1_expected; --Мы можем выполнить инструкцию DROP TABLE для удаления таблицы, только если она уже существует, указав ключевое слово IF EXISTS после инструкции DROP TABLE, которая проверит существование таблицы. Если не существует такой таблицы, которую мы хотим удалить, PostgreSQL выдает ошибку. Следовательно, чтобы предотвратить ошибку, используется ключевое слово IF EXISTS, которое пропускает оператор DROP TABLE в таком случае.

create table q1_expected (
    familyName LongName
);

drop table if exists q2_expected;
create table q2_expected (
	subject char(8),
	semester char(4)
);

drop table if exists q3_expected;
create table q3_expected (
	ratio numeric(4,1),
	nsubjects integer
);

drop table if exists q4_expected;
create table q4_expected (
    orgunit LongString
);


drop table if exists q5_expected;
create table q5_expected (
    code char(8), 
	title LongName
);

drop table if exists q6_expected;
create table q6_expected (
    code char(8),
    title MediumName,
    rating numeric(4,2)
);

