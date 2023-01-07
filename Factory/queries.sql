--- Структура:
--lenurb_db=# \dt
--             List of relations
-- Schema |     Name     | Type  |   Owner
----------+--------------+-------+-----------
-- public | departments  | table | lenurb_db
-- public | entities     | table | lenurb_db
-- public | events_log   | table | lenurb_db
-- public | incidents    | table | lenurb_db
-- public | instructions | table | lenurb_db
-- public | personnel    | table | lenurb_db
-- public | tasks        | table | lenurb_db
--(7 rows)

--lenurb_db=# \d departments
--                                         Table "public.departments"
--     Column     |           Type           | Collation | Nullable |                 Default
------------------+--------------------------+-----------+----------+-----------------------------------------
-- id             | bigint                   |           | not null | nextval('departments_id_seq'::regclass)
-- name           | character varying(50)    |           | not null |
-- location       | character varying(50)    |           | not null |
-- director_id    | bigint                   |           |          |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
--Indexes:
--    "departments_pkey" PRIMARY KEY, btree (id)
--    "departments_director_id_key" UNIQUE CONSTRAINT, btree (director_id)
--Referenced by:
--    TABLE "personnel" CONSTRAINT "department_id" FOREIGN KEY (department_id) REFERENCES departments(id) ON UPDATE CASCADE



--lenurb_db=# \d personnel
--                                         Table "public.personnel"
--     Column     |           Type           | Collation | Nullable |                Default
------------------+--------------------------+-----------+----------+---------------------------------------
-- id             | bigint                   |           | not null | nextval('personnel_id_seq'::regclass)
-- name           | character varying(50)    |           | not null |
-- surname        | character varying(50)    |           | not null |
-- gender         | character varying(50)    |           | not null |
-- birthday       | date                     |           | not null |
-- marriage       | character varying(50)    |           | not null |
-- email          | character varying(60)    |           | not null |
-- telephone_self | character varying(50)    |           | not null |
-- telephone_work | character varying(50)    |           |          |
-- address_self   | character varying(50)    |           | not null |
-- address_work   | character varying(50)    |           | not null |
-- department_id  | bigint                   |           | not null |
-- position       | character varying(60)    |           | not null |
-- wages          | integer                  |           | not null |
-- university     | character varying(100)   |           |          |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
--Indexes:
--    "personnel_pkey" PRIMARY KEY, btree (id)
--Foreign-key constraints:
--    "department_id" FOREIGN KEY (department_id) REFERENCES departments(id) ON UPDATE CASCADE
	
	
--lenurb_db=# \d entities
--                                         Table "public.entities"
--     Column     |           Type           | Collation | Nullable |               Default
------------------+--------------------------+-----------+----------+--------------------------------------
-- id             | bigint                   |           | not null | nextval('entities_id_seq'::regclass)
-- name           | character varying(50)    |           | not null |
-- class          | character varying(50)    |           | not null |
-- description    | character varying(50)    |           | not null |
-- department_id  | bigint                   |           | not null |
-- supervisor_id  | bigint                   |           | not null |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
--Indexes:
--    "entities_pkey" PRIMARY KEY, btree (id)
	
	
--lenurb_db=# \d instructions
--                                         Table "public.instructions"
--     Column     |           Type           | Collation | Nullable |                 Default
------------------+--------------------------+-----------+----------+------------------------------------------
-- id             | bigint                   |           | not null | nextval('instructions_id_seq'::regclass)
-- name           | text                     |           | not null |
-- description    | text                     |           | not null |
-- entitie_id     | bigint                   |           | not null |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
-- properties     | json                     |           |          | '{}'::json
--Indexes:
--    "instructions_pkey" PRIMARY KEY, btree (id)
	
	
--lenurb_db=# \d events_log
--                                Table "public.events_log"
--     Column     |           Type           | Collation | Nullable |       Default
------------------+--------------------------+-----------+----------+----------------------
-- uid            | uuid                     |           | not null | uuid_generate_v4()
-- name           | text                     |           | not null |
-- class          | events_class             |           | not null |
-- entitie_id     | bigint                   |           | not null |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
-- properties     | json                     |           |          | '{}'::json
--Indexes:
--    "events_log_pkey" PRIMARY KEY, btree (uid)
	

