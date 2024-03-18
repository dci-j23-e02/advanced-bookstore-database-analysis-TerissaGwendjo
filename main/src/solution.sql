CREATE TABLE Authors (
                         author_id SERIAL PRIMARY KEY,
                         name VARCHAR(255),
                         country VARCHAR(255)
);

/*name VARCHAR(100) means that the "name" column can hold strings of characters up to 100 characters in length.
country VARCHAR(50) means that the "country" column can hold strings of characters up to 50 characters in length.
This maximum length is a constraint on the data that can be stored in those columns. It ensures that the data inserted
into those columns does not exceed the specified length. It's a way to optimize storage and enforce data integrity
by preventing excessively long values from being inserted into those columns.*/

CREATE TABLE Categories (
                            category_id SERIAL PRIMARY KEY,
                            category_name VARCHAR(50)
);

CREATE TABLE Books (
                       book_id SERIAL PRIMARY KEY,
                       title VARCHAR(100),
                       author_id INT,
                       category_id INT,
                       price DECIMAL(10,2),
                       publication_year INT,
                       FOREIGN KEY (author_id) REFERENCES Authors(author_id),
                       FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100),
                           email VARCHAR(100),
                           join_date DATE
);

CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY,
                        book_id INT,
                        customer_id INT,
                        quantity INT,
                        order_date DATE,
                        FOREIGN KEY (book_id) REFERENCES Books(book_id),
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

--INSERTING

-- Insert values into Authors table
INSERT INTO Authors (name, country)
VALUES ('J.K. Rowling', 'United Kingdom'),
       ('George R.R. Martin', 'United States'),
       ('J.R.R. Tolkien', 'United Kingdom');

-- Insert values into Categories table
INSERT INTO Categories (category_name)
VALUES ('Fantasy'),
       ('Science Fiction'),
       ('Mystery'),
       ('Romance');

-- Insert values into Books table
INSERT INTO Books (title, author_id, category_id, price, publication_year)
VALUES ('Harry Potter and the Philosopher''s Stone', 1, 1, 15.99, 1997),
       ('A Game of Thrones', 2, 1, 19.99, 1996),
       ('The Hobbit', 3, 1, 12.99, 1937);

-- Insert values into Customers table
INSERT INTO Customers (name, email, join_date)
VALUES ('Alice Johnson', 'alice@example.com', '2023-01-15'),
       ('Bob Smith', 'bob@example.com', '2022-09-20'),
       ('Charlie Brown', 'charlie@example.com', '2023-03-10');

-- Insert values into Orders table
INSERT INTO Orders (book_id, customer_id, quantity, order_date)
VALUES (1, 1, 2, '2023-02-05'),
       (2, 2, 1, '2023-01-20'),
       (3, 3, 3, '2023-03-15');

-- Insert values into Reviews table
INSERT INTO Reviews (book_id, customer_id, rating, comment, review_date)
VALUES (1, 1, 5, 'Great book!', '2023-02-10'),
       (2, 2, 4, 'Enjoyed it.', '2023-01-25'),
       (3, 3, 5, 'Classic!', '2023-03-20');


--Assignment Questions

-- 1.) How many books are available in each category?
SELECT c.category_name, COUNT(b.book_id) AS book_count
FROM Categories c
         LEFT JOIN Books b ON c.category_id = b.category_id
GROUP BY c.category_name;

-- 2.) Which author has the highest average book rating according to customer reviews?
SELECT a.name AS author_name, AVG(r.rating) AS avg_rating
FROM Authors a
         JOIN Books b ON a.author_id = b.author_id
         JOIN Reviews r ON b.book_id = r.book_id
GROUP BY a.name
ORDER BY avg_rating DESC
LIMIT 1;

-- 3.) What is the total revenue generated from all orders for each author's books?
SELECT a.name AS author_name, SUM(b.price * o.quantity) AS total_revenue
FROM Authors a
         JOIN Books b ON a.author_id = b.author_id
         JOIN Orders o ON b.book_id = o.book_id
GROUP BY a.name;

