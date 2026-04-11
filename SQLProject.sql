CREATE DATABASE EcommerceDB;

USE EcommerceDB;

--================================  | DDL | ===================================
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    role_id INT,
    phone VARCHAR(20),
    email VARCHAR(100),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE UserRole (
    id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50)
);

CREATE TABLE Categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE Products (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(150),
    category_id INT,
    price DECIMAL(10,2),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE Orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    total_amount DECIMAL(10,2), --مجموع الطلب كاملاً
    status VARCHAR(30),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE OrderItems (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2) --سعر كل منتج وقت الشراء
); 

CREATE TABLE Carts (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE CartItems (
    id INT PRIMARY KEY IDENTITY(1,1),
    cart_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE Wishlist (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE Discount (
    id INT PRIMARY KEY IDENTITY(1,1),
    coupon_code VARCHAR(50),
    product_id INT,
    start_date DATETIME,
    end_date DATETIME,
    discount_value FLOAT,
    status VARCHAR(20)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    rating INT,
    comment VARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

CREATE TABLE Payments (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    status VARCHAR(20),
    transaction_date DATETIME,
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);

-- Users
USE EcommerceDB;

ALTER TABLE Users
ADD CONSTRAINT FK_Users_UserRole
FOREIGN KEY (role_id) REFERENCES UserRole(id);

-- Products
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (category_id) REFERENCES Categories(id);

-- Orders
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Users
FOREIGN KEY (user_id) REFERENCES Users(id);

-- OrderItems
ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY (order_id) REFERENCES Orders(id);

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

-- Carts
ALTER TABLE Carts
ADD CONSTRAINT FK_Carts_Users
FOREIGN KEY (user_id) REFERENCES Users(id);

-- CartItems
ALTER TABLE CartItems
ADD CONSTRAINT FK_CartItems_Carts
FOREIGN KEY (cart_id) REFERENCES Carts(id);

ALTER TABLE CartItems
ADD CONSTRAINT FK_CartItems_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

-- Wishlist
ALTER TABLE Wishlist
ADD CONSTRAINT FK_Wishlist_Users
FOREIGN KEY (user_id) REFERENCES Users(id);

ALTER TABLE Wishlist
ADD CONSTRAINT FK_Wishlist_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

-- Discount
ALTER TABLE Discount
ADD CONSTRAINT FK_Discount_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

-- Reviews
ALTER TABLE Reviews
ADD CONSTRAINT FK_Reviews_Users
FOREIGN KEY (user_id) REFERENCES Users(id);

ALTER TABLE Reviews
ADD CONSTRAINT FK_Reviews_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

-- Payments
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Orders
FOREIGN KEY (order_id) REFERENCES Orders(id);

--================================  | DML | ===================================

use EcommerceDB;

---userRole
insert into UserRole (role_name)
values ('Admin'); --id =1 ==admin

insert into UserRole (role_name)
values ('Customer'); --id =2 ==customer


---users

insert into Users (name, role_id, phone, email)
values ('yousef',2,780487794,'yousef@gmail.com');

insert into Users (name, role_id, phone, email)
values  ('Admin',1,780487794,'admin@gmail.com');

insert into Users (name, role_id, phone, email)
values  ('Ahmad',2,780487794,'ahmad@gmail.com');

insert into Users (name, role_id, phone, email)
values  ('Ali',2,780487794,'ali@gmail.com');

---categories

insert into Categories (category_name) 
values ('Electronics');

insert into Categories (category_name)
values ('Books');

insert into Categories (category_name)
values ('Clothing');

insert into Categories (category_name)
values ('Home & Kitchen');

---products

insert into Products (product_name, category_id, price)
values ('Smartphone', 1, 699.99);

insert into Products (product_name, category_id, price)
values ('Laptop', 1, 400.00);

insert into Products (product_name, category_id, price)
values ('Data base in cs', 2, 199.99);

insert into Products (product_name, category_id, price)
values ('T-shirt', 3, 19.99);

insert into Products (product_name, category_id, price)
values ('Blender', 4, 50.00);

update  Products set price=23.00 , 
updatedAt=GETDATE()
where id=3 and category_id=2

insert into Products (product_name, category_id, price)
values ('Headphones', 1, 149.99);

insert into Products (product_name, category_id, price)
values ('C++', 2, 7.00);

insert into Products (product_name, category_id, price)
values ('Jeans', 3, 10.00);


---orders

insert into Orders (user_id, total_amount, status)
values (1, 500.22, 'Pending');

insert into Orders (user_id, total_amount, status)
values (3, 150.00, 'Completed');

insert into Orders (user_id, total_amount, status)
values (4, 200.00, 'Processing');

---orderItems

insert into OrderItems (order_id, product_id, quantity, price)
values (1, 1, 1, 699.99);

insert into OrderItems (order_id, product_id, quantity, price)
values (1, 2, 1, 400.00);

insert into OrderItems (order_id, product_id, quantity, price)
values (2, 3, 1, 23.00);

insert into OrderItems (order_id, product_id, quantity, price)
values (3, 4, 2, 19.99);

---carts

insert into Carts (user_id)
values (1);

insert into Carts (user_id)
values (3);

insert into Carts (user_id)
values (4);

---cartItems

insert into CartItems (cart_id, product_id, quantity)
values (1, 5, 1);

insert into CartItems (cart_id, product_id, quantity)
values (2, 6, 2);

insert into CartItems (cart_id, product_id, quantity)
values (3, 7, 1);

---wishlist

insert into Wishlist (user_id, product_id)
values (1, 5);

insert into Wishlist (user_id, product_id)
values (3, 4);

insert into Wishlist (user_id, product_id)
values (4, 1);

---discount
insert into Discount (coupon_code, product_id, start_date, end_date, discount_value, status)
values ('SAVE20', 1, '2025-04-01', '2025-04-30', 20.00, 'Active');

insert into Discount (coupon_code, product_id, start_date, end_date, discount_value, status)
values ('BOOKS10', 3, '2024-03-01', '2024-03-31', 10.00, 'Inactive');

---reviews
insert into Reviews (user_id, product_id, rating, comment)
values (1, 1, 5, 'Great smartphone');

insert into Reviews (user_id, product_id, rating, comment)
values (3, 3, 4, 'Good book for learning');

insert into Reviews (user_id, product_id, rating, comment)
values (4, 4, 3, 'Average quality');

---payments
insert into Payments (order_id, payment_method, amount, status, transaction_date)
values (1, 'Credit Card', 500.22, 'Completed', getdate());

insert into Payments (order_id, payment_method, amount, status, transaction_date)
values (2, 'PayPal', 150.00, 'pending','2026-01-15');


----insert into Orders (user_id, total_amount, status)
---values (4, 200.00, 'Processing');
USE EcommerceDB;

update Orders set status='Completed' , UpdatedAt='2026-04-01' where user_id=4 and total_amount=200.00

select avg(rating) as AverageRating from Reviews where product_id=1


update OrderItems set quantity=3  where order_id=3 ;

select sum(quantity) as total from OrderItems where order_id=3;

select u.id  , u.email , ur.role_name from   Users u  inner join UserRole ur on u.role_id=ur.id;

select p.product_name , c.category_name from Products p inner join Categories c on p.category_id=c.id where p.price > 10.00;


select  p.product_name , p.price from Products p order by p.price desc;

select p.product_name , r.comment , r.user_id  from Products p left join Reviews r on p.id=r.product_id 


update Users   set IsDeleted=1 , UpdatedAt=GETDATE() where name='Ali';

select r.product_id , avg(r.rating) from Reviews r group by product_id ;

select o.order_id , sum(o.quantity) as totalItems   from OrderItems o group by o.order_id;

select o.id , sum(o.total_amount  )  from Orders o  group by o.id

select   p.category_id , count(*)  from  Products p group by p.category_id 

select  u.name ,count(o.id)  from Users u  inner join Orders o on u.id=o.user_id group by u.name

select  o.product_id , sum( o.quantity) as totalSold from OrderItems o group by o.product_id order by totalSold desc;

----==================Scenario 1 Get all orders with user information
---Users → Orders → OrderItems → Products
USE EcommerceDB;

select u.name  , u.phone ,u.email , o.id as orderId  , oi.product_id , oi.quantity ,p.product_name , oi.price
from Users u
inner join Orders o on u.id=o.user_id --user => orders
inner join OrderItems oi  on o.id=oi.order_id --orders => orderItems
inner join Products p on oi.product_id=p.id --orderItems => products

-----======Product Listing Scenario 2
update Products set  IsDeleted =1 , UpdatedAt=GETDATE() where id=4;
select p.product_name , p.price from Products p where p.IsDeleted=0


---===========⭐ Scenario 3: Product Ratings

select p.product_name , avg (r.rating )   from Products p  inner join Reviews r on p.id=r.product_id 
group by p.product_name
;


--=============Scenario 4: Wishlist :  Get all products in a specific user’s wishlist

select u.name ,p.product_name , w.id as WishlistId  from Users u  inner join Wishlist  w on 
u.id=w.user_id 
inner join Products p  on w.product_id=p.id
where u.name='yousef'  ;

--===============### Scenario 5: Sales Analysis Get total sales per user

select u.name , sum(o.total_amount) as TotalSales from Users u  inner join Orders o on u.id=o.user_id
group by u.name order by TotalSales desc;

--====================Scenario 6: Filtering Get products within a price range 

select p.product_name , p.price from Products p where p.price between 10.00 and 150.00 and p.IsDeleted=0

select p.product_name , p.price from Products p where p.product_name like 'c%' and p.IsDeleted=0

---==============Scenario 7: Recent Orders

select top 5 o.id as orderID , p.product_name from Orders o  inner join  products p on o.id=p.id
order by o.CreatedAt  desc;




-----
USE EcommerceDB;

alter table reviews add constraint CK_Rating check (rating between 1 and 5);

UPDATE Payments
SET status = 'Pending'
WHERE status = 'pending';

Update Orders set  status='Pending' where status='pending';
update Orders set status='Processing' where status='Processing';
update Orders set status='Completed' where status='Completed';

alter table orders add constraint CK_Status check (status in ('Pending', 'Processing', 'Completed', 'Cancelled'));

ALTER TABLE Products ADD CONSTRAINT CHK_Price CHECK (price > 0);

--UPDATE Users SET IsDeleted = 1 WHERE id = 1; 

---CASCADE
ALTER TABLE Orders
DROP CONSTRAINT FK_Orders_Users;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Users
FOREIGN KEY (user_id)
REFERENCES Users(id)
ON DELETE CASCADE;