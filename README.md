# flymore-frequent-flyer-db
A relational database design for the FlyMore Frequent Flyer Program, including an ER diagram, SQL schema, and business rules.

# FlyMore Frequent Flyer Database Project

## ER Diagram
The Entity-Relationship (ER) Diagram for the FlyMore Frequent Flyer Database is structured to reflect business rules and ensure data integrity.

[View ER Diagram](flymore_er_diagram.drawio.pdf)

## Database Structure
The database includes the following core tables:
- Passengers: Stores passenger details, FlyMore Cards, and loyalty points.
- Flights & Trips: Models flight information, including layovers and mileage accumulation.
- Awards & Promotions: Enables passengers to redeem points for travel benefits.
- Employee Referrals: Tracks employees referring new passengers for incentives.
- Exchange Centers: Where passengers redeem their mileage points.

## Features
- SQL Schema with Normalization for efficient data storage.
- Stored Procedures & Indexing for faster query execution.
- Business Rules & Constraints ensuring data consistency.
- Entity-Relationship (ER) Diagram to visualize the database design.

## Getting Started
### Prerequisites
To set up and run this database project, ensure you have:
- MySQL or PostgreSQL installed
- A SQL query editor (e.g., MySQL Workbench, pgAdmin, or Oracle SQL Developer)

### Installation & Setup
1. Clone this repository:
   ```sh
   git clone https://github.com/Maysa7/flymore-frequent-flyer-db.git
   ```
2. Open your SQL database system and create a new database:
   ```sql
   CREATE DATABASE flymore_db;
   ```
3. Switch to the new database:
   ```sql
   USE flymore_db;
   ```
4. Run the schema script to create tables:
   ```sql
   SOURCE flymore_db_project.sql;
   ```

## Business Rules & Constraints
- Passengers can own multiple FlyMore Cards, but only one is active at a time.
- Mileage points do not expire.
- Flights can have multiple layovers, and each trip segment accumulates mileage points.
- Employees can refer multiple passengers and earn referral bonuses.
- Awards have fixed redemption values.

## Project Files
- flymore_db_project.sql → SQL Schema for database creation
- flymore_er_diagram.pdf → Entity-Relationship Diagram
- business_rules.md → Business rules and assumptions (optional)

---

## Contributors
- Maysa Alghamdi (George Mason University - CS450 Database Systems Project)
