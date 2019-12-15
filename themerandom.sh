###################################
# Location of file in RetroPie    #
#                                 #
# /home/pi/scripts/themerandom.sh #
#                                 #
###################################

# Get list of currently installed themes and count
rando_theme=$(ls -1 /etc/emulationstation/themes/|shuf|head -1)

# Get the currently used theme name
curtheme=$(grep ThemeSet /opt/retropie/configs/all/emulationstation/es_settings.cfg|cut -f4 -d '"')

# Replace the current used theme with a new one
perl -pi -w -e 's/<string name=\"ThemeSet\" value=\"'${curtheme}'\" \/>/<string name=\"ThemeSet\" value=\"'${rando_theme}'\" \/>/g;' /home/pi/.emulationstation/es_settings.cfg
