# hurstythemes

-------
OVERVIEW

Hursty's Themes RetroPie Downloader

Due to the number of themes I have made for Emulation Station, the built-in ES Themes Manager list was becoming very large and cumbersome.  I decided to create my own ES Themes downloader and just list my themes linked directly to my Github repositories.  This allows easier access to my themes for everyone.

I've also created a set of ES themes (the mini sweet themes) that highlight an individual game or game character.  These themes all have the word "Sweet" at the end of the name.  To make the most of the "Sweet" Themes experience, make sure you activate the ES Theme Randomizer script.

The ES bootup randomizer script was created by David Marti for his Motion Blue Unified base image.

Periodically, new themes are completed and you will need to run the script updater to download the newest version to see these additional themes.

The instructions below will demonstrate how to install the script and have it show up in the RetroPie menu within Emulation Station.

-------
INSTALLATION - using a Raspberry Pi build of RetroPie

Exit out of Emulation Station by pressing F4 (or remote into the Pi using something like Putty)

Type the following commands and press enter after each line to execute it:

***wget https://raw.githubusercontent.com/RetroHursty69/HurstyThemes/master/install.sh***

***chmod +x "install.sh"***

***./install.sh***

This will download and install the Hursty's Theme script and update the RetroPie ES gamelist.xml file.

Restart Emulation Station and you should then see the new script in the RetroPie menu.
