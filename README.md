# 🛰️ Simple ETL Challenge with SpaceX Data

## 📌 Purpose
To demonstrate a complete ETL (Extract, Transform, Load) pipeline using SpaceX launch data. This includes data extraction, transformation, database schema design, loading into MySQL, and running SQL queries to generate insights.

---

## 🔧 What the Project Does

1. **Extract**  
   - Uses Python to call the SpaceX Launch API and retrieve launch data.

2. **Transform**  
   - Normalizes the API's JSON data into structured CSV files.
   - Cleans the datasets using Excel for better consistency.

3. **Load**  
   - Designs an Entity Relationship Diagram (ERD) for database schema.
   - Loads the cleaned CSV files into a MySQL database.
   - Creates tables and uses stored procedures to properly insert the data.

4. **Query**  
   - Executes SQL scripts to answer specific business or analytical questions using the structured data.

---

## 📂 Main Files

- `SpaceXDataProcessing.ipynb`: Jupyter Notebook for data extraction and transformation.
- `datachallenge.sql`: SQL script for database and table creation.
- `query.sql`: SQL queries that provide answers to posed questions.
- `ERD.pdf`: Entity Relationship Diagram for schema reference.
- `data/`: Contains cleaned CSV files:
  - `launches.csv`
  - `payloads.csv`
  - `rockets.csv`
  - `ships.csv`

---

## ▶️ How to Run

1. Run the `datachallenge.sql` script in MySQL to create and populate the database.
2. Run the `query.sql` script in MySQL to execute queries and view insights.

---