--lenurb_db=# \d tasks
--                                    Table "public.tasks"
--       Column       |           Type           | Collation | Nullable |       Default
----------------------+--------------------------+-----------+----------+----------------------
-- uid                | uuid                     |           | not null | uuid_generate_v4()
-- name               | text                     |           | not null |
-- class              | character varying(50)    |           | not null |
-- type               | character varying(50)    |           | not null |
-- description        | text                     |           | not null |
-- location           | character varying(50)    |           | not null |
-- due_date           | date                     |           | not null |
-- priority           | task_priority            |           | not null |
-- status             | task_status              |           | not null |
-- supervisor_id      | bigint                   |           | not null |
-- assigned_id        | bigint                   |           |          |
-- task_department_id | bigint                   |           | not null |
-- time_stamp_gen     | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
--Indexes:
--    "tasks_pkey" PRIMARY KEY, btree (uid)
	
	
--lenurb_db=# \d incidents
--                                Table "public.incidents"
--     Column     |           Type           | Collation | Nullable |       Default
------------------+--------------------------+-----------+----------+----------------------
-- uid            | uuid                     |           | not null | uuid_generate_v4()
-- name           | text                     |           | not null |
-- instruction_id | bigint                   |           | not null |
-- task_id        | uuid                     |           | not null |
-- supervisor_id  | bigint                   |           | not null |
-- description    | character varying(350)   |           | not null |
-- time_stamp_gen | timestamp with time zone |           | not null | CURRENT_TIMESTAMP(0)
-- properties     | json                     |           |          | '{}'::json
--Indexes:
--    "incidents_pkey" PRIMARY KEY, btree (uid)


--- Создаем таблицы:
DROP TABLE IF EXISTS departments ;

create table departments (
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        location VARCHAR(50) NOT NULL,
        director_id BIGINT,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
		CONSTRAINT departments_director_id_key UNIQUE (director_id);
);



DROP TABLE IF EXISTS personnel ;

create table personnel (
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        surname VARCHAR(50) NOT NULL,
        gender VARCHAR(50) NOT NULL,
        birthday DATE NOT NULL,
        marriage VARCHAR(50) NOT NULL,
        email VARCHAR(60) NOT NULL,
        telephone_self VARCHAR(50) NOT NULL,
        telephone_work VARCHAR(50),
        address_self VARCHAR(50) NOT NULL,
        address_work VARCHAR(50) NOT NULL,
        department_id BIGINT NOT NULL,
        position VARCHAR(60) NOT NULL,
        wages INT NOT NULL,
        university VARCHAR(100),
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
        CONSTRAINT department_id
    FOREIGN KEY (department_id)
    REFERENCES departments (id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
	
	
	
DROP TABLE IF EXISTS entities ;

create table entities (
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        class VARCHAR(50) NOT NULL,
        description VARCHAR(50) NOT NULL,
        department_id BIGINT NOT NULL,
        supervisor_id BIGINT NOT NULL,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0)
);


	
DROP TABLE IF EXISTS instructions ;

create table instructions (
        id BIGSERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        entitie_id BIGINT NOT NULL,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
        properties JSON DEFAULT '{}'::json
);



DROP TABLE IF EXISTS events_log ;

create table events_log (
        uid UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        name TEXT NOT NULL,
        class events_class NOT NULL,
        entitie_id BIGINT NOT NULL,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
        properties JSON DEFAULT '{}'::json
);


DROP TABLE IF EXISTS tasks ;

create table tasks (
        uid UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        name TEXT NOT NULL,
        class VARCHAR(50) NOT NULL,
        type VARCHAR(50) NOT NULL,
        description TEXT NOT NULL,
        location VARCHAR(50) NOT NULL,
        due_date DATE NOT NULL,
        priority task_priority NOT NULL,
        status task_status NOT NULL,
        supervisor_id BIGINT NOT NULL,
        assigned_id BIGINT,
        task_department_id BIGINT NOT NULL,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0)
);



DROP TABLE IF EXISTS incidents ;

create table incidents (
        uid UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        name TEXT NOT NULL,
        instruction_id BIGINT NOT NULL,
        task_id UUID NOT NULL,
        supervisor_id BIGINT NOT NULL,
        description VARCHAR(350) NOT NULL,
        time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
        properties JSON DEFAULT '{}'::json
);

---*********************************************************---
---*********************************************************---
---*********************************************************---


