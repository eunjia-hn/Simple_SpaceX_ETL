# Slalom_DataChallenge
**Requirements** <br/>
1. A script wirtten with any programming language that calls the API and uploads it to your database.
2. A file with the two queries that answer our questions about the data
3. An explanation of how to run your solution.

### HOW I SOLVED
1. Pulled and saved the SpaceX Launch API from the web using python.
2. Normalized the json files and saved as a csv using python.
3. Cleaned the datasets using Excel. 
4. Built an ERD in order to properly transfer csv data into the database.
5. Loaded csv files into MySQL.
6. Created tables based on the ERD 
7. Wrote stored procedures to properly insert the loaded data into the tables in the database
8. Wrote the querying statements answering questions that were asked to solve. 

### TO RUN
- Run a 'DataChallenge.sql' script on MySQL to have create a database based on the data pulled from API
- Run a 'query.sql' script on MySQL for the solutions to the questions that were asked to answer.


