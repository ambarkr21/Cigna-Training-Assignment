-- Create tables
CREATE TABLE Products (
    product_id integer PRIMARY KEY ,
    product_name VARCHAR2(20) NOT NULL,
    price integer CHECK (price >0),
    qty integer DEFAULT 0 CHECK (qty>=0)
);

CREATE TABLE Customers(
    customer_id integer PRIMARY KEY,
    customer_name VARCHAR2(20) NOT NULL,
    email varchar2(50) NOT NULL,
    phone varchar2(15) NOT NULL
);

CREATE TABLE Orders(
    order_id INTEGER PRIMARY KEY,
    customer_id integer,
    order_date DATE DEFAULT SYSDATE,
    order_amt INTEGER CHECK (order_amt>0),
    constraint fk_a FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails(
    order_details_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    qty INTEGER CHECK (qty>0),
    constraint fk_b FOREIGN KEY (product_id) REFERENCES Products(product_id),
    constraint fk_c FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Inserting products
INSERT INTO Products (product_id, product_name, price, qty) VALUES
(1, 'Laptop', 999, 10),
(2, 'Smartphone', 499, 20);

-- Inserting customers
INSERT INTO Customers (customer_id, customer_name, email, phone) VALUES
(1, 'John', 'john@example.com', '+919765544329'),
(2, 'Smith', 'smith@gmail.com', '+919082345674');

-- Inserting orders
INSERT INTO Orders (order_id, customer_id, order_date, order_amt) VALUES
(1, 1, TO_DATE('2025-01-10','YYYY-MM-DD'), 5000),
(2, 2, TO_DATE('2025-01-09','YYYY-MM-DD'), 20000);

-- Inserting order details
INSERT INTO OrderDetails (order_details_id, order_id, product_id, qty) VALUES
(1, 1, 1, 50),
(2, 2, 2, 100);

https://onecompiler.com/oracle/43zm2ceym
