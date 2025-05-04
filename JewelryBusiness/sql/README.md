# JewelryBusiness Database

A MySQL database project for managing a luxury jewelry business. This project includes schema definitions, initial data, analytical queries, views, stored procedures, and triggers to support business operations.

## Table of Contents
- [Project Overview](#project-overview)
- [Database Structure](#database-structure)
- [Setup Instructions](#setup-instructions)
- [File Structure](#file-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview
This project models a database for a jewelry business, handling customers, employees, suppliers, products, orders, and payments. It includes:
- **Schema**: Table definitions with constraints, indexes, and triggers.
- **Data**: Sample data for testing.
- **Queries**: Analytical reports (e.g., monthly sales, top customers).
- **Views**: Summaries for customers and stock status.
- **Stored Procedures**: Automation for stock updates and sales reports.

## Database Structure
The database includes the following tables:
- `Customers`: Stores customer details.
- `Employees`: Stores employee information.
- `Suppliers`: Stores supplier details.
- `Products`: Stores jewelry product details.
- `Orders`: Stores customer orders.
- `OrderDetails`: Stores products in each order.
- `Payments`: Stores payment transactions.
- `PriceChangeLog`: Logs product price changes.

See [database_diagram.png](docs/database_diagram.png) for the ERD.

## Setup Instructions
1. Install MySQL 8.0.27 or later.
2. Clone the repository:
   ```bash
   git clone https://github.com/username/JewelryBusiness-Database.git