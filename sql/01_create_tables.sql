-- 01_create_tables.sql
-- Create core tables for CommerceConnect SQL Segmentation Pack

-- Customers table
CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    age             INT,
    region          VARCHAR(50),
    signup_date     DATE
);

-- Orders table
CREATE TABLE orders (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    order_date      DATE,
    total_amount    NUMERIC(10,2)
);

-- Payments table
CREATE TABLE payments (
    payment_id          SERIAL PRIMARY KEY,
    customer_id         INT REFERENCES customers(customer_id),
    payment_date        DATE,
    payment_due_date    DATE,
    amount_paid         NUMERIC(10,2)
);

-- Support tickets table
CREATE TABLE support_tickets (
    ticket_id       SERIAL PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    ticket_date     DATE,
    issue_type      VARCHAR(100)
);