--- Переводим выбранных случайным образом сотрудников на руководящие должности (перед этим мы внесли изменения в departments):
--- создаем функцию, которая проходится по всем департаментам, и для каждого из начальников меняет в таблице personnel 
--- данные о департаменте и должности   

DROP FUNCTION updatePersons;
CREATE FUNCTION updatePersons() RETURNS void AS $$
DECLARE
  iid bigint;
BEGIN 
FOR iid IN SELECT id FROM departments
LOOP
	UPDATE personnel
	SET department_id = iid,
		position = dep.name
	from (SELECT  name, director_id FROM departments WHERE id = iid) AS dep
	WHERE personnel.id = dep.director_id;
END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT updatePersons();

---*********************************************************---
---*********************************************************---
---*********************************************************---


--- Проверим, что все сделали правильно:
SELECT personnel.id, departments.director_id,  personnel.department_id, personnel."position",  departments.name
	FROM public.personnel
	LEFT JOIN departments
	ON personnel.id = departments.director_id
	WHERE personnel.id IN (SELECT director_id FROM departments)
	ORDER BY personnel.id;

---*********************************************************---
---*********************************************************---
---*********************************************************---


--- Создаем нового пользователя, не инсертим в таблицу id и time_stamp_gen, так как они генерируются сами
INSERT INTO public.personnel(
	name, surname, gender, birthday, marriage, email, telephone_self, telephone_work, address_self, address_work, department_id, "position", wages, university)
	VALUES ('Настя', 'Аникейчик', 'F', '2001-11-21', false, 'a.anikeychik@lenurb.ru', '79522886378', '79522886378', 'Санкт-Петербург', 'Санкт-Петербург', '2', 'Стажер', '16500', 'Санкт-Петербургский государственный технологический институт (технический университет)');

---ВЫВОД:	
lenurb_db=# select * from personnel where email = 'a.anikeychik@lenurb.ru';

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Получение статистики по всем задачам в разрезе Приоритета и Стасута:
SELECT priority, status, count(*)
	FROM public.tasks
GROUP BY priority, status
ORDER BY priority, status;

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Выборка по самым не продуктивным департаментам, где больше всего не закрытых задач:
WITH directors AS (
	SELECT name, surname, email, department_id FROM personnel WHERE id IN (SELECT director_id FROM departments)
),
nonresove AS (
	SELECT count(*) AS Non_relosve, task_department_id
	FROM public.tasks tsk
	WHERE status IN ('open', 'pending', 'in progress')
	AND assigned_id is null
	GROUP BY task_department_id
	ORDER BY count(*) DESC
)
SELECT Non_relosve, task_department_id, name, surname, email
FROM nonresove
LEFT JOIN directors
ON nonresove.task_department_id = directors.department_id
ORDER BY Non_relosve DESC

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Выборка инженеров, у которых заробатная плата выше 90 000 руб.:
SELECT id, name, surname, gender, birthday, marriage, email, telephone_self, telephone_work, address_self, address_work, department_id, "position", wages, university, time_stamp_gen
  FROM public.personnel
  WHERE wages > 90000
  AND "position" = 'Engineering'

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Выборка логов, у которых класс "Бедствие":
SELECT uid, name
  FROM public.events_log
  WHERE class = 'DISASTER'

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Выборка финансовых сущностей, у которых ID департамента от 15 до 20:
SELECT id, name
  FROM public.entities
WHERE description = 'Finance'
AND department_id BETWEEN 15 and 20

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Выборка задач, у которых статус "в ожиданни" и высокий приоритет:
SELECT name, location
  FROM public.tasks
  WHERE status = 'pending'
  AND priority = 'high'

---*********************************************************---
---*********************************************************---
---*********************************************************---

--- Объединение общих атрибутов из таблиц events_log, enteties, departments и personnel
SELECT events_log.uid AS events_UUID, events_log.name AS event_name,
  entities.name AS entitie_name, departments.name AS department_name, departments.location AS department_location,
  personnel.name AS supervisor_name, personnel.surname AS supervisor_surname
  FROM public.events_log
  LEFT JOIN public.entities 
  ON events_log.entitie_id = entities.id
  LEFT JOIN public.departments
  ON entities.department_id = departments.id
  LEFT JOIN personnel
  ON entities.supervisor_id = personnel.id