# Pyspark SQL-Jupyter dockerfile example

Welcome to the **Pyspark SQL-Jupyter dockerfile example** repository! This repository provides a development environment for Python, Jupyter Notebook, and PostgreSQL. It includes a Dockerfile designed to streamline setting up a containerized environment for running data analysis workflows involving SQL and Python. Follow this guide to set up and contribute to the project.

The purpose of this repository is to provide a Jupyter notebook environment for practicing SQL skills. You can write SQL queries, execute them, and view the results directly within the notebook. This is intended for learning and practice, not for production use.

---

## **Table of Contents**

- [Pyspark SQL-Jupyter dockerfile example](#pyspark-sql-jupyter-dockerfile-example)
  - [**Table of Contents**](#table-of-contents)
  - [**Features**](#features)
  - [**Folder Structure**](#folder-structure)
  - [Folders and Files Needed for the Dockerfile](#folders-and-files-needed-for-the-dockerfile)
  - [Initial Setup](#initial-setup)
    - [First things first:](#first-things-first)
    - [Ubuntu](#ubuntu)
    - [Windows](#windows)
  - [**Using This Repo**](#using-this-repo)
    - [**Run with Docker**](#run-with-docker)
  - [Please notice that the init script will look for all available csv's in data folder and will create the entire database again.](#please-notice-that-the-init-script-will-look-for-all-available-csvs-in-data-folder-and-will-create-the-entire-database-again)
  - [Setting Up Things](#setting-up-things)
  - [How to Run the Code](#how-to-run-the-code)
  - [**Contributing**](#contributing)

---

## **Features**

- Python 3.10 as the base programming environment.
- PostgreSQL 15 with user authentication and a pre-loaded database schema.
- JupyterLab for interactive data analysis.
- Pre-installed Python libraries for SQLAlchemy, Pandas, and more.
- Automated setup for importing initial CSV data into PostgreSQL.

---

## **Folder Structure**

```plaintext
.
├── LICENSE                     # License information
├── README.md                   # Documentation for the repository
├── README_old.md               # Old version of the documentation
├── data                        # Folder containing sample CSV files for import
│   ├── amazon.csv              # Example dataset
│   └── enhanced_box_office_data_20_24u.csv  # Additional dataset
├── data_readme.md              # Details about the datasets in the `data` folder
├── dockerfiles                 # Folder containing Dockerfiles
│   └── Dockerfile_jupyter_sql_dev  # Dockerfile for setting up the environment
├── import_csv.py               # Script to automate importing CSV data into PostgreSQL
├── init.sql                    # SQL script for initializing the PostgreSQL database
└── notebooks                   # Jupyter Notebooks for running SQL queries
    ├── csv_to_postgres.ipynb   # Notebook demonstrating CSV import to PostgreSQL
    └── running_queries.ipynb  # Notebook for executing SQL queries
```

## Folders and Files Needed for the Dockerfile

- `dockerfiles/Dockerfile_jupyter_sql_dev`: Defines the Docker image setup.
- `init.sql`: Contains the schema and initial setup for PostgreSQL.
- `data/*.csv`: CSV files for populating the database.
- `import_csv.py`: Script for automating CSV imports into PostgreSQL.

---

## Initial Setup
### First things first:
1. Download this repo
2. add your csv files into data folder


### Ubuntu

1. Install Docker:
   ```bash
   sudo apt update
   sudo apt install -y docker.io docker-compose
   ```
2. Start Docker:
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

### Windows

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Ensure Docker Desktop is running and WSL2 backend is enabled.
3. Clone this repository:
   ```bash
   git clone https://github.com/rafaelortegar/pyspark_sql_dockerfile_example.git
   ```

---

## **Using This Repo**

### **Run with Docker**

1. **Navigate to the root directory:**
   ```bash
   cd pyspark_sql_dockerfile_example
   ```

2. **Build the Docker Image**:

   ```bash
   docker build --no-cache -f dockerfiles/Dockerfile_jupyter_sql_dev -t jupyter_sql_dev .
   ```
3. **Run the Container**:

   ```bash
   docker run -it -p 8888:8888 -p 5432:5432 -v $(pwd):/workspace jupyter_sql_dev /bin/bash
   ```

4. **Run init script**:

   ```bash
   bash setup_postgres.sh
   ```

5.  **Run Jupyter lab**:

   ```bash
   jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
   ```

6. **Access the Services**:

   - Jupyter Notebook: [http://localhost:8888](http://localhost:8888)
   - Jupyter Book: [http://localhost:8000](http://localhost:8000)

In case you want to change or add a new csv file, just th init script agains:

1. **Run init script again**:

   ```bash
   bash setup_postgres.sh
   ```

Please notice that the init script will look for all available csv's in data folder and will create the entire database again.
---

## Setting Up Things

- The `Dockerfile` installs PostgreSQL, JupyterLab, and required Python libraries.
- It sets up PostgreSQL for password authentication and pre-loads the database using `init.sql`.
- The `import_csv.py` script imports CSV files from the `data` folder into the PostgreSQL database.
- The `setup_postgres.sh` file will re create the entire database by running the `init.sql` and the `import_csv.py` files.

---

## How to Run the Code

1. Start the container:

   ```bash
   docker run -it -p 8888:8888 -p 5432:5432 -v $(pwd):/workspace jupyter_sql_dev /bin/bash
   ```

2.  **Run Jupyter lab**:

   ```bash
   jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
   ```

3. **Run init script**:

   ```bash
   bash setup_postgres.sh
   ```

4. Access JupyterLab:
   - Open your browser and navigate to `http://localhost:8888`.
   - Use the token displayed in the terminal to log in.

5. Run Jupyter Notebooks from the `notebooks` folder to execute SQL queries and analyze data. (You can see an example in the notebooks folder)

---

## **Contributing**

Contributions are welcome! Follow these steps:

1. **Fork the Repo**: Clone your fork locally.

2. **Create a Feature Branch**:

   ```bash
   git checkout -b feature/<feature-name>
   ```

3. **Make Changes**: Commit with meaningful messages.

4. **Commit your changes and push**:

   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin feature-branch-name
   ```

5. **Create a Pull Request**.

---

If you encounter any issues or have questions, feel free to open an issue or contribute to the project!

<!-- # Actual commands:

docker build --no-cache -f dockerfiles/Dockerfile_jupyter_sql_dev -t jupyter_sql_pyspark .

docker run -it -p 8888:8888 -p 5432:5432 -v $(pwd):/workspace jupyter_sql_pyspark /bin/bash

service postgresql status
service postgresql start

PGPASSWORD=postgres_pwd psql -U postgres -d postgres -f /docker-entrypoint-initdb.d/init.sql

python import_csv.py

PGPASSWORD=postgres_pwd psql -U postgres -d practice_db

\dt

exit

jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root -->

---

<!-- PGPASSWORD=postgres_pwd psql -U postgres

psql -U postgres -d practice_db -h localhost

psql -U postgres

Password for user postgres: postgres_pwd

postgres=# CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE
postgres=# \dt
         List of relations
 Schema | Name  | Type  |  Owner
--------+-------+-------+----------
 public | users | table | postgres
(1 row)

postgres=# INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
INSERT INTO users (name, email) VALUES ('Bob', 'bob@example.com');
INSERT 0 1
INSERT 0 1
postgres=# SELECT * FROM users;
 id | name  |       email
----+-------+-------------------
  1 | Alice | alice@example.com
  2 | Bob   | bob@example.com
(2 rows)

postgres=#

\q

jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root

oot@a1d2a1ddd942:/workspace# service postgresql status
15/main (port 5432): online
root@a1d2a1ddd942:/workspace# PGPASSWORD=postgres_pwd psql -U postgres
psql (15.10 (Debian 15.10-0+deb12u1))
Type "help" for help.

postgres=# \l
                                             List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  | ICU Locale | Locale Provider |   Acces
s privileges
-----------+----------+----------+---------+---------+------------+-----------------+--------
---------------------------------------------------------------------------------------------

 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 |            | libc            |
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 |            | libc            | =c/post
gres          +
           |          |          |         |         |            |                 | postgre
s=CTc/postgres
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 |            | libc            | =c/post
gres          +
           |          |          |         |         |            |                 | postgre
s=CTc/postgres
(3 rows)

postgres=# CREATE DATABASE practice_db;
CREATE DATABASE
postgres=# \q
root@a1d2a1ddd942:/workspace#

PGPASSWORD=postgres_pwd psql -U postgres -d postgres -f /docker-entrypoint-initdb.d/init.sql

python import_csv.py -->
