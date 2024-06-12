-- Create the salon database
CREATE DATABASE salon;

-- Connect to the salon database
\c salon;

-- Create the customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR,
    phone VARCHAR UNIQUE
);

-- Create the services table
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR
);

-- Create the appointments table
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    service_id INT REFERENCES services(service_id),
    time VARCHAR
);

-- Insert at least three rows into the services table
INSERT INTO services (name) VALUES
    ('cut'),
    ('color'),
    ('perm');
