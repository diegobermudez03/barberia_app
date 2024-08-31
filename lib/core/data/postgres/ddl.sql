CREATE TABLE USERS (
    user_id SERIAL PRIMARY KEY,
    cedula numeric(10,0) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age NUMERIC(2, 0)
);

CREATE TABLE APPOINTMENTS (
    appointment_id SERIAL PRIMARY KEY,
    appointment_date TIMESTAMP NOT NULL,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES USERS (user_id)
);
