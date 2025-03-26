# Pizza Sales Analysis

This project analyzes pizza sales data using MySQL queries to extract insights such as total revenue, most ordered pizzas, sales distribution, and revenue trends.

## Dataset
The project consists of the following CSV files:
- `orders.csv` – Contains order details with timestamps.
- `order_details.csv` – Contains pizza quantities and order references.
- `pizzas.csv` – Provides pizza pricing and size information.
- `pizza_types.csv` – Defines pizza categories and names.

## SQL Queries Included
The `pizza_sales_queries.sql` file contains queries divided into three levels:

### Basic Queries
1. Retrieve the total number of orders placed.
2. Calculate total revenue from pizza sales.
3. Identify the highest-priced pizza.
4. Find the most common pizza size ordered.
5. List the top 5 most ordered pizza types with their quantities.

### Intermediate Queries
6. Determine total quantity of each pizza category ordered.
7. Analyze order distribution by hour of the day.
8. Find category-wise distribution of pizzas.
9. Calculate the average number of pizzas ordered per day.
10. Identify the top 3 most ordered pizza types based on revenue.

### Advanced Queries
11. Compute percentage contribution of each pizza type to total revenue.
12. Analyze cumulative revenue generated over time.
13. Identify the top 3 most ordered pizza types by revenue for each category.

## How to Use
1. Clone the repository:
   ```sh
   git clone https://github.com/yogesh43221/Analyzing-Pizza-Sales-Trends-with-SQL-and-Power-BI/tree/main.git
   ```
2. Import the dataset into MySQL.
3. Run the SQL script in MySQL:
   ```sh
   mysql -u your_username -p your_database < pizza_sales_queries.sql
   ```
4. Analyze the output to gain insights into pizza sales performance.

## Requirements
- MySQL Server
- Dataset in CSV format (provided)

## Author
[Yogesh Jadhav](https://github.com/yogesh43221)

Feel free to contribute or raise issues!

