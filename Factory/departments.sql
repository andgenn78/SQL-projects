DROP TABLE IF EXISTS departments ;

create table departments (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	location VARCHAR(50) NOT NULL,
	director_id BIGINT,
	time_stamp_gen timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0)
);
insert into departments (name, location) values ('Sales', 'Burenhayrhan');
insert into departments (name, location) values ('Support', 'Salinggara');
insert into departments (name, location) values ('Human Resources', 'Masis');
insert into departments (name, location) values ('Training', 'Randuagung');
insert into departments (name, location) values ('Engineering', 'Fuerte');
insert into departments (name, location) values ('Accounting', 'Ninos Heroes');
insert into departments (name, location) values ('Engineering', 'Lam Thao');
insert into departments (name, location) values ('Sales', 'Duc Trong');
insert into departments (name, location) values ('Services', 'Dampit Satu');
insert into departments (name, location) values ('Business Development', 'Leeuwarden');
insert into departments (name, location) values ('Marketing', 'Quanzhou');
insert into departments (name, location) values ('Accounting', 'Tawangrejo');
insert into departments (name, location) values ('Marketing', 'Made');
insert into departments (name, location) values ('Accounting', 'Rolandia');
insert into departments (name, location) values ('Marketing', 'Lingdong');
insert into departments (name, location) values ('Support', 'Liwale');
insert into departments (name, location) values ('Marketing', 'Tromso');
insert into departments (name, location) values ('Research and Development', 'Reinaldes');
insert into departments (name, location) values ('Marketing', 'Koundara');
insert into departments (name, location) values ('Training', 'Javhlant');
