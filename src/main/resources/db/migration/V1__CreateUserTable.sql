CREATE TABLE IF NOT EXISTS users(
    id BIGINT PRIMARY KEY NOT NULL,
    username varchar(50) NOT NULL UNIQUE,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(255) NOT NULL UNIQUE

)