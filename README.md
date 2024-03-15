# SQL Practice Assignment: Advanced Bookstore Database Analysis

## Database Overview: BookstoreDB

In this assignment, you will work with the `BookstoreDB`, an extended version of our initial database scenario. This database now includes six tables: `Authors`, `Books`, `Categories`, `Orders`, `Customers`, and `Reviews`. Your task is to write SQL queries to answer a series of questions that will test your skills in various SQL concepts, including joins, aggregate functions, subqueries, and the use of `GROUP BY` and `HAVING` clauses.

### Tables and Sample Records

### Authors Table

| Column    | Type          |
|-----------|---------------|
| author_id (PK) | SERIAL       |
| name      | VARCHAR(100)  |
| country   | VARCHAR(50)   |

### Categories Table

| Column       | Type         |
|--------------|--------------|
| category_id (PK) | SERIAL      |
| category_name | VARCHAR(50)  |

### Books Table

| Column         | Type          |
|----------------|---------------|
| book_id (PK)   | SERIAL        |
| title          | VARCHAR(100)  |
| author_id (FK) | INT           |
| category_id (FK)| INT           |
| price          | DECIMAL(10,2) |
| publication_year| INT          |

### Orders Table

| Column      | Type         |
|-------------|--------------|
| order_id (PK) | SERIAL       |
| book_id (FK) | INT          |
| customer_id (FK)| INT          |
| quantity    | INT          |
| order_date  | DATE         |

### Customers Table

| Column      | Type         |
|-------------|--------------|
| customer_id (PK) | SERIAL       |
| name        | VARCHAR(100) |
| email       | VARCHAR(100) |
| join_date   | DATE         |

### Reviews Table

| Column      | Type         |
|-------------|--------------|
| review_id (PK) | SERIAL       |
| book_id (FK) | INT          |
| customer_id (FK)| INT          |
| rating      | INT          |
| comment     | TEXT         |
| review_date | DATE         |



### Insert Sample Data - 5 records for each table

Using the provided SQL commands, insert the sample data into the respective tables of your `BookstoreDB`. This will set up a rich dataset that you can query to practice and enhance your SQL skills. Remember to check the relationships between tables to ensure the integrity of your database as you insert the data.


### Assignment Questions

1. **How many books are available in each category?**

2. **Which author has the highest average book rating according to customer reviews?**

3. **What is the total revenue generated from all orders for each author's books?**

4. **List the top 5 best-selling books (in terms of quantity sold), including their titles and total quantities sold.**

5. **Which customer has placed the most orders, and how many orders have they placed?**

6. **Find the average price of books in each category, and list them from highest to lowest average price.**

7. **How many customers joined in each year? Use the `join_date` from the `Customers` table for your calculation.**

8. **What is the total number of books sold in each category?**

9. **Which book has received the highest number of reviews, and what is the average rating of that book?**

10. **For each category, find the book with the highest price. List the category name, book title, and price.**

11. **List all authors who have not had any of their books ordered.**

12. **What is the average rating of books for each category, and how does it compare to the overall average rating across all categories?**

13. **Identify customers who have placed orders totaling more than $100. List their names and the total amount spent.**

14. **Which month of the year has seen the highest number of books sold?**

15. **Find all books that have never been reviewed. List their titles and publication years.**

### Instructions

- Ensure your SQL queries are well-formatted and commented for clarity.
- For questions involving calculations (e.g., averages, totals), round your results to two decimal places where applicable.
- When ordering results, specify the direction (ASC for ascending, DESC for descending) where it makes sense to do so.
- Consider the relationships between tables carefully when writing your queries, especially for questions that require data from multiple tables.

This assignment is designed to challenge your SQL skills and deepen your understanding of database analysis. Good luck!