-- 4.) List the top 5 best-selling books (in terms of quantity sold), including their titles and total quantities sold.
SELECT b.title, SUM(o.quantity) AS total_quantity_sold
FROM Books b
         JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.title
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 5.) Which customer has placed the most orders, and how many orders have they placed?
SELECT c.name AS customer_name, COUNT(o.order_id) AS order_count
FROM Customers c
         JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY order_count DESC
LIMIT 1;

--OR
SELECT c.name AS customer_name, COUNT(o.order_id) AS order_count
FROM Customers c
         JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.quantity = (
    SELECT MAX(quantity) FROM Orders
)
GROUP BY c.name
ORDER BY order_count DESC;

--OR
SELECT c.name AS customer_name, COUNT(o.order_id) AS order_count
FROM Customers c
         JOIN (
    SELECT customer_id, SUM(quantity) AS total_quantity
    FROM Orders
    GROUP BY customer_id
    ORDER BY total_quantity DESC
    LIMIT 1
) AS top_customer ON c.customer_id = top_customer.customer_id
         JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

--6.) Find the average price of books in each category, and list them from highest to lowest average price.
SELECT c.category_name, AVG(b.price) AS avg_price
FROM Categories c
         JOIN Books b ON c.category_id = b.category_id
GROUP BY c.category_name
ORDER BY avg_price DESC;


-- 7.) How many customers joined in each year? Use the join_date from the Customers table for your calculation.
SELECT EXTRACT(YEAR FROM join_date) AS join_year, COUNT(customer_id) AS customer_count
FROM Customers
GROUP BY join_year
ORDER BY join_year;

-- 8.) What is the total number of books sold in each category?
SELECT c.category_name, SUM(o.quantity) AS total_books_sold
FROM Categories c
         JOIN Books b ON c.category_id = b.category_id
         JOIN Orders o ON b.book_id = o.book_id
GROUP BY c.category_name;

--9.) Which book has received the highest number of reviews, and what is the average rating of that book?
SELECT b.title, COUNT(r.review_id) AS review_count, AVG(r.rating) AS avg_rating
FROM Books b
         JOIN Reviews r ON b.book_id = r.book_id
GROUP BY b.title
ORDER BY review_count DESC
LIMIT 1;

-- 10.) For each category, find the book with the highest price. List the category name, book title, and price.
SELECT c.category_name, b.title, b.price
FROM Categories c
         JOIN Books b ON c.category_id = b.category_id
WHERE (b.price, b.category_id) IN
      (SELECT MAX(price), category_id FROM Books GROUP BY category_id);

-- 11.) List all authors who have not had any of their books ordered.
SELECT a.name AS author_name
FROM Authors a
         LEFT JOIN Books b ON a.author_id = b.author_id
WHERE b.book_id IS NULL;

-- 12.) What is the average rating of books for each category, and how does it compare to the overall average rating across all categories?
SELECT c.category_name, AVG(r.rating) AS avg_rating_category,
       (SELECT AVG(rating) FROM Reviews) AS avg_rating_overall
FROM Categories c
         JOIN Books b ON c.category_id = b.category_id
         JOIN Reviews r ON b.book_id = r.book_id
GROUP BY c.category_name;

-- 13.) Identify customers who have placed orders totaling more than $100. List their names and the total amount spent.
SELECT c.name AS customer_name, SUM(b.price * o.quantity) AS total_spent
FROM Customers c
         JOIN Orders o ON c.customer_id = o.customer_id
         JOIN Books b ON o.book_id = b.book_id
GROUP BY c.name
HAVING SUM(b.price * o.quantity) > 100;

-- 14.) Which month of the year has seen the highest number of books sold?
SELECT EXTRACT(MONTH FROM order_date) AS month, SUM(quantity) AS total_books_sold
FROM Orders
GROUP BY month
ORDER BY total_books_sold DESC
LIMIT 1;

-- 15.) Find all books that have never been reviewed. List their titles and publication years.
SELECT b.title, b.publication_year
FROM Books b
         LEFT JOIN Reviews r ON b.book_id = r.book_id
WHERE r.review_id IS NULL;