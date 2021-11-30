#!/bin/bash

#Variables
#path to log file
logfile=~/path/to/log.txt
#path to your local GAM installation
gam=/path/to/gam
#the email address of the user you're creating the email alias for
member='person@domain.com'
#the G Suite domain you're using
domain='domain.com'

groupname=${1?Please enter a group name}
#remove any spaces from groupname input
groupname=${groupname//[[:blank:]]/}

#lock the group
$gam update group $groupname whocanpostmessage  all_managers_can_post
printf "\n$(date +%Y-%m-%dT%R-%z) Group $NAME made private via script." >> $logfile

#remove send-as from $member. This will throw a benign error if an alias doesn't exist.
$gam user $member delete sendas $groupname@$domain
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname send-as removed via script." >> $logfile

#logging and letting the user know
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname archived via script." >> $logfile
echo "Group $groupname archived."
