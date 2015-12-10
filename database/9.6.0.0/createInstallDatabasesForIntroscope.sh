#!/bin/bash

# build the script to enter the initial data to the introscope database.

final_script=/docker-entrypoint-initdb.d/000-installDatabasesForIntroscope.sh
#final_script=/tmp/installDatabasesForIntroscope.sh
script_dir=scripts
dbversion=9.6.0.0
sql_files=( createtables-postgres-$dbversion.sql createsequences-postgres-$dbversion.sql addindexes-postgres-$dbversion.sql addconstraints-postgres-$dbversion.sql addviews-postgres-$dbversion.sql quartz-1.5.1-postgres.sql defaults-postgres-$dbversion.sql initdb-postgres-$dbversion.sql create-apm-tables-postgres-$dbversion.sql create-apm-sequences-postgres-$dbversion.sql add-apm-indexes-postgres-$dbversion.sql add-apm-constraints-postgres-$dbversion.sql apm-defaults-postgres-$dbversion.sql apm-procedures-postgres-$dbversion.sql)
# removed /add-apm-pruning-function-postgres-$dbversion.sql --> not available for 9.6.0.0

# remove the file if it is already there
if [ -e $final_script ]
	then
	rm $final_script
fi
echo "#!/bin/bash" >> $final_script

echo "echo Starting the integration of Introscope contents" >> $final_script

echo "" >> $final_script
echo "export PGUSER=postgres" >> $final_script

echo "echo create user admin" >> $final_script
echo "psql <<EOSQL" >> $final_script
echo "CREATE USER admin WITH PASSWORD 'wily';" >> $final_script
echo "EOSQL" >> $final_script
echo "echo" >> $final_script
echo "echo ... finished" >> $final_script

echo "echo create database cemdb" >> $final_script
echo "psql <<EOSQL" >> $final_script
echo "CREATE DATABASE cemdb OWNER admin;" >> $final_script
echo "EOSQL" >> $final_script
echo "echo" >> $final_script
echo "echo ... finished" >> $final_script

echo "echo set privileges" >> $final_script
echo "psql <<EOSQL" >> $final_script
echo "GRANT ALL PRIVILEGES ON DATABASE cemdb TO admin;" >> $final_script
echo "EOSQL" >> $final_script
echo "echo" >> $final_script
echo "echo ... finished" >> $final_script

counter=0;
for i in ${sql_files[@]}; do
	let counter=counter+1;

	if [ "$counter" -lt "100" ]
		then
			counter_fixed="0"$counter
	fi
	if [ "$counter" -lt "10" ]
		then
			counter_fixed="00"$counter
	fi
	if [ "$counter" -gt "100" ]
		then
			counter_fixed=$counter
	fi


	# copy the file to its destination
	filename="/docker-entrypoint-initdb.d/$counter_fixed-$i"
	cp scripts/$i $filename
#	chmod +x $filename

	# remove all SQL comments (-- ....) from the file
#	sed -i '/^\s*--/d' $filename
	# remove empty lines
#	sed -i 's/^\s*$//g' $filename
	# add psql in the beginning of the file
#	sed -i '1s/^/psql <<- EOSQL n/' $filename
#	echo "EOSQL" >> $filename
done
