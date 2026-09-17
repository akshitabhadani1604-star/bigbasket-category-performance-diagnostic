# AI-Assisted Prompting Log

## Prompt 1 — SQL Reporting Query

### Role
Act as a SQL analyst experienced with SQLite and retail/e-commerce reporting.

### Context
I am completing a BigBasket category performance diagnostic using a deterministic SQLite database containing products, customers, orders, and category revenue targets. The database contains 500 orders from January through June 2026.

### Task
Help me write a SQLite SQL query that joins orders with products, groups results by product category and month, and calculates order_count, total_revenue, and avg_revenue for Delivered orders only.

### Constraints
Use SQLite syntax. Use `strftime('%Y-%m', order_date)` for the month. Do not modify the underlying database. The output must contain exactly five columns: category, month, order_count, total_revenue, avg_revenue.

### Format
Return one runnable SQL query followed by a short explanation of the join, filtering, grouping, and date extraction.

### Verification Performed
I ran the SQL query against `bigbasket_capstone.db` in Google Colab. I verified that it returned exactly 36 rows, contained the five required columns, and produced a grand total Delivered revenue of INR 88,282. I also checked the category totals against the Part 1 SQL results.
