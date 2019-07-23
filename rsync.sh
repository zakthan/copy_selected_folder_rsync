###############################################################################################################
##Author:  Athanasios Zakopoulos
##Purpose: This script copies selected folders to remote servers without changing permissions of destination root folder
###############################################################################################################

#!/bin/sh

DATE=`date '+%Y.%m.%d.%H.%M'`
DESTINATION_HOSTS="***** *******"
DEST_DOC_ROOT=/var/www/uatatg.cosmote.gr
DESTINATION_HOSTS_ADMIN_SERVERS="******* ******"
DEST_DOC_ROOT_ADMIN_SERVERS=/var/www/uatatgadmin.cosmote.gr
FOLDERS="announcements businessone_static drivers hub images img maps otegroup_company ote_static pdf sample smarthome smarthome_20170829 smarthome_20170904 smarthome_20170911 wcs_static"
SOURCE_DOC_ROOT=/appl/Static_Content_Upload
LOG=/appl/Static_Content_Upload/rsync.log

for FOLDER in $FOLDERS
do
        for HOST in $DESTINATION_HOSTS
        do
                /usr/bin/rsync -avzrp  $SOURCE_DOC_ROOT/$FOLDER/* $HOST:$DEST_DOC_ROOT/$FOLDER/ 2>/dev/null
                if [ $? -ne 0 ] ; then echo "Check $HOST for $FOLDER unsuccesfull rsync " >> $LOG;echo "" ;fi
                ##echo "$SOURCE_DOC_ROOT/$FOLDER/ $HOST:$DEST_DOC_ROOT/$FOLDER/"
        done

        for HOST in $DESTINATION_HOSTS_ADMIN_SERVERS
        do
                /usr/bin/rsync -avzrp  $SOURCE_DOC_ROOT/$FOLDER/* $HOST:$DEST_DOC_ROOT_ADMIN_SERVERS/$FOLDER/  2>/dev/null
                if [ $? -ne 0 ] ; then echo "Check $HOST for $FOLDER unsuccesfull rsync " >> $LOG;echo "" ;fi
                ##echo "$SOURCE_DOC_ROOT/$FOLDER/ $HOST:$DEST_DOC_ROOT/$FOLDER/"
        done
done
