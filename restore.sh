#!/bin/bash

#Variables
#path to log file
logfile=~/path/to/log.txt
#path to your local GAM installation
gam=/path/to/gam
#the G Suite domain you're using
domain='domain.com'
#the first part of the email address of the person you're adding to the group
primary=username

groupname=${1?Please enter a group name}
#remove any spaces from groupname input
groupname=${groupname//[[:blank:]]/}

#create send-as?
read -p 'Create Send-as alias? (Y/N): ' sendas

#unarchive the group and set posting
$gam update group $groupname@$domain archive_only false who_can_post_message ANYONE_CAN_POST
printf "\n$(date +%Y-%m-%dT%R-%z) Group $NAME posting made public via script." >> $logfile

#create alias or not
if [ "$sendas" = "y" ]
then
        echo "Creating an alias"
        $gam user $primary sendas $groupname@$domain "$groupname" replyto $groupname@$domain
        printf "\n$(date +%Y-%m-%dT%R-%z) Group %s send-as created." $groupname >> $logfile
else
        echo "Not creating an alias"
        printf "\n$(date +%Y-%m-%dT%R-%z) Group %s send-as skipped." $groupname >> $logfile
fi

#log to file
printf "\n$(date +%Y-%m-%dT%R-%z) Group %s restored via script." $groupname >> $logfile
echo "Group $groupname restored."

