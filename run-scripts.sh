#!/bin/bash

# Wait for Oracle DB to be ready
echo "Waiting for Oracle Database to start..."
until echo exit | sqlplus -S system/hr@XEPDB1; do
    sleep 5
done
echo "Oracle Database is ready."

# Run HR schema creation first
echo "Executing hr_create.sql..."
sqlplus system/hr@XEPDB1 @/opt/oracle/scripts/hr_create.sql

# Then, configure HR user and permissions
echo "Executing hr_setup.sql..."
echo "ALTER SESSION SET \"_ORACLE_SCRIPT\"=true;" | sqlplus system/hr@XEPDB1
sqlplus system/hr@XEPDB1 @/opt/oracle/scripts/hr_setup.sql

# Finally, populate the HR schema with data
echo "Executing hr_populate.sql..."
sqlplus hr/hr@XEPDB1 @/opt/oracle/scripts/hr_populate.sql

echo "HR schema setup complete."
exit
