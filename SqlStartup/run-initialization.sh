# Wait to be sure that SQL Server came up
sleep 15s

# Run the setup script to create the DB and the schema in the DB
# Note: make sure that your password matches what is in the Dockerfile
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P alphab3t@ -d master -i create-database.sql -N -C