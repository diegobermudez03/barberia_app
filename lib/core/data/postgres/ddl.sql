CREATE TABLE "USER" (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age NUMERIC(2, 0)
);

CREATE TABLE "APPOINTMENT" (
    appointment_id SERIAL PRIMARY KEY,
    appointment_date TIMESTAMP NOT NULL,
    appointment_time TIMESTAMP NOT NULL,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES "USER" (user_id)
);
