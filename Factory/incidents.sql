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