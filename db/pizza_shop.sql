DROP TABLE IF EXISTS pizza_orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE pizza_orders (
  id SERIAL8 PRIMARY KEY,
  quantity INT2,
  topping VARCHAR(255),
  customer_id INT8 REFERENCES customers(id)
);
