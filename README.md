# E-Commerce Sales Analysis – MySQL

## Project objective
This beginner-level Data Analyst project uses SQL to explore an e-commerce database and answer simple business questions about customers, products, orders and sales.

## Tools used
- MySQL 8.0+
- MySQL Workbench

## Database tables
- `customers`: customer details
- `products`: product names, categories, prices and stock
- `orders`: customer orders and order dates
- `order_items`: products and quantities included in each order

## How to run
1. Open MySQL Workbench and connect to your MySQL server.
2. Open `queries/ecommerce_analysis_mysql.sql`.
3. Run the script using the lightning button.
4. Refresh the Schemas panel and open `ecommerce_sales`.
5. Run the analysis queries again one by one when taking screenshots.

## SQL concepts covered
- SELECT, WHERE and ORDER BY
- COUNT, SUM, AVG, MIN and MAX
- GROUP BY and HAVING
- INNER JOIN, LEFT JOIN and RIGHT JOIN
- Subqueries
- Views
- Indexes and EXPLAIN
- NULL value handling

## Notes
- The data in this project is sample data created for practice.
- Sales are calculated as `quantity * unit_price`.
- The script drops and recreates the project tables and views each time it is run. Do not run it in a database containing data you need to keep.
- Use MySQL Workbench, not SQLite, to run this file.

## Folder structure
```text
Ecommerce_SQL_MySQL_Project/
├── queries/
│   └── ecommerce_analysis_mysql.sql
├── database/
├── screenshots/
└── README.md
```
