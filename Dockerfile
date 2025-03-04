# Use the official Oracle XE image as base
FROM gvenzl/oracle-xe

# Set environment variables
ENV ORACLE_PASSWORD=hr
ENV ORACLE_SID=XEPDB1

# Copy HR schema SQL scripts into the container
COPY hr_create.sql /opt/oracle/scripts/hr_create.sql
COPY hr_setup.sql /opt/oracle/scripts/hr_setup.sql
COPY hr_populate.sql /opt/oracle/scripts/hr_populate.sql
COPY run-scripts.sh /opt/oracle/scripts/run-scripts.sh

# Set execute permissions for the script
RUN chmod +x /opt/oracle/scripts/run-scripts.sh

# Automatically execute the setup script when the container starts
CMD ["/bin/bash", "/opt/oracle/scripts/run-scripts.sh"]
