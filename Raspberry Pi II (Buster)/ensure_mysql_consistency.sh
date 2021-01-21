#!/bin/sh -e
#
#add to /etc/rc.local; e.g. sudo bash /home/pi/ensure_mysql_consistency.sh >> /home/pi/repair_mysql.log
#
#Ref: https://stackoverflow.com/questions/8843776/mysql-table-is-marked-as-crashed-and-last-automatic-repair-failed

echo ">>Checking MySQL Instance...$(date)"

mysql_crashed=$(service mariadb status | grep "marked as crashed")

if [ -z "$mysql_crashed" ]
then
        echo MySQL DB is intact.
        exit 0
else
        echo MySQL DB is corrupt, Attempting Repair...
fi

echo "Stopping Services..."

service ntopng stop
service mariadb stop
service mysql stop
service redis-server stop
#cd /var/lib/mysql/ntopng

echo "Starting DB Repair..."
myisamchk -r /var/lib/mysql/ntopng/flows* &> /dev/null

echo "Starting Services"
service mariadb start
service mysql start
service redis-server start
service ntopng start

mysql_crashed=$(service mariadb status | grep "marked as crashed")

if [ "$mysql_crashed" ]
then
        echo Repair Failed...Run Repair Manually, and Check Logs.
fi
