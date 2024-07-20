FROM postgres:latest

# Install necessary packages (if needed)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-contrib

# Enable pg_stat_statements in postgresql.conf
RUN echo "shared_preload_libraries = 'pg_stat_statements'" >> $PGDATA/postgresql.conf && \
    echo "pg_stat_statements.track = all" >> $PGDATA/postgresql.conf && \
    echo "pg_stat_statements.max = 10000" >> $PGDATA/postgresql.conf && \
    echo "track_activity_query_size = 2048" >> $PGDATA/postgresql.conf

# Expose PostgreSQL default port
EXPOSE 5432

# Start PostgreSQL service
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
