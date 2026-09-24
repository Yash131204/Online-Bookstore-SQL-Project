CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
PUblished_Year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE Table Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);



CREATE Table Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Retreive all books in the fiction genre 
SELECT * FROM Books WHERE Genre='Fiction';

-- Find books published after the year 1950 
SELECT * FROM Books WHERE Published_Year>1950;

List all customers from the canada
SELECT name FROM Customers WHERE country='Canada';

-- Show orders placed in november 2023
SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Retrieve the total stock of books available
SELECT SUM(stock) AS Total_Stock FROM Books;

-- Find the details of the most expensive books
SELECT * FROM Books ORDER BY Price DESC;

-- Show all customers who ordered more than one quantity of a book
SELECT * FROM Orders WHERE quantity>1;

-- Retreive all orders where the total amount exceeds $20:
SELECT * FROM Orders WHERE total_amount>20;

-- List all genres available in the books table 
SELECT DISTINCT genre FROM Books;

-- Find the book with the lowest stock:
SELECT * FROM Books ORDER BY stock;

-- Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS Revenue FROM Orders;

-- Retrieve the total number of books sold for each genre
SELECT b.genre,SUM(o.quantity) FROM Orders o JOIN Books b on o.book_id=b.book_id GROUP BY b.Genre;

-- Find the average price of books in the fantasy genre
SELECT AVG(price) AS Average_Price FROM Books WHERE genre='Fantasy'

-- List customers who have placed at least 2 orders
SELECT o.customer_id,c.name, COUNT(o.Order_id) AS ORDER_COUNT FROM orders o JOIN Customers c on o.customer_id=c.customer_id 
GROUP BY O.customer_id,c.name HAVING COUNT(order_id) >=2;

-- Find the most frequently ordered book:
SELECT o.book_id,b.title,COUNT(O.order_id) AS ORDER_COUNT FROM Orders o JOIN Books b ON o.book_id=b.book_id
GROUP BY o.book_id,b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- Show the top 3 most expensive books of fantasy genre:
SELECT * FROM Books WHERE genre='Fantasy' ORDER BY price DESC LIMIT 3;

-- Retreive the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold FROM orders o JOIN Books b ON o.book_id=b.book_id
GROUP BY b.author;

-- List the cities where customers who spent over $30 are located 
SELECT DISTINCT c.city,total_amount FROM orders o JOIN Customers c ON c.customer_id=o.customer_id
WHERE o.total_amount > 30;

-- Find the customer who spent the most on orders
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent FROM Orders o JOIN Customers c 
ON o.customer_id=c.customer_id GROUP BY c.customer_id, c.name 
ORDER BY Total_spent DESC LIMIT 1;

-- Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title,b.stock, COALESCE(SUM(o.quantity),0) AS Order_Quantity, 
b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity FROM books b LEFT JOIN orders o
ON b.book_id=o.book_id GROUP BY b.book_id;

--




--













