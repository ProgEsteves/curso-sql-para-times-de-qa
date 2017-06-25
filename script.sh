#!/bin/bash
#Create dump and install.sql

PGDUMP="/usr/bin/pg_dump"

echo "Exporting Schema..."
$PGDUMP --host localhost --port 5432 --username "postgres" --no-password  --format plain --schema-only --create --inserts --verbose --file "./sql/schema.sql" "imdb" &> ./log/schema.sql.log

echo "\\i ./sql/schema.sql" > ./install.sql

for table in $(cat tables.lst) ; do
	echo "Exporting table: $table..."
	$PGDUMP --host localhost --port 5432 --username "postgres" --no-password  --format plain --data-only --blobs --inserts --verbose --file "./sql/$table.sql" --table "public.$table" "imdb" &> "./log/$table.sql.log"
	echo "\\i ./sql/$table.sql" >> ./install.sql
done
echo "Done."
exit 0
