require 'mysql2'
require 'pg'

# Connect to MySQL
mysql_client = Mysql2::Client.new(host: 'localhost', username: 'root', password: '', database: 'db_name')

# Connect to PostgreSQL
pg_client = PG.connect(host: 'localhost', dbname: 'db_name', user: 'postgres', password: 'postgres')

# Query to get table names
tables_result = mysql_client.query("SHOW TABLES")

# Extract table names from the result
table_names = tables_result.map { |row| row.values.first }

begin
  until table_names.empty?
    puts "Remaining table: #{table_names}"
    check = true
    table_names.each do |table_name|
      puts "Copying #{table_name}..."
      mysql_results = mysql_client.query("SELECT * FROM #{table_name}")


      mysql_results.each do |row|
        columns = row.keys.join(",")
        placeholders = row.keys.map { |key| "$#{row.keys.index(key) + 1}" }.join(",")

        begin
          pg_client.exec_params("INSERT INTO #{table_name} (#{columns}) VALUES (#{placeholders}) ON CONFLICT DO NOTHING", row.values)
        rescue StandardError => e
          puts "Error while copying data to table #{table_name}: #{e.message}"
          puts "But don't worry because maybe cause is fk order incorrect and I will make it correct!"
          check = false
          break
        end
      end
      table_names.delete(table_name) if check
    end
  end
  puts 'Done! Everything has been copied'
rescue StandardError => e
  puts "Error: #{e.message}"
end


# Close connections
mysql_client.close
pg_client.close
