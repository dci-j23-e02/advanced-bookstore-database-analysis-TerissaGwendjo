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