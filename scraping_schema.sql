
CREATE TABLE students
(
	id INTEGER PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255)
);

CREATE TABLE index_info
(
	id INTEGER PRIMARY KEY,
	students_id INTEGER,
	FOREIGN KEY(students_id) REFERENCES student(id),
	picture TEXT,
	tagline VARCHAR(255),
	bio VARCHAR(255)
);

CREATE TABLE profile_info
(
	id INTEGER PRIMARY KEY,
	students_id INTEGER,
	FOREIGN KEY(students_id) REFERENCES student(id),
	picture TEXT,
	tagline VARCHAR(255),
	bio TEXT,
	email VARCHAR(255),
	blog VARCHAR(255),
	linkedin VARCHAR(255),
	twitter VARCHAR(255),
	github VARCHAR(255),
	codeschool VARCHAR(255),
	coderwall VARCHAR(255),
	stackoverflow VARCHAR(255),
	treehouse VARCHAR(255),
	fav_app1_name VARCHAR(255),
	fav_app1_description VARCHAR(255),
	fav_app2_name VARCHAR(255),
	fav_app2_description VARCHAR(255),
	fav_app3_name VARCHAR(255),
	fav_app3_description VARCHAR(255),

);