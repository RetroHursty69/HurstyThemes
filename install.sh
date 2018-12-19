#!/usr/bin/env bash

# This script will install the 3rd party script installer
# for Hursty's Themes.

# These themes are to be used on a Raspberry Pi / RetroPie build

# It also includes the Motion Blue Unified ES bootup themes randomizer script

# Download repository

rm -rf "/tmp/hursty"
mkdir -p "/tmp/hursty"
git clone "https://github.com/RetroHursty69/HurstyThemes.git" "/tmp/hursty"

# Move files to proper directory

if [[ -d "/home/pigaming" ]]; then
  pipath = "pigaming"
else
  pipath = "pi"
fi

cp /tmp/hursty/hurstythemes.sh /home/$pipath/RetroPie/retropiemenu
chmod 777 /home/$pipath/RetroPie/retropiemenu/hurstythemes.sh
cp /tmp/hursty/hurstythemes.png /home/$pipath/RetroPie/retropiemenu/icons
mkdir /home/$pipath/scripts
cp /tmp/hursty/themerandom.sh /home/$pipath/scripts
chmod 777 /home/$pipath/scripts/themerandom.sh

# Update RetroPie gamelist.xml to add new entry

cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml.bkp
cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /tmp

cat /tmp/gamelist.xml |grep -v "</gameList>" > /tmp/templist.xml

ifexist=`cat /tmp/templist.xml |grep hurstythemes |wc -l`
if [[ ${ifexist} > 0 ]]; then
  echo "already in gamelist.xml" > /tmp/exists
else
  echo "	<game>" >> /tmp/templist.xml
  echo "		<path>./hurstythemes.sh</path>" >> /tmp/templist.xml
  echo "		<name>Hursty's Themes</name>" >> /tmp/templist.xml
  echo "		<desc>Install, uninstall, or update RetroHursty69's EmulationStation themes. It also includes an ES bootup theme randomizer to automatically switch themes on bootup.</desc>" >> /tmp/templist.xml
  echo "		<image>./icons/hurstythemes.png</image>" >> /tmp/templist.xml
  echo "		<playcount>1</playcount>" >> /tmp/templist.xml
  echo "		<lastplayed></lastplayed>" >> /tmp/templist.xml
  echo "	</game>" >> /tmp/templist.xml
  echo "</gameList>" >> /tmp/templist.xml
  cp /tmp/templist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
fi

