#!/bin/bash

YESTERDAY=`date -d '-1 days' +%Y-%m-%d`
CBDIR=/content/$YESTERDAY
LBDIR=/log/$YESTERDAY
DBBDIR=/database/$YESTERDAY

if [ ! -d $CBDIR ]; then
  mkdir -p $CBDIR
  
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create $CBDIR." >&2
    #exit 1 
    MSG="<tr><td>create $CBDIR</td><td>failed</td></tr>";
  fi
fi

cd /

# backup /etc folder

tar zcf $CBDIR/etc-full.tgz etc

if [ $? -ne 0 ]; then
  echo "Error: Failed to backup /etc folder." >&2
  MSG="$MSG <tr><td>/etc folder</td><td>failed</td></tr>"  
#exit 1 
fi

# backup /root folder
tar zcf $CBDIR/root-incremental.tgz --after-date='2 days ago' root 

if [ $? -ne 0 ]; then
  echo "Error: Failed to backup /root folder." >&2
  MSG="$MSG <tr><td>/root folder</td><td>failed</td></tr>"
  #exit 1 
fi


# backup /usr/local folder
cd /usr

tar zcf $CBDIR/usr-local-full.tgz local

if [ $? -ne 0 ]; then
  echo "Error: Failed to backup /usr/local folder." >&2
  #exit 1 
  MSG="$MSG<tr><td>/usr/local folder</td><td>failed</td></tr>"
fi

# move /var/log/*.gz
if [ ! -d $LBDIR/logs ]; then
  mkdir -p $LBDIR/logs
  
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create $LBDIR/logs." >&2
    #exit 1
    MSG="$MSG<tr><td>create $LBDIR/logs folder</td><td>failed</td></tr>" 
  fi
fi

mv -f /var/log/*.gz $LBDIR/logs/
mv -f /var/log/*`date -d '-1 days' +%Y%m%d`* $LBDIR/logs/

if [ $? -ne 0 ]; then
  echo "Error: Failed to move log files." >&2
  MSG="$MSG<tr><td>move $LBDIR/logs files</td><td>failed</td></tr>"
  #exit 1 
fi

# move /var/log/mysql/*.gz
if [ ! -d $LBDIR/mysql-logs ]; then
  mkdir -p $LBDIR/mysql-logs
  
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create $LBDIR/mysql-logs." >&2
    MSG="$MSG<tr><td>create $LBDIR/mysql-logs</td><td>failed</td></tr>"
    #exit 1 
  fi
fi

cd /san/mysql/
mv nilgiri-slow.log nilgiri-slow.log-$YESTERDAY
mysqladmin -uroot -pNeshagAim017 flush-logs
gzip nilgiri-slow.log-$YESTERDAY
mv -f nilgiri-slow.log-$YESTERDAY.gz $LBDIR/mysql-logs/

if [ $? -ne 0 ]; then
  echo "Error: Failed to move mysql log files." >&2
  MSG="$MSG<tr><td>move $LBDIR/mysql-logs files</td><td>failed</td></tr>"
  #exit 1 
fi


gsutil mv /content/$YESTERDAY gs://regional-backup-bucket/content/nilgiri/$YESTERDAY
gsutil mv /log/$YESTERDAY gs://regional-backup-bucket/log/nilgiri/$YESTERDAY
gsutil mv /database/$YESTERDAY gs://regional-backup-bucket/database/nilgiri/$YESTERDAY


if [ ! "$MSG" ]; then
echo -e "Dear Team, \n\nPlease find below backup status. \n<table border='1'><tr><th>Directory</th><th>Status</th></tr>$MSG</table>\n\n+gcpnilgiri" | mail -s "Nilgiri Daily Backup Status on $(date +%F)" ashok.pilla@spoors.in,bala.balam@spoors.in
else
echo -e "Dear Team, \n\nNilgiri Daily Backup is successful. \n\n+gcpnilgiri" | mail -s "Nilgiri Daily Backup Status on $(date +%F)" ashok.pilla@spoors.in, bala.balam@spoors.in
fi

