# MySQL to PostgreSQL Data Transfer

This repository contains scripts to facilitate the transfer of data from a MySQL database to a PostgreSQL database. The process assumes that both databases share a common schema, including migrations in MySQL.

## Prerequisites

Before using the scripts, ensure the following prerequisites are met:

1. **MySQL Database**: Set up and populate a MySQL database with the desired schema and data.
2. **PostgreSQL Database**: Create an empty PostgreSQL database with the same schema as the MySQL database. Ensure that the schema includes all necessary tables and columns.
3. **Migrations**: Make sure that any necessary migrations for the MySQL schema are also applied to the PostgreSQL schema.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine.
    ```
    git clone git@github.com:datpmt/mysql_to_psql.git
    ```

2. **Configure Connection Settings**: Open the `copy.rb` file and update the connection settings for both MySQL and PostgreSQL databases.
3. **Transfer Data**: Run the provided script to transfer data from MySQL to PostgreSQL.
    ```
    ruby copy.rb
    ```

This script will connect to both databases, fetch data from MySQL, and insert it into PostgreSQL.

## Additional Notes

- Make sure both databases are accessible from the machine where the script is being run.
- It's recommended to run the transfer script in a controlled environment to avoid any unintended data loss or corruption.
- Depending on the size of the data, the transfer process may take some time to complete. Monitor the script for any errors or warnings during execution.

## Contributors

- [datpmt](https://github.com/datpmt)

## License
Copyright (c) 2021 datpmt.
This project is licensed under the [MIT License](LICENSE).
