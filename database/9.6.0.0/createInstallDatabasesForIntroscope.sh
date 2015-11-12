#!/bin/bash

# build the script to enter the initial data to the introscope database.

final_script=/docker-entrypoint-initdb.d/installDatabasesForIntroscope.sh
#final_script=/tmp/installDatabasesForIntroscope.sh
script_dir=scripts
dbversion=9.6.0.0
sql_files=( $script_dir/createtables-postgres-$dbversion.sql $script_dir/createsequences-postgres-$dbversion.sql $script_dir/addindexes-postgres-$dbversion.sql $script_dir/addconstraints-postgres-$dbversion.sql $script_dir/addviews-postgres-$dbversion.sql $script_dir/quartz-1.5.1-postgres.sql $script_dir/defaults-postgres-$dbversion.sql $script_dir/initdb-postgres-$dbversion.sql $script_dir/create-apm-tables-postgres-$dbversion.sql $script_dir/create-apm-sequences-postgres-$dbversion.sql $script_dir/add-apm-indexes-postgres-$dbversion.sql $script_dir/add-apm-constraints-postgres-$dbversion.sql $script_dir/apm-defaults-postgres-$dbversion.sql $script_dir/$script_dir/apm-procedures-postgres-$dbversion.sql)
# removed $script_dir/add-apm-pruning-function-postgres-$dbversion.sql --> not available for 9.6.0.0

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

echo "# read all sql files and add them in a single line in one single postgres execution" >> $final_script
echo "psql <<EOSQL" >> $final_script

# now it is getting a bit ugly and linux/unix pros can most certainly improve this solution quite a bit. Feedback (with explanation) is always welcome - i am not a bash crack ;). What we need to do is to combine all
# necessary sql queries in one line (else single execution on postgres is not possible - at least that is what I read, and yes i tried, it is not possible ;)).
#
# process
# - we go over all sql files and first copy the file to a temporary file
# - we remove the linebreaks (we assume that the file is in linux EOL), else this will NOT work
# - we remove empty lines
# - we write the result of each single SQL to another intermediate file
# - we remove all linebreaks of this intermediate file and push to our final script.

if [ -e /tmp/tempfile ]
	then
	rm /tmp/tempfile
fi

if [ -e /tmp/intermediate ]
	then
	rm /tmp/intermediate
fi

for i in ${sql_files[@]}; do
	cp $i /tmp/tempfile

	# remove all SQL comments (-- ....) from the file
	sed -i '/^\s*--/d' /tmp/tempfile

	# remove cr/lf
	#sed -i ':a;N;$!ba;s/\n/ /g' /tmp/tempfile
	#tr -d "\n\r" < /tmp/tempfile
	echo $(cat /tmp/tempfile) &> /tmp/tempfile

	# remove empty lines
	sed -i 's/^\s*$//g' /tmp/tempfile

	cat /tmp/tempfile >> /tmp/intermediate
done

echo $(cat /tmp/intermediate) >> $final_script

echo "EOSQL" >> $final_script
echo "echo" >> $final_script
