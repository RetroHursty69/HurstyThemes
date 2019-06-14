###################################
# Location of file in RetroPie    #
#                                 #
# /home/pi/scripts/themerandom.sh #
#                                 #
###################################

# Get list of currently installed themes and count
ls /etc/emulationstation/themes > /tmp/themes
mkdir -p -- "/opt/retropie/configs/all/emulationstation/themes"
ls /opt/retropie/configs/all/emulationstation/themes >> /tmp/themes
themecount=`cat /tmp/themes |wc -l`

# Get the currently used theme name
curtheme=`cat /opt/retropie/configs/all/emulationstation/es_settings.cfg |grep ThemeSet |cut -f4 -d '"'`

# Generate a random number between 1 and theme count
r=$(( $RANDOM % ${themecount} +1 ))

# Read the random line in the tmp file to get a new theme name
newtheme=`sed -n "${r}p" /tmp/themes`

# Replace the current used theme with a new one
perl -pi -w -e 's/<string name=\"ThemeSet\" value=\"'${curtheme}'\" \/>/<string name=\"ThemeSet\" value=\"'${newtheme}'\" \/>/g;' /opt/retropie/configs/all/emulationstation/es_settings.cfg
