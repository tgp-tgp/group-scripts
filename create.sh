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
#the group's display name. I set this as my first name, since I don't want to advertise that this is a cusom email address.
displayName='Person'

groupname=${1?Please enter a group name}
#remove any spaces from groupname input
groupname=${groupname//[[:blank:]]/}

#create send-as?
read -p 'Create Send-as alias? (Y/N): ' sendas

#create group and settings
$gam create group $groupname@$domain who_can_post_message ANYONE_CAN_POST who_can_invite NONE_CAN_INVITE max_message_bytes 20M members_can_post_as_the_group true who_can_contact_owner all_managers_can_contact is_archived true spam_moderation_level allow
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname created via script." >> $logfile

#add member as the owner
$gam update group $groupname add owner $member
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname $member added as owner." >> $logfile

#create label
$gam user $member label $groupname
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname label created." >> $logfile

#create filter
$gam user $member filter haswords "list:(<$groupname@$domain>)" label $groupname
printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname filter created." >> $logfile

#create alias or not
if [ "$sendas" = "y" ]
then
        echo "Creating an alias"
        $gam user $member sendas $groupname@$domain "$displayName" replyto $groupname@$domain
        printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname send-as created." >> $logfile
else
        echo "Not creating an alias"
        printf "\n$(date +%Y-%m-%dT%R-%z) Group $groupname send-as skipped." >> $logfile
fi
