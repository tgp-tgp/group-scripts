Written by Tucker Perry, released under GPL.

I am not a scripter/coder by any means, this is a personal pet project. 

This presumes an installation of GAM or GAMxtd, and admin rights in a Google Workspace instance. GAM XTD3 installation guide is here: https://github.com/taers232c/GAMADV-XTD3

All the variables are described in each script. 

create.sh will create a group named by user input. The member of that group is pre-defined by a variable in the script. The group it creates will accept email from any sender. It will also create a label and a filter to assign that label to each message that comes to the alias. It will optionally create a send-as alias for the user as well.

archive.sh will make the group private, blocking mail from all senders. It will also remove a send-as alias if there is one, but leave the label and filter in place. 