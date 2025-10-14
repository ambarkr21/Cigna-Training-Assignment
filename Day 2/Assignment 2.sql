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
    order_id INTEGER,
    product_id INTEGER,
    qty INTEGER CHECK (qty>0),
    constraint fk_b FOREIGN KEY (product_id) REFERENCES Products(product_id),
    constraint fk_c FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    constraint pk_a PRIMARY KEY(order_id,product_id)
);



