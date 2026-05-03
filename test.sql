DROP TABLE Order_Line;
DROP TABLE Product_T;
DROP TABLE Order_T;
DROP TABLE Customer_T;

CREATE TABLE CUSTOMER_T(CustomerID NUMBER(11, 0) NOT NULL,
    CustomerName VARCHAR2(30) NOT NULL,
    CustomerAddress VARCHAR2(30),
    CustomerCity VARCHAR2(30),
    CustomerState CHAR(2),
    CustomerPostalCode NUMBER(11,0),
    CONSTRAINT Customer_PK PRIMARY KEY(CustomerID));

CREATE TABLE Order_T(OrderID NUMBER(11, 0) NOT NULL, 
OrderDate DATE DEFAULT SYSDATE,
CustomerID NUMBER(11,0),

--REVIEW Primary key does not reference themselve, no REFERENCES
CONSTRAINT Order_PK PRIMARY KEY (OrderID), 
CONSTRAINT Order_FK FOREIGN KEY (CustomerID) REFERENCES CUSTOMER_T(CustomerID));


CREATE TABLE Product_T(Product_ID NUMBER(11, 0) NOT NULL,
Product_Discription VARCHAR2(30),
Product_Finish VARCHAR2(30),
        --REVIEW Domain Constraint
        CHECK (Product_Finish IN ('Cherry', 'Natural Ash', 'White Ash', 'Red Oak', 
        'Natural Oak', 'Walnut')),
Standard_Price DECIMAL(6, 2),
CONSTRAINT Product_PK PRIMARY KEY(Product_ID));

CREATE TABLE Order_Line(Product_ID NUMBER(11,0) NOT NULL,
                        OrderID NUMBER(11, 0) NOT NULL,
                        Quantity NUMBER(20, 0),

--REVIEW COMPOSITE PRIMARY KEYCHECK #No references. Primary key does not reference themselve, no REFERENCES
CONSTRAINT OrderLine_PK PRIMARY KEY(Product_ID, OrderID),

CONSTRAINT OrderLine_FK1 FOREIGN KEY(Product_ID) REFERENCES Product_T(Product_ID),
CONSTRAINT OrderLine_FK2 FOREIGN KEY(OrderID) REFERENCES Order_T(OrderID));

INSERT INTO CUSTOMER_T VALUES(1, 'Fatma', 'Ahmed Hassan St.', 'Fisal', 'EG', 2432);

INSERT INTO CUSTOMER_T VALUES(2, 'Basma Store', '123 SQL Lane', 'Cairo', 'EG', '12345');

INSERT INTO CUSTOMER_T VALUES(3, 'Mohamed Store', 'Fisal St', 'Giza', 'EG', '24321');



INSERT INTO Order_T (ORDERID, CUSTOMERID) VALUES(1, 1);
INSERT INTO Order_T (ORDERID, CUSTOMERID) VALUES(2, 2);
INSERT INTO Order_T (ORDERID, CUSTOMERID) VALUES(3, 3);


INSERT INTO Product_T VALUES(1, 'Aroma', 'Natural Oak', 34.5);

INSERT INTO PRODUCT_T VALUES (2, 'Lip Stick1', 'Cherry', 50.00);
INSERT INTO PRODUCT_T VALUES (3, 'Lip Stick2', 'Cherry', 70.00);

INSERT INTO Order_Line VALUES(1, 1, 3);
INSERT INTO Order_Line VALUES(2,2,2);
INSERT INTO Order_Line VALUES(3, 3, 5);

COMMIT;

--IMPORTANT PART-- ANALYTICS QUERIES -- 
--1.Showing all Customers and their Orders

--defines which columns we want to see.
SELECT CustomerName, OrderID, OrderDate
     --The Src table --the connection table, JOIN combine the src with the connec.
     --BY ON: look at the Primary Key (PK - CustID) in the parent(CuST_T) table  and match it to the Foreign Key (FK - CUSTID) in the child table(ORDER_T).
FROM Customer_T
JOIN Order_T ON Customer_T.CustomerID = Order_T.CustomerID;


SELECT Order_Line.OrderID,
        SUM(Order_Line.Quantity * Product_T.Standard_Price) AS Total_Price
FROM Order_Line
JOIN Product_T ON Order_Line.Product_ID = Product_T.Product_ID
GROUP BY Order_Line.OrderID;


SELECT * FROM CUSTOMER_T;
SELECT * FROM Order_T;
SELECT * FROM Order_Line;
SELECT * FROM Product_T;

