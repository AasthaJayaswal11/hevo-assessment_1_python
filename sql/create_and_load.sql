-- create schema
CREATE SCHEMA IF NOT EXISTS hevo AUTHORIZATION postgres;
SET search_path = hevo;

-- tables
CREATE TABLE IF NOT EXISTS customers (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  email VARCHAR,
  address JSON
);

CREATE TABLE IF NOT EXISTS orders (
  id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  status VARCHAR
);

CREATE TABLE IF NOT EXISTS feedback (
  id INTEGER PRIMARY KEY,
  order_id INTEGER,
  feedback_comment TEXT,
  rating INTEGER
);

-- load CSVs from /tmp
COPY hevo.customers FROM '/tmp/customers.csv' WITH (FORMAT csv, HEADER true);
COPY hevo.orders    FROM '/tmp/orders.csv'    WITH (FORMAT csv, HEADER true);
COPY hevo.feedback  FROM '/tmp/feedback.csv'  WITH (FORMAT csv, HEADER true);

-- counts for verification
SELECT 'customers', COUNT(*) FROM hevo.customers;
SELECT 'orders', COUNT(*) FROM hevo.orders;
SELECT 'feedback', COUNT(*) FROM hevo.feedback;
