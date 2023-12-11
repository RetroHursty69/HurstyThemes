#!/usr/bin/env bash

# This file is NOT part of The RetroPie Project
#
# This script is a third party script to install the RetroHursty69
# Emulation Station themes onto a RetroPie build.
#
#

function depends_hurstythemes() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function install_theme_hurstythemes() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="RetroHursty69"
    fi
    if [[ -z "$theme" ]]; then
        theme="carbon"
        repo="RetroPie"
    fi
    sudo git clone "https://github.com/$repo/es-theme-$theme.git" "/etc/emulationstation/themes/$theme"
}

function uninstall_theme_hurstythemes() {
    local theme="$1"
    if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
        sudo rm -rf "/etc/emulationstation/themes/$theme"
    fi
}

function disable_script() {
dialog --infobox "...processing..." 3 20 ; sleep 2
ifexist=`cat /opt/retropie/configs/all/autostart.sh |grep themerandom |wc -l`
if [[ ${ifexist} > "0" ]]
then
  perl -pi -w -e 's/\/home\/pi\/scripts\/themerandom.sh/#\/home\/pi\/scripts\/themerandom.sh/g;' /opt/retropie/configs/all/autostart.sh
fi
sleep 2
}

function enable_script() {
dialog --infobox "...processing..." 3 20 ; sleep 2
ifexist=`cat /opt/retropie/configs/all/autostart.sh |grep themerandom |wc -l`
if [[ ${ifexist} > "0" ]]
then
  perl -pi -w -e 's/#\/home\/pi\/scripts\/themerandom.sh/\/home\/pi\/scripts\/themerandom.sh/g;' /opt/retropie/configs/all/autostart.sh
else
  cp /opt/retropie/configs/all/autostart.sh /opt/retropie/configs/all/autostart.sh.bkp
  echo "/home/pi/scripts/themerandom.sh" > /tmp/autostart.sh
  cat /opt/retropie/configs/all/autostart.sh >> /tmp/autostart.sh
  chmod 777 /tmp/autostart.sh
  cp /tmp/autostart.sh /opt/retropie/configs/all
fi
sleep 2
}

function gui_hurstythemes() {
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        options+=(U "Update install script - script will exit when updated")
        options+=(E "Enable ES bootup theme randomizer")
        options+=(D "Disable ES bootup theme randomizer")
        options+=(B "ToggleBoxy Themes Manager (200 Themes)")
        options+=(F "Mini Sweet Themes Manager (240 Themes)")
        options+=(G "Cool Themes Manager (121 Themes)")
        options+=(H "Spin Themes Manager (172 Themes)")
        options+=(I "16:9 Aspect Themes Manager (120 Themes)")
        options+=(J "5:4 Aspect Themes Manager (15 Themes)")
        options+=(K "Vertical Aspect Themes Manager (2 Themes)")
        options+=(L "Chromey Blue Themes Manager (133 Themes)")
        options+=(M "Chromey Green Themes Manager (133 Themes)")
        options+=(N "Chromey Neon Themes Manager (134 Themes)")
        options+=(O "Hursty's Picks Themes Manager (31 Themes)")
	options+=(P "Handheld (3:2, 4:3) Themes Manager (12 Themes)")
	options+=(Q "Slick Themes Manager (30 Themes)")
	options+=(R "Hyper Themes Manager (177 Themes)")
	options+=(S "Mario Themes Manager (22 Themes)")
	options+=(T "GPi (320x240) Themes Manager (37 Themes)")
	options+=(V "Comic (16:9) Themes Manager (11 Themes)")
	options+=(W "Adios (16:9) Themes Manager (99 Themes)")
	options+=(Y "Slanty (16:9) Themes Manager (77 Themes)")
	options+=(Z "Community Themes Manager (Themes by the community, not Hursty)")		
	options+=(1 "SmoothyUno (16:9) Themes Manager (153 Themes)")
	options+=(2 "SmoothyDuo (16:9) Themes Manager (118 Themes)")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's Theme Installer (2000 ES Themes made by Hursty), also includes all the Community Made Themes (located bottom of the list)" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            U)  #update install script to get new theme listings
                cd "/home/pi/RetroPie/retropiemenu" 
                mv "hurstythemes.sh" "hurstythemes.sh.bkp" 
                wget "https://raw.githubusercontent.com/retrohursty69/HurstyThemes/master/hurstythemes.sh" 
                if [[ -f "/home/pi/RetroPie/retropiemenu/hurstythemes.sh" ]]; then
                  echo "/home/pi/RetroPie/retropiemenu/hurstythemes.sh" > /tmp/errorchecking
                 else
                  mv "hurstythemes.sh.bkp" "hurstythemes.sh"
                fi
                chmod 777 "hurstythemes.sh" 
                exit
                ;;
            E)  #enable ES bootup theme randomizer
                enable_script
                ;;
            D)  #disable ES bootup theme randomizer
                disable_script
                ;;
            B)  #toggleboxy themes only
                toggleboxy_themes
                ;;                
            F)  #mini sweet themes only
                sweet_themes
                ;;
            G)  #cool themes only
                cool_themes
                ;;
            H)  #spin themes only
                spin_themes
                ;;
            I)  #16:9 themes only
                16x9_themes
                ;;
            J)  #4:3 themes only
                5x4_themes
                ;;
            K)  #vertical themes only
                vertical_themes
                ;;
            L)  #chromey blue themes only
                chromeyblue_themes
                ;;
            M)  #chromey green themes only
                chromeygreen_themes
                ;;
            N)  #chromey neon themes only
                chromeyneon_themes
                ;;
            O)  #hursty's picks
                hurstypicks_themes
                ;;
            P)  #handheld themes
                handheld_themes
                ;;
            Q)  #slick themes
                slick_themes
                ;;
            R)  #hyper themes
                hyper_themes
                ;;
            S)  #mario themes
                mario_themes
                ;;
            T)  #GPi themes
                GPi_themes
                ;;
            V)  #Comic themes
                Comic_themes
                ;;
            W)  #Adios themes
                Adios_themes
                ;;				
            Y)  #Slanty themes
                Slanty_themes
                ;;	
            Z)  #Community themes
                Community_themes
                ;;					
            1)  #SmoothyUno
                SmoothyUno_themes
                ;;					
            2)  #SmoothyDuo themes
                SmoothyDuo_themes
                ;;					
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function sweet_themes() {
    local themes=(
        'RetroHursty69 300Sweet'
        'RetroHursty69 AdventureTimeSweet'
        'RetroHursty69 AladdinSweet'
        'RetroHursty69 AlienSweet'
        'RetroHursty69 AmericanDadSweet'
        'RetroHursty69 AngryBirdSweet'
        'RetroHursty69 AnimalCrossingSweet'
        'RetroHursty69 AntManSweet'
        'RetroHursty69 AssassinsSweet'
        'RetroHursty69 AstroBoySweet'
        'RetroHursty69 AustinPowersSweet'
        'RetroHursty69 AvatarSweet'
        'RetroHursty69 BackFutureSweet'
        'RetroHursty69 BanjoSweet'
        'RetroHursty69 BatmanSweet'
        'RetroHursty69 BattletoadsSweet'
        'RetroHursty69 BayonettaSweet'
        'RetroHursty69 BeautyBeastSweet'
        'RetroHursty69 BeavisButtHeadSweet'
        'RetroHursty69 BeetleJuiceSweet'
        'RetroHursty69 BettyBoopSweet'
        'RetroHursty69 BioshockSweet'
        'RetroHursty69 BloodyRoarSweet'
        'RetroHursty69 BombermanSweet'
        'RetroHursty69 BreathofFireSweet'
        'RetroHursty69 BrianLaraSweet'
        'RetroHursty69 BubbleBobbleSweet'
        'RetroHursty69 BuffySweet'
        'RetroHursty69 BugsLifeSweet'
        'RetroHursty69 CODSweet'
        'RetroHursty69 CaptAmericaSweet'
        'RetroHursty69 CarsSweet'
        'RetroHursty69 CastlevaniaSweet'
        'RetroHursty69 ChronoTriggerSweet'
        'RetroHursty69 ChuckySweet'
        'RetroHursty69 ChunLiSweet'
        'RetroHursty69 ContraSweet'
        'RetroHursty69 CrashBandiSweet'
        'RetroHursty69 CrazyTaxiSweet'
        'RetroHursty69 CupheadSweet'
        'RetroHursty69 DKCountrySweet'
        'RetroHursty69 DarkstalkersSweet'
        'RetroHursty69 DayTentacleSweet'
        'RetroHursty69 DeadpoolSweet'
        'RetroHursty69 DeadorAliveSweet'
        'RetroHursty69 DevilMayCrySweet'
        'RetroHursty69 DiabloSweet'
        'RetroHursty69 DieHardSweet'
        'RetroHursty69 DigDugSweet'
        'RetroHursty69 DigimonSweet'
        'RetroHursty69 DoomSweet'
        'RetroHursty69 DoraemonSweet'
        'RetroHursty69 DoubleDragonSweet'
        'RetroHursty69 DrMarioSweet'
        'RetroHursty69 DrWhoSweet'
        'RetroHursty69 DragonballZSweet'
        'RetroHursty69 DragonsLairSweet'
        'RetroHursty69 DuckHuntSweet'
        'RetroHursty69 ETSweet'
        'RetroHursty69 EarthboundSweet'
        'RetroHursty69 DukeNukemSweet'
        'RetroHursty69 EarthwormJimSweet'
        'RetroHursty69 EvilDeadSweet'
        'RetroHursty69 FamilyGuySweet'
        'RetroHursty69 Fantastic4Sweet'
        'RetroHursty69 FarCrySweet'
        'RetroHursty69 FalloutSweet'
        'RetroHursty69 FatalFurySweet'
        'RetroHursty69 FelixSweet'
        'RetroHursty69 FinalFantasySweet'
        'RetroHursty69 FinalFightSweet'
        'RetroHursty69 FindingNemoSweet'
        'RetroHursty69 FlintstonesSweet'
        'RetroHursty69 FortniteSweet'
        'RetroHursty69 ForzaSweet'
        'RetroHursty69 FoxSweet'
        'RetroHursty69 FreddySweet'
        'RetroHursty69 Friday13thSweet'
        'RetroHursty69 FullThrottleSweet'
        'RetroHursty69 FuturamaSweet'
        'RetroHursty69 FuryRoadSweet'
        'RetroHursty69 FroggerSweet'
        'RetroHursty69 FZeroSweet'
        'RetroHursty69 GEXSweet'
        'RetroHursty69 GOWSweet'
        'RetroHursty69 GTASweet'
        'RetroHursty69 GhostbustersSweet'
        'RetroHursty69 GhostRiderSweet'
        'RetroHursty69 GhoulsSweet'
        'RetroHursty69 GoldenEyeSweet'
        'RetroHursty69 GranTurismoSweet'
        'RetroHursty69 GrimFandangoSweet'
        'RetroHursty69 HalfLifeSweet'
        'RetroHursty69 HaloSweet'
        'RetroHursty69 HalloweenSweet'
        'RetroHursty69 HarryPotterSweet'
        'RetroHursty69 HarvestMoonSweet'
        'RetroHursty69 HelloKittySweet'
        'RetroHursty69 HitmanSweet'
        'RetroHursty69 HulkSweet'
        'RetroHursty69 IncrediblesSweet'
        'RetroHursty69 IndianaJonesSweet'
        'RetroHursty69 InspectorGadgetSweet'
        'RetroHursty69 IronGiantSweet'
        'RetroHursty69 IronManSweet'
        'RetroHursty69 ITSweet'
        'RetroHursty69 JetSetSweet'
        'RetroHursty69 JetsonsSweet'
        'RetroHursty69 JudgeDreddSweet'
        'RetroHursty69 JurassicParkSweet'
        'RetroHursty69 KOFSweet'
        'RetroHursty69 KillerInstinctSweet'
        'RetroHursty69 KillLaKillSweet'
        'RetroHursty69 KindomHeartsSweet'
        'RetroHursty69 KirbySweet'
        'RetroHursty69 KlonoaSweet'
        'RetroHursty69 KongSweet'
        'RetroHursty69 KratosSweet'
        'RetroHursty69 LaraCroftSweet'
        'RetroHursty69 LegoSweet'
        'RetroHursty69 LionKingSweet'
        'RetroHursty69 LordRingsSweet'
        'RetroHursty69 LuigiSweet'
        'RetroHursty69 MLPSweet'
        'RetroHursty69 MOTUSweet'
        'RetroHursty69 MarioBrosSweet'
        'RetroHursty69 MarioKartSweet'
        'RetroHursty69 MarioPartySweet'
        'RetroHursty69 MartiMagicSweet'
        'RetroHursty69 MarvelvsCapcomSweet'
        'RetroHursty69 MassEffectSweet'
        'RetroHursty69 MatrixSweet'
        'RetroHursty69 MaxPayneSweet'
        'RetroHursty69 MechWarriorSweet'
        'RetroHursty69 MegaManSweet'
        'RetroHursty69 MeninBlackSweet'
        'RetroHursty69 MetalGearSweet'
        'RetroHursty69 MetalSlugSweet'
        'RetroHursty69 MetroidSweet'
        'RetroHursty69 MillenniumSweet'
        'RetroHursty69 MinecraftSweet'
        'RetroHursty69 MonkeyBallSweet'
        'RetroHursty69 MonsterHunterSweet'
        'RetroHursty69 MonstersIncSweet'
        'RetroHursty69 MooMesaSweet'
        'RetroHursty69 MortalKombatSweet'
        'RetroHursty69 MuppetsSweet'
        'RetroHursty69 MysticalNinjaSweet'
        'RetroHursty69 NinjaGaidenSweet'
        'RetroHursty69 OddWorldSweet'
        'RetroHursty69 OptimusSweet'
        'RetroHursty69 OutrunSweet'
        'RetroHursty69 OverwatchSweet'
        'RetroHursty69 PaRappaSweet'
        'RetroHursty69 PacmanSweet'
        'RetroHursty69 PaperMarioSweet'
        'RetroHursty69 ParodiusSweet'
        'RetroHursty69 PepsiManSweet'
        'RetroHursty69 PersonaSweet'
        'RetroHursty69 PikminSweet'
        'RetroHursty69 PokemonSweet'
        'RetroHursty69 PopeyeSweet'
        'RetroHursty69 PowerRangersSweet'
        'RetroHursty69 PredatorSweet'
        'RetroHursty69 PrinceofPersiaSweet'
        'RetroHursty69 ProfessorLaytonSweet'
        'RetroHursty69 PunchOutSweet'
        'RetroHursty69 QBertSweet'
        'RetroHursty69 Rainbow6Sweet'
        'RetroHursty69 RachetClankSweet'
        'RetroHursty69 RamboSweet'
        'RetroHursty69 RaymanSweet'
        'RetroHursty69 ReadyPlayer1Sweet'
        'RetroHursty69 RedDeadSweet'
        'RetroHursty69 RenStimpySweet'
        'RetroHursty69 ResidentEvilSweet'
        'RetroHursty69 RoboCopSweet'
        'RetroHursty69 RockBandSweet'
        'RetroHursty69 RogerRabbitSweet'
        'RetroHursty69 RogueSquadronSweet'
        'RetroHursty69 RyuSweet'
        'RetroHursty69 SMWorldSweet'
        'RetroHursty69 SWHothSweet'
        'RetroHursty69 SackBoySweet'
        'RetroHursty69 SamuraiShoSweet'
        'RetroHursty69 SawSweet'
        'RetroHursty69 ScoobyDooSweet'
        'RetroHursty69 ShaneWarneSweet'
        'RetroHursty69 ShrekSweet'
        'RetroHursty69 SilentHillSweet'
        'RetroHursty69 SimCitySweet'
        'RetroHursty69 SimpsonsSweet'
        'RetroHursty69 SimsSweet'
        'RetroHursty69 SmashBrosSweet'
        'RetroHursty69 SmurfsSweet'
        'RetroHursty69 SouthParkSweet'
        'RetroHursty69 SonicSweet'
        'RetroHursty69 SoulCaliburSweet'
        'RetroHursty69 SouljaBoySweet'
        'RetroHursty69 SpaceChannel5Sweet'
        'RetroHursty69 SpeedRacerSweet'
        'RetroHursty69 SpidermanSweet'
        'RetroHursty69 SplinterCellSweet'
        'RetroHursty69 SpongebobSweet'
        'RetroHursty69 SpyroSweet'
        'RetroHursty69 StarTrekSweet'
        'RetroHursty69 StrangerThingsSweet'
        'RetroHursty69 StreetsRageSweet'
        'RetroHursty69 SuicideSquadSweet'
        'RetroHursty69 SupermanSweet'
        'RetroHursty69 TMNTSweet'
        'RetroHursty69 TeamFortress2Sweet'
        'RetroHursty69 TekkenSweet'
        'RetroHursty69 TerminatorSweet'
        'RetroHursty69 ToejamEarlSweet'
        'RetroHursty69 TonyHawkSweet'
        'RetroHursty69 TotalRecallSweet'
        'RetroHursty69 ToyStorySweet'
        'RetroHursty69 TronSweet'
        'RetroHursty69 TronLegacySweet'
        'RetroHursty69 TwistedMetalSweet'
        'RetroHursty69 UnchartedSweet'
        'RetroHursty69 UpSweet'
        'RetroHursty69 VenomSweet'
        'RetroHursty69 ViewtifulJoeSweet'
        'RetroHursty69 VirtuaFighterSweet'
        'RetroHursty69 VirtuaTennisSweet'
        'RetroHursty69 WallESweet'
        'RetroHursty69 WarioSweet'
        'RetroHursty69 WitcherSweet'
        'RetroHursty69 WolfensteinSweet'
        'RetroHursty69 WonderWomanSweet'
        'RetroHursty69 WormsSweet'
        'RetroHursty69 WoWSweet'
        'RetroHursty69 WrestleManiaSweet'
        'RetroHursty69 XMenSweet'
        'RetroHursty69 YoshiSweet'
        'RetroHursty69 YuGiOhSweet'
        'RetroHursty69 ZeldaSweet'
        'RetroHursty69 ZombiesAteSweet'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function cool_themes() {
    local themes=(
        'RetroHursty69 AladdinCool'
        'RetroHursty69 AnimalCrossingCool'
	'RetroHursty69 ArmyMenCool'
        'RetroHursty69 BanjoCool'
        'RetroHursty69 BatmanCool'
	'RetroHursty69 BayonettaCool'
        'RetroHursty69 BombermanCool'
	'RetroHursty69 BowserCool'
        'RetroHursty69 BubbleBobbleCool'
	'RetroHursty69 BubsyCool'
        'RetroHursty69 CastlevaniaCool'
	'RetroHursty69 CaptainAmericaCool'
        'RetroHursty69 ContraCool'
        'RetroHursty69 CrashBandicootCool'
	'RetroHursty69 CupheadCool'
        'RetroHursty69 DarkstalkersCool'
        'RetroHursty69 DayTentacleCool'
        'RetroHursty69 DeadOrAliveCool'
        'RetroHursty69 DevilMayCryCool'
        'RetroHursty69 DKCountryCool'
        'RetroHursty69 DonkeyKongCool'
        'RetroHursty69 DoubleDragonCool'
        'RetroHursty69 DragonballZCool'
        'RetroHursty69 DrMarioCool'
        'RetroHursty69 DuckHuntCool'
        'RetroHursty69 EarthwormJimCool'
	'RetroHursty69 EggmanCool'
	'RetroHursty69 FalloutCool'
        'RetroHursty69 FatalFuryCool'
        'RetroHursty69 FinalFantasyCool'
        'RetroHursty69 FroggerCool'
        'RetroHursty69 FZeroCool'
        'RetroHursty69 GexCool'
        'RetroHursty69 GhoulsNGhostsCool'
	'RetroHursty69 GodOfWarCool'
        'RetroHursty69 GoldenEyeCool'
        'RetroHursty69 GrimFandangoCool'
        'RetroHursty69 GTACool'
	'RetroHursty69 HaloCool'
	'RetroHursty69 HarleyQuinnCool'
        'RetroHursty69 HarryPotterCool'
        'RetroHursty69 HeManCool'
        'RetroHursty69 HulkCool'
        'RetroHursty69 IncrediblesCool'
        'RetroHursty69 IndianaJonesCool'
	'RetroHursty69 InspectorGadgetCool'
        'RetroHursty69 JetSetRadioCool'
        'RetroHursty69 KillerInstinctCool'
        'RetroHursty69 KingdomHeartsCool'
        'RetroHursty69 KirbyCool'
        'RetroHursty69 KOFCool'
        'RetroHursty69 LegoCool'
        'RetroHursty69 LittleBigPlanetCool'
        'RetroHursty69 LuigiCool'
        'RetroHursty69 MarioBrosCool'
        'RetroHursty69 MarioCool'
        'RetroHursty69 MarioKartCool'
        'RetroHursty69 MarioPartyCool'
        'RetroHursty69 MegaManCool'
        'RetroHursty69 MetalSlugCool'
        'RetroHursty69 MetroidCool'
        'RetroHursty69 MGSCool'
        'RetroHursty69 MonkeyBallCool'
        'RetroHursty69 MortalKombatCool'
        'RetroHursty69 OddworldCool'
        'RetroHursty69 OutrunCool'
        'RetroHursty69 PacmanCool'
        'RetroHursty69 ParappaCool'
        'RetroHursty69 ParodiusCool'
        'RetroHursty69 PepsiManCool'
        'RetroHursty69 PikminCool'
        'RetroHursty69 PokemonCool'
        'RetroHursty69 PowerRangersCool'
        'RetroHursty69 PredatorCool'
        'RetroHursty69 PrincePersiaCool'
        'RetroHursty69 PunchOutCool'
        'RetroHursty69 QBertCool'
	'RetroHursty69 RachetClankCool'
        'RetroHursty69 RaymanCool'
        'RetroHursty69 RenStimpyCool'
        'RetroHursty69 ResidentEvilCool'
        'RetroHursty69 RobocopCool'
        'RetroHursty69 SamuraiShodownCool'
        'RetroHursty69 ShrekCool'
        'RetroHursty69 SimpsonsCool'
        'RetroHursty69 SimsCool'
        'RetroHursty69 SmashBrosCool'
        'RetroHursty69 SmurfsCool'
        'RetroHursty69 SonicCool'
        'RetroHursty69 SoulCaliburCool'
        'RetroHursty69 SouthParkCool'
        'RetroHursty69 SpaceChannel5Cool'
        'RetroHursty69 SpaceInvadersCool'
        'RetroHursty69 SpiderManCool'
	'RetroHursty69 SplatoonCool'
        'RetroHursty69 SplinterCellCool'
        'RetroHursty69 SpyroCool'
        'RetroHursty69 StarFoxCool'
        'RetroHursty69 StarTrekCool'
        'RetroHursty69 StreetFighterCool'
        'RetroHursty69 StreetsOfRageCool'
	'RetroHursty69 SubScorpionCool'
	'RetroHursty69 SupermanCool'
        'RetroHursty69 TekkenCool'
        'RetroHursty69 TMNTCool'
        'RetroHursty69 TerminatorCool'
	'RetroHursty69 ToadCool'
        'RetroHursty69 TonyHawkCool'
        'RetroHursty69 ToyStoryCool'
        'RetroHursty69 TwistedMetalCool'
	'RetroHursty69 UnchartedCool'
	'RetroHursty69 WaluigiCool'
        'RetroHursty69 WarioCool'
        'RetroHursty69 WolfensteinCool'
	'RetroHursty69 WolverineCool'
        'RetroHursty69 WormsCool'
        'RetroHursty69 WrestlemaniaCool'
        'RetroHursty69 XMenCool'
        'RetroHursty69 YoshiCool'
	'RetroHursty69 YuGiOhCool'
        'RetroHursty69 ZeldaCool'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function spin_themes() {
    local themes=(
	'RetroHursty69 AdventureTimeSpin'
	'RetroHursty69 AkumaSpin'
	'RetroHursty69 AladdinSpin'
	'RetroHursty69 AlexKiddSpin'
	'RetroHursty69 AlvinSpin'
	'RetroHursty69 AmigoSpin'
	'RetroHursty69 AngryBirdsSpin'
	'RetroHursty69 AntManSpin'
	'RetroHursty69 AquamanSpin'
	'RetroHursty69 ArcadePunksSpin'
	'RetroHursty69 ArthurSpin'
	'RetroHursty69 AstroBoySpin'
	'RetroHursty69 BatmanSpin'
	'RetroHursty69 BirdoSpin'
	'RetroHursty69 BisonSpin'
	'RetroHursty69 BlankaSpin'	
	'RetroHursty69 BombermanSpin'
	'RetroHursty69 BOrchidSpin'	
	'RetroHursty69 BowserSpin'
	'RetroHursty69 BubbleBobbleSpin'
	'RetroHursty69 CaptainAmericaSpin'
	'RetroHursty69 CharizardSpin'
	'RetroHursty69 ChunLiSpin'
	'RetroHursty69 CODSpin'
	'RetroHursty69 CrashBandicootSpin'
	'RetroHursty69 CupHeadSpin'
	'RetroHursty69 DarthSpin'
	'RetroHursty69 DeadpoolSpin'
	'RetroHursty69 DiddyKongSpin'
	'RetroHursty69 DigDugSpin'
	'RetroHursty69 DigimonSpin'
	'RetroHursty69 DixieKongSpin'
	'RetroHursty69 DonaldDuckSpin'
	'RetroHursty69 DonkeyKongSpin'
	'RetroHursty69 DoomSpin'
	'RetroHursty69 DoraSpin'
	'RetroHursty69 DoreamonSpin'
	'RetroHursty69 DragonballZSpin'
	'RetroHursty69 DrBonesSpin'
	'RetroHursty69 DrEggmanSpin'
	'RetroHursty69 DrMarioSpin'
	'RetroHursty69 DuckHuntSpin'
	'RetroHursty69 DukeNukemSpin'
	'RetroHursty69 EarthwormJimSpin'
	'RetroHursty69 ETSpin'
	'RetroHursty69 FalloutSpin'
	'RetroHursty69 FatalFurySpin'
	'RetroHursty69 FinalFantasySpin'
	'RetroHursty69 FortnightSpin'
	'RetroHursty69 FreddySpin'
	'RetroHursty69 FroggerSpin'
	'RetroHursty69 FZeroSpin'
	'RetroHursty69 GameWatchSpin'
	'RetroHursty69 GarfieldSpin'
	'RetroHursty69 GexSpin'
	'RetroHursty69 GhoulsNGhostsSpin'
	'RetroHursty69 GodOfWarSpin'
	'RetroHursty69 GoombaSpin'
	'RetroHursty69 GrimFandangoSpin'
	'RetroHursty69 GTASpin'
	'RetroHursty69 HalfLifeSpin'
	'RetroHursty69 HaloSpin'
	'RetroHursty69 HarleyQuinnSpin'
	'RetroHursty69 HulkSpin'
	'RetroHursty69 IncrediblesSpin'
	'RetroHursty69 IncineroarSpin'
	'RetroHursty69 IndianaJonesSpin'
	'RetroHursty69 IronManSpin'
	'RetroHursty69 JasonSpin'
	'RetroHursty69 JetSetRadioSpin'
	'RetroHursty69 JinSpin'
	'RetroHursty69 JuggernautSpin'
	'RetroHursty69 KamekSpin'
	'RetroHursty69 KillerInstinctSpin'
	'RetroHursty69 KindomHeartsSpin'
	'RetroHursty69 KingDededeSpin'
	'RetroHursty69 KingRKoolSpin'
	'RetroHursty69 KingSpin'
	'RetroHursty69 KirbySpin'
	'RetroHursty69 KlonoaSpin'
	'RetroHursty69 KOFSpin'
	'RetroHursty69 LarryKoopaSpin'
	'RetroHursty69 LegoSpin'
	'RetroHursty69 LittleBigPlanetSpin'
	'RetroHursty69 LionKingSpin'
	'RetroHursty69 LucarioSpin'
	'RetroHursty69 LudwigSpin'
	'RetroHursty69 LuigiSpin'
	'RetroHursty69 LukeSpin'
	'RetroHursty69 MadHatterSpin'
	'RetroHursty69 MarioSpin'
	'RetroHursty69 MegamanSpin'
	'RetroHursty69 Megatron80sSpin'
	'RetroHursty69 MetalSlugSpin'
	'RetroHursty69 MetroidSpin'
	'RetroHursty69 MickeySpin'
	'RetroHursty69 MileenaSpin'
	'RetroHursty69 MinecraftSpin'
	'RetroHursty69 MonkeyBallSpin'
	'RetroHursty69 MonstersIncSpin'
	'RetroHursty69 MorpheusSpin'
	'RetroHursty69 MortalKombatSpin'
	'RetroHursty69 MrKarateSpin'
	'RetroHursty69 NabbitSpin'
	'RetroHursty69 NightsSpin'
	'RetroHursty69 OddworldSpin'
	'RetroHursty69 OptimusSpin'
	'RetroHursty69 Optimus80sSpin'
	'RetroHursty69 PacmanSpin'
	'RetroHursty69 ParappaSpin'
	'RetroHursty69 ParodiusSpin'
	'RetroHursty69 PikminSpin'
	'RetroHursty69 PokemonSpin'
	'RetroHursty69 PowerPuffSpin'
	'RetroHursty69 PredatorSpin'
	'RetroHursty69 PrincePersiaSpin'
	'RetroHursty69 ProfessorLaytonSpin'
	'RetroHursty69 PunchoutSpin'
	'RetroHursty69 QBertSpin'
	'RetroHursty69 RachetClankSpin'
    'RetroHursty69 RaidenSpin'	
	'RetroHursty69 RaymanSpin'
	'RetroHursty69 RetroArenaSpin'
	'RetroHursty69 ReaperSpin'
	'RetroHursty69 RoboCopSpin'
	'RetroHursty69 RogueSpin'
	'RetroHursty69 ScoobySpin'
	'RetroHursty69 ScorpionSpin'
	'RetroHursty69 SF3Spin'
	'RetroHursty69 ShredderSpin'
	'RetroHursty69 ShrekSpin'
	'RetroHursty69 ShyGuySpin'
	'RetroHursty69 SimpsonsSpin'
	'RetroHursty69 SimsSpin'
	'RetroHursty69 SmashBrosSpin'
	'RetroHursty69 SmurfsSpin'
	'RetroHursty69 SonicSpin'
	'RetroHursty69 SoulCaliburSpin'
	'RetroHursty69 SouthParkSpin'
	'RetroHursty69 SpaceChannel5Spin'
	'RetroHursty69 SpaceInvadersSpin'
	'RetroHursty69 SpidermanSpin'
	'RetroHursty69 SpikeSpin'
	'RetroHursty69 SplattoonSpin'
	'RetroHursty69 SplinterCellSpin'
	'RetroHursty69 SpongeBobSpin'
	'RetroHursty69 SpyroSpin'
	'RetroHursty69 StarFoxSpin'
	'RetroHursty69 StreetFighterSpin'
	'RetroHursty69 StreetsOfRageSpin'
	'RetroHursty69 SubZeroSpin'
	'RetroHursty69 SupermanSpin'
	'RetroHursty69 TailsSpin'
	'RetroHursty69 TekkenSpin'
	'RetroHursty69 TerminatorSpin'
	'RetroHursty69 TJComboSpin'
	'RetroHursty69 TMNTSpin'
	'RetroHursty69 ToadSpin'
	'RetroHursty69 ToyStorySpin'
	'RetroHursty69 WallESpin'
	'RetroHursty69 WaluigiSpin'
	'RetroHursty69 WarioSpin'
	'RetroHursty69 WendyOKoopaSpin'
	'RetroHursty69 WolfSpin'
	'RetroHursty69 WormsSpin'
	'RetroHursty69 WreckItSpin'
	'RetroHursty69 WrestlingSpin'
	'RetroHursty69 XMenSpin'
	'RetroHursty69 YodaSpin'
	'RetroHursty69 YoshiSpin'
	'RetroHursty69 ZeldaSpin'
	'RetroHursty69 ZeroSuitSpin'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function 16x9_themes() {
    local themes=(
        'RetroHursty69 2DAI4_Ratio_16-9'
        'RetroHursty69 AIGEN'
        'RetroHursty69 AIGEN_EXTRA'
        'RetroHursty69 AIGEN_PLUS'
        'RetroHursty69 back2basics'
        'RetroHursty69 ballsy'
        'RetroHursty69 batmanburton'
        'RetroHursty69 bitfit'
		'RetroHursty69 bluesteel'
		'RetroHursty69 blueprism'
		'RetroHursty69 bluesmooth'	
        'RetroHursty69 bluray'
		'RetroHursty69 BoomBoxStreet'
        'RetroHursty69 boxalloyblue'
        'RetroHursty69 boxalloyred'
        'RetroHursty69 boxcity'
        'RetroHursty69 cabsnazzy'
		'RetroHursty69 CapcomColorHorizontal'
		'RetroHursty69 CapcomColorSpin'
		'RetroHursty69 CapcomColorVertical'
        'RetroHursty69 cardcrazy'
		'RetroHursty69 Card_Decky_16x9'
        'RetroHursty69 circuit'
		'RetroHursty69 CircularEssence'
		'RetroHursty69 ColorfulExtreme'
		'RetroHursty69 ColorfulSupreme'
		'RetroHursty69 ComicCover16x9'
        'RetroHursty69 comiccrazy'
        'RetroHursty69 corg'
		'RetroHursty69 CosmicRise'
        'RetroHursty69 crisp'
        'RetroHursty69 crisp_light'
		'RetroHursty69 CRTBlast'
		'RetroHursty69 CRTCabBlast'
		'RetroHursty69 CRTNeonBlast'
        'RetroHursty69 cyber'
        'RetroHursty69 darkswitch'
        'RetroHursty69 deflection_blue'
        'RetroHursty69 deflection_green'
        'RetroHursty69 deflection_grey'
        'RetroHursty69 deflection_purple'
        'RetroHursty69 disenchantment'
        'RetroHursty69 donkeykonkey'
        'RetroHursty69 DracosRetroCade'
        'RetroHursty69 dragonballz'
		'RetroHursty69 DragonQuestFloyd'
        'RetroHursty69 evilresident'
        'RetroHursty69 fabuloso'
		'RetroHursty69 floyd'
		'RetroHursty69 floyd_arcade'
		'RetroHursty69 floyd_room'
		'RetroHursty69 garfieldism'
        'RetroHursty69 gametime'
        'RetroHursty69 ghostbusters'
        'RetroHursty69 graffiti'
        'RetroHursty69 greenilicious'
        'RetroHursty69 halloweenspecial'
        'RetroHursty69 heman'
        'RetroHursty69 heychromey'
        'RetroHursty69 homerism'
        'RetroHursty69 hurstybluetake2'
        'RetroHursty69 hurstyspin'
        'RetroHursty69 incredibles'
        'RetroHursty69 infinity'
        'RetroHursty69 joysticks'
        'RetroHursty69 license2game'
        'RetroHursty69 lightswitch'
        'RetroHursty69 magazinemadness'
        'RetroHursty69 magazinemadness2'
		'RetroHursty69 marco'
		'RetroHursty69 mariobrosiii'
        'RetroHursty69 mario_melee'
        'RetroHursty69 merryxmas'
        'RetroHursty69 meshy'
        'RetroHursty69 minecraft'
        'RetroHursty69 minions'
        'RetroHursty69 mysticorb'
        'RetroHursty69 NegativeColor'
        'RetroHursty69 NegativeSepia'
        'RetroHursty69 NeonFantasy'
        'RetroHursty69 neogeo_only'
        'RetroHursty69 orbpilot'
        'RetroHursty69 pacman'
        'RetroHursty69 pitube'
		'RetroHursty69 PopCom16x9'
		'RetroHursty69 PopCombo16x9'
        'RetroHursty69 primo'
        'RetroHursty69 primo_light'
        'RetroHursty69 realghostbusters'	
        'RetroHursty69 retroboy'
        'RetroHursty69 retroboy2'
        'RetroHursty69 retrogamenews'
        'RetroHursty69 retroroid'
		'RetroHursty69 ShabangCLEAN'
		'RetroHursty69 ShabangCRT'
        'RetroHursty69 ShadowClean'
        'RetroHursty69 Sheeny'
		'RetroHursty69 shine'		
        'RetroHursty69 snapback'
        'RetroHursty69 snazzy'
        'RetroHursty69 soda'
        'RetroHursty69 spaceinvaders'
        'RetroHursty69 stirling'
		'RetroHursty69 stirlingness'
        'RetroHursty69 sublime'
        'RetroHursty69 supersweet'
        'RetroHursty69 swatch'
		'RetroHursty69 sweet_tinkerboard'
		'RetroHursty69 sweeter_tinkerboard'
		'RetroHursty69 synthy16x9'
		'RetroHursty69 supersynthy16x9'		
        'RetroHursty69 tmnt'
        'RetroHursty69 tributeGoT'
        'RetroHursty69 tributeSTrek'
        'RetroHursty69 tributeSWars'
        'RetroHursty69 ToggleBobble'        
		'RetroHursty69 uniflyered'
		'RetroHursty69 Vinyl-Hits'
        'RetroHursty69 whiteslide'
        'RetroHursty69 whitewood'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function 5x4_themes() {
    local themes=(
        'RetroHursty69 PopCom5x4'
		'RetroHursty69 ComicCover5x4'
		'RetroHursty69 synthyA1UP'
		'RetroHursty69 supersynthyA1UP'
		'RetroHursty69 Shabang5x4'		
        'RetroHursty69 Card_Decky_5x4'		
		'RetroHursty69 2DAI4_Ratio_5-4'
        'RetroHursty69 arcade1up_aspectratio54'
        'RetroHursty69 heychromey_aspectratio54'
        'RetroHursty69 hurstyuparcade_aspectratio54'
        'RetroHursty69 supersweet_aspectratio54'
        'RetroHursty69 arcade1up_spaceinv2_vertical'
        'RetroHursty69 Vertical-Limit-A1UP-1024x1280'
		'RetroHursty69 MK54'
		'RetroHursty69 BoomBoxStreet4x3'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function toggleboxy_themes() {
    local themes=(
'RetroHursty69 TB_AddamsFamily'
'RetroHursty69 TB_AdvanceWars'
'RetroHursty69 TB_AeroAcrobat'
'RetroHursty69 TB_AlexKidd' 
'RetroHursty69 TB_Aliens'
'RetroHursty69 TB_Aquaman'
'RetroHursty69 TB_Arcade'
'RetroHursty69 TB_ArcTheLad'
'RetroHursty69 TB_ArmyMen'
'RetroHursty69 TB_Asterix'
'RetroHursty69 TB_BanjoKazooie'
'RetroHursty69 TB_Barbie'
'RetroHursty69 TB_Batman' 
'RetroHursty69 TB_Battletoads'
'RetroHursty69 TB_Bayonette'
'RetroHursty69 TB_BeavisButthead'
'RetroHursty69 TB_Bejewled'
'RetroHursty69 TB_Billiards'
'RetroHursty69 TB_Bomberman' 
'RetroHursty69 TB_Boogerman'
'RetroHursty69 TB_Bowser' 
'RetroHursty69 TB_BTTF'
'RetroHursty69 TB_BubbleBobble' 
'RetroHursty69 TB_Bubsy' 
'RetroHursty69 TB_BuckRogers'
'RetroHursty69 TB_BueautyBeast'
'RetroHursty69 TB_BugsBunny'
'RetroHursty69 TB_CanonFodder'
'RetroHursty69 TB_Castlevania' 
'RetroHursty69 TB_ChesterCheetah'
'RetroHursty69 TB_Conker'
'RetroHursty69 TB_CoolSpot'
'RetroHursty69 TB_CrashBandicoot' 
'RetroHursty69 TB_CrazyTaxi'
'RetroHursty69 TB_DaffyDuck'
'RetroHursty69 TB_Darkstalkers' 
'RetroHursty69 TB_Digimon' 
'RetroHursty69 TB_DKCountry' 
'RetroHursty69 TB_DKJunior' 
'RetroHursty69 TB_DonkeyKong' 
'RetroHursty69 TB_Dragonball' 
'RetroHursty69 TB_DragonQuest'
'RetroHursty69 TB_DragonsLair' 
'RetroHursty69 TB_DrMario'
'RetroHursty69 TB_DuckHunt'
'RetroHursty69 TB_DukeNukem'
'RetroHursty69 TB_DungeonsDragons'
'RetroHursty69 TB_EarthwormJim' 
'RetroHursty69 TB_Easter'
'RetroHursty69 TB_Ecco'
'RetroHursty69 TB_FantasticFour'
'RetroHursty69 TB_FatalFury' 
'RetroHursty69 TB_FIFA'
'RetroHursty69 TB_FinalFantasy' 
'RetroHursty69 TB_FireEmblem'
'RetroHursty69 TB_Flintstones'
'RetroHursty69 TB_Frogger' 
'RetroHursty69 TB_FZero' 
'RetroHursty69 TB_Galaga' 
'RetroHursty69 TB_GameAndWatch' 
'RetroHursty69 TB_Gauntlet' 
'RetroHursty69 TB_Gex' 
'RetroHursty69 TB_Ghostbusters'
'RetroHursty69 TB_GhoulsGhosts' 
'RetroHursty69 TB_Godzilla'
'RetroHursty69 TB_GoldenSun'
'RetroHursty69 TB_Goofy'
'RetroHursty69 TB_GrimFandango' 
'RetroHursty69 TB_GTA' 
'RetroHursty69 TB_GuiltyGear'
'RetroHursty69 TB_Gundam'
'RetroHursty69 TB_HalfLife' 
'RetroHursty69 TB_Halloween'
'RetroHursty69 TB_Halo' 
'RetroHursty69 TB_HanSolo'
'RetroHursty69 TB_HarvestMoon'
'RetroHursty69 TB_HelloKitty'
'RetroHursty69 TB_Hockey'
'RetroHursty69 TB_HomeAlone'
'RetroHursty69 TB_Hook'
'RetroHursty69 TB_HotShotsGolf'
'RetroHursty69 TB_Hulk' 
'RetroHursty69 TB_HulkHogan'
'RetroHursty69 TB_IndianaJones'
'RetroHursty69 TB_IronMan'     
'RetroHursty69 TB_JamesBond'
'RetroHursty69 TB_JamesPond'
'RetroHursty69 TB_JetSetRadio'
'RetroHursty69 TB_JohnMadden'
'RetroHursty69 TB_JurassicPark'
'RetroHursty69 TB_KillerInstinct'
'RetroHursty69 TB_KingdomHearts'
'RetroHursty69 TB_KingOfFighters'
'RetroHursty69 TB_Kirby'
'RetroHursty69 TB_Krusty'
'RetroHursty69 TB_Lego'
'RetroHursty69 TB_Lemmings'
'RetroHursty69 TB_LionKing'
'RetroHursty69 TB_LittleBigPlanet' 
'RetroHursty69 TB_Luigi'
'RetroHursty69 TB_LuigisMansion'
'RetroHursty69 TB_Mario1'
'RetroHursty69 TB_Mario2'
'RetroHursty69 TB_MarioGolf'
'RetroHursty69 TB_MarioKart'
'RetroHursty69 TB_MarioParty'
'RetroHursty69 TB_MarioStrikers'
'RetroHursty69 TB_MarioTennis'
'RetroHursty69 TB_Medievil'
'RetroHursty69 TB_Megaman'
'RetroHursty69 TB_MetalGear'
'RetroHursty69 TB_MetalSlug'
'RetroHursty69 TB_Metroid'
'RetroHursty69 TB_MickeyMouse'
'RetroHursty69 TB_MicroMachines'
'RetroHursty69 TB_Minecraft'
'RetroHursty69 TB_MonkeyBall'
'RetroHursty69 TB_MortalKombat'
'RetroHursty69 TB_MrDriller'
'RetroHursty69 TB_MsPacman'   
'RetroHursty69 TB_Muppets'
'RetroHursty69 TB_NASCAR'
'RetroHursty69 TB_NFL'
'RetroHursty69 TB_Nintendogs'
'RetroHursty69 TB_Octopath'
'RetroHursty69 TB_Oddworld'
'RetroHursty69 TB_Pacman'
'RetroHursty69 TB_Persona'
'RetroHursty69 TB_Pikmin'
'RetroHursty69 TB_Pinball'
'RetroHursty69 TB_Pitfall'
'RetroHursty69 TB_PlantsVsZombies'
'RetroHursty69 TB_PointBlank'
'RetroHursty69 TB_Pokemon'
'RetroHursty69 TB_Predator'
'RetroHursty69 TB_PrinceOfPersia'
'RetroHursty69 TB_PrincessPeach'
'RetroHursty69 TB_ProfessorLayton'
'RetroHursty69 TB_Punchout'
'RetroHursty69 TB_PuyoPuyo'
'RetroHursty69 TB_Puzzle'
'RetroHursty69 TB_PwerRangers'
'RetroHursty69 TB_QBert'
'RetroHursty69 TB_Quake'
'RetroHursty69 TB_Rambo'
'RetroHursty69 TB_Ratchet'
'RetroHursty69 TB_Rayman'
'RetroHursty69 TB_RealGhostbusters'
'RetroHursty69 TB_ResidentEvil'
'RetroHursty69 TB_RoadRash'
'RetroHursty69 TB_Robocop'
'RetroHursty69 TB_SamuraiShodown'
'RetroHursty69 TB_Scooby'
'RetroHursty69 TB_Scribblenauts'
'RetroHursty69 TB_SecretOfMana'
'RetroHursty69 TB_Shenmue'
'RetroHursty69 TB_ShovelKnight'
'RetroHursty69 TB_Simpsons'
'RetroHursty69 TB_Sims'
'RetroHursty69 TB_SmashBros'
'RetroHursty69 TB_Smurfs'
'RetroHursty69 TB_SonicModern'
'RetroHursty69 TB_SonicRetro'
'RetroHursty69 TB_SoulCalibur'
'RetroHursty69 TB_SouthPark'
'RetroHursty69 TB_SpaceChannel5'
'RetroHursty69 TB_SpaceInvaders'
'RetroHursty69 TB_SpiderMan'
'RetroHursty69 TB_Splatoon'
'RetroHursty69 TB_SplinterCell'
'RetroHursty69 TB_SpongeBob'
'RetroHursty69 TB_Spyro'
'RetroHursty69 TB_Starfox'
'RetroHursty69 TB_StarTrek'
'RetroHursty69 TB_StarWars'
'RetroHursty69 TB_StreetFighter'
'RetroHursty69 TB_StreetsOfRage'
'RetroHursty69 TB_Superman'
'RetroHursty69 TB_Tekken'
'RetroHursty69 TB_Tennis'
'RetroHursty69 TB_Tetris'
'RetroHursty69 TB_TigerWoods'
'RetroHursty69 TB_TMNT'
'RetroHursty69 TB_Toad'
'RetroHursty69 TB_ToeJam'
'RetroHursty69 TB_TombRaider'
'RetroHursty69 TB_ToyStory'
'RetroHursty69 TB_Tron'
'RetroHursty69 TB_TwistedMetal'
'RetroHursty69 TB_VirtuaFighter'
'RetroHursty69 TB_Wario'
'RetroHursty69 TB_Wonderful101'
'RetroHursty69 TB_Worms'
'RetroHursty69 TB_Wrestlemania'
'RetroHursty69 TB_Xenoblade'
'RetroHursty69 TB_Xmas'
'RetroHursty69 TB_XMen'
'RetroHursty69 TB_Yoda'
'RetroHursty69 TB_Zelda'
'RetroHursty69 TB_Zool'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function vertical_themes() {
    local themes=(
        'RetroHursty69 vertical_arcade'
	'RetroHursty69 vertical_limit_verticaltheme'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function chromeyblue_themes() {
    local themes=(
	'RetroHursty69 1943Blue'
	'RetroHursty69 AladdinBlue'
	'RetroHursty69 AlexKiddBlue'
	'RetroHursty69 AngryBirdsBlue'
	'RetroHursty69 AntManBlue'
	'RetroHursty69 AquamanBlue'
	'RetroHursty69 AsteroidsBlue'
	'RetroHursty69 AstroBoyBlue'
	'RetroHursty69 BatmanBlue'
	'RetroHursty69 BombermanBlue'
	'RetroHursty69 BubbleBobbleBlue'
	'RetroHursty69 BumbleBeeBlue'
	'RetroHursty69 CaptainAmericaBlue'
	'RetroHursty69 DarkstalkersBlue'
	'RetroHursty69 DayTentacleBlue'
	'RetroHursty69 DaytonaUsaBlue'
	'RetroHursty69 DeadpoolBlue'
	'RetroHursty69 DigimonBlue'
	'RetroHursty69 DonkeyKongBlue'
	'RetroHursty69 DonkeyKongCountryBlue'
	'RetroHursty69 DrMarioBlue'
	'RetroHursty69 DragonBallZBlue'
	'RetroHursty69 DragonsLairBlue'
	'RetroHursty69 DukeNukemBlue'
	'RetroHursty69 ETBlue'
	'RetroHursty69 EarthwormJimBlue'	
	'RetroHursty69 ElevatorActionBlue'
	'RetroHursty69 FZeroBlue'	
	'RetroHursty69 FalloutBlue'
	'RetroHursty69 FatalFuryBlue'
	'RetroHursty69 FinalFantasyBlue'
	'RetroHursty69 FinalFightBlue'    	
	'RetroHursty69 FortniteBlue'
	'RetroHursty69 FroggerBlue'
	'RetroHursty69 FullThrottleBlue'
	'RetroHursty69 GTABlue'
	'RetroHursty69 GalagaBlue'
	'RetroHursty69 GalaxianBlue'
	'RetroHursty69 GameAndWatchBlue'
	'RetroHursty69 GarfieldBlue'
	'RetroHursty69 GauntletBlue'
	'RetroHursty69 GexBlue'
	'RetroHursty69 GhoulsNGhostsBlue'
	'RetroHursty69 GodOfWarBlue'
	'RetroHursty69 GrimFandangoBlue'
	'RetroHursty69 HalfLifeBlue'
	'RetroHursty69 HaloBlue'	
	'RetroHursty69 HarleyQuinnBlue'
	'RetroHursty69 HulkBlue'
	'RetroHursty69 IncrediblesBlue'
	'RetroHursty69 IndianaJonesBlue'
	'RetroHursty69 IronManBlue'
	'RetroHursty69 JetSetRadioBlue'
	'RetroHursty69 KOFBlue'
	'RetroHursty69 KillerInstinctBlue'
	'RetroHursty69 KingKRoolBlue'	
	'RetroHursty69 KingdomHeartsBlue'
	'RetroHursty69 KirbyBlue'
	'RetroHursty69 LegoBlue'
	'RetroHursty69 LittleBigPlanetBlue'
	'RetroHursty69 LuigiBlue'
	'RetroHursty69 ManiacMansionBlue'
	'RetroHursty69 MarioBlue'
	'RetroHursty69 MatrixBlue'
	'RetroHursty69 MegaManBlue'
	'RetroHursty69 MetalSlugBlue'
	'RetroHursty69 MetroidBlue'
	'RetroHursty69 MickeyMouseBlue'	
	'RetroHursty69 MinecraftBlue'
	'RetroHursty69 MonkeyBallBlue'
	'RetroHursty69 MortalKombatBlue'
	'RetroHursty69 OddworldBlue'
	'RetroHursty69 OptimusPrimeBlue'
	'RetroHursty69 OutRunBlue'
	'RetroHursty69 PacmanBlue'
	'RetroHursty69 ParappaBlue'
	'RetroHursty69 PitfallBlue'
	'RetroHursty69 PikminBlue'
	'RetroHursty69 PokemonBlue'
	'RetroHursty69 PowerPuffBlue'
	'RetroHursty69 PredatorBlue'	
	'RetroHursty69 PrincePersiaBlue'
	'RetroHursty69 ProfessorLaytonBlue'
	'RetroHursty69 PunchOutBlue'
	'RetroHursty69 QBertBlue'
	'RetroHursty69 RactchetClankBlue'
	'RetroHursty69 RaymanBlue'
	'RetroHursty69 ResidentEvilBlue'
	'RetroHursty69 RidgeRacerBlue'
	'RetroHursty69 RoboCopBlue'
	'RetroHursty69 SF2Blue'
	'RetroHursty69 SF3rdStrikeBlue'
	'RetroHursty69 ScoobyDooBlue'
	'RetroHursty69 ShenmueBlue'    	
	'RetroHursty69 ShrekBlue'
	'RetroHursty69 SimCityBlue'
	'RetroHursty69 SimpsonsBlue'
	'RetroHursty69 SimsBlue'
	'RetroHursty69 SmashBrosBlue'
	'RetroHursty69 SmurfsBlue'
	'RetroHursty69 SonicBlue'
	'RetroHursty69 SoulCaliburBlue'
	'RetroHursty69 SouthParkBlue'
	'RetroHursty69 SpaceAceBlue'
	'RetroHursty69 SpaceChannel5Blue'
	'RetroHursty69 SpaceInvadersBlue'
	'RetroHursty69 SpidermanBlue'
	'RetroHursty69 SplatoonBlue'
	'RetroHursty69 SplinterCellBlue'
	'RetroHursty69 SpongeBobBlue'
	'RetroHursty69 SpyroBlue'
	'RetroHursty69 StarFoxBlue'
	'RetroHursty69 StarWarsBlue'
	'RetroHursty69 StreetFighterBlue'
	'RetroHursty69 StreetsOfRageBlue'
	'RetroHursty69 SupermanBlue'
	'RetroHursty69 TMNTBlue'
	'RetroHursty69 TekkenBlue'
	'RetroHursty69 TerminatorBlue'
	'RetroHursty69 TetrisBlue'
	'RetroHursty69 ToadBlue'
	'RetroHursty69 TombRaiderBlue'
	'RetroHursty69 ToyStoryBlue'
	'RetroHursty69 TronBlue'
	'RetroHursty69 TwistedMetalBlue'
	'RetroHursty69 VirtuaFighterBlue'
	'RetroHursty69 WWEBlue'
	'RetroHursty69 WaluigiBlue'
	'RetroHursty69 WarioBlue'
	'RetroHursty69 WormsBlue'
	'RetroHursty69 XMenBlue'
	'RetroHursty69 YoshiBlue'
	'RetroHursty69 ZeldaBlue'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function chromeygreen_themes() {
    local themes=(
	'RetroHursty69 1943Green'
	'RetroHursty69 AladdinGreen'
	'RetroHursty69 AlexKiddGreen'
	'RetroHursty69 AngryBirdsGreen'
	'RetroHursty69 AntManGreen'
	'RetroHursty69 AquamanGreen'
	'RetroHursty69 AsteroidsGreen'
	'RetroHursty69 AstroBoyGreen'
	'RetroHursty69 BatmanGreen'
	'RetroHursty69 BombermanGreen'
	'RetroHursty69 BubbleBobbleGreen'
	'RetroHursty69 BumbleBeeGreen'
	'RetroHursty69 CaptainAmericaGreen'
	'RetroHursty69 DarkstalkersGreen'
	'RetroHursty69 DayTentacleGreen'
	'RetroHursty69 DaytonaUsaGreen'
	'RetroHursty69 DeadpoolGreen'
	'RetroHursty69 DigimonGreen'
	'RetroHursty69 DonkeyKongCountryGreen'
	'RetroHursty69 DonkeyKongGreen'
	'RetroHursty69 DrMarioGreen'
	'RetroHursty69 DragonBallZGreen'
	'RetroHursty69 DragonsLairGreen'
	'RetroHursty69 DukeNukemGreen'
	'RetroHursty69 ETGreen'
	'RetroHursty69 EarthwormJimGreen'	
	'RetroHursty69 ElevatorActionGreen'
	'RetroHursty69 FZeroGreen'	
	'RetroHursty69 FalloutGreen'
	'RetroHursty69 FatalFuryGreen'
	'RetroHursty69 FinalFantasyGreen'
	'RetroHursty69 FinalFightGreen'    	
	'RetroHursty69 FortniteGreen'
	'RetroHursty69 FroggerGreen'
	'RetroHursty69 FullThrottleGreen'
	'RetroHursty69 GTAGreen'
	'RetroHursty69 GalagaGreen'
	'RetroHursty69 GalaxianGreen'
	'RetroHursty69 GameAndWatchGreen'
	'RetroHursty69 GarfieldGreen'
	'RetroHursty69 GauntletGreen'
	'RetroHursty69 GexGreen'
	'RetroHursty69 GhoulsNGhostsGreen'
	'RetroHursty69 GodOfWarGreen'
	'RetroHursty69 GrimFandangoGreen'
	'RetroHursty69 HalfLifeGreen'
	'RetroHursty69 HaloGreen'	
	'RetroHursty69 HarleyQuinnGreen'
	'RetroHursty69 HulkGreen'
	'RetroHursty69 IncrediblesGreen'
	'RetroHursty69 IndianaJonesGreen'
	'RetroHursty69 IronManGreen'
	'RetroHursty69 JetSetRadioGreen'
	'RetroHursty69 KOFGreen'
	'RetroHursty69 KillerInstinctGreen'
	'RetroHursty69 KingKRoolGreen'	
	'RetroHursty69 KingdomHeartsGreen'
	'RetroHursty69 KirbyGreen'
	'RetroHursty69 LegoGreen'
	'RetroHursty69 LittleBigPlanetGreen'
	'RetroHursty69 LuigiGreen'
	'RetroHursty69 ManiacMansionGreen'
	'RetroHursty69 MarioGreen'
	'RetroHursty69 MatrixGreen'
	'RetroHursty69 MegaManGreen'
	'RetroHursty69 MetalSlugGreen'
	'RetroHursty69 MetroidGreen'
	'RetroHursty69 MickeyMouseGreen'	
	'RetroHursty69 MinecraftGreen'
	'RetroHursty69 MonkeyBallGreen'
	'RetroHursty69 MortalKombatGreen'
	'RetroHursty69 OddworldGreen'
	'RetroHursty69 OptimusPrimeGreen'
	'RetroHursty69 OutRunGreen'
	'RetroHursty69 PacmanGreen'
	'RetroHursty69 ParappaGreen'
	'RetroHursty69 PitfallGreen'
	'RetroHursty69 PikminGreen'
	'RetroHursty69 PokemonGreen'
	'RetroHursty69 PowerPuffGreen'
	'RetroHursty69 PredatorGreen'	
	'RetroHursty69 PrincePersiaGreen'
	'RetroHursty69 ProfessorLaytonGreen'
	'RetroHursty69 PunchOutGreen'
	'RetroHursty69 QBertGreen'
	'RetroHursty69 RactchetClankGreen'
	'RetroHursty69 RaymanGreen'
	'RetroHursty69 ResidentEvilGreen'
	'RetroHursty69 RidgeRacerGreen'
	'RetroHursty69 RoboCopGreen'
	'RetroHursty69 SF2Green'
	'RetroHursty69 SF3rdStrikeGreen'
	'RetroHursty69 ScoobyDooGreen'
	'RetroHursty69 ShenmueGreen'    	
	'RetroHursty69 ShrekGreen'
	'RetroHursty69 SimCityGreen'
	'RetroHursty69 SimpsonsGreen'
	'RetroHursty69 SimsGreen'
	'RetroHursty69 SmashBrosGreen'
	'RetroHursty69 SmurfsGreen'
	'RetroHursty69 SonicGreen'
	'RetroHursty69 SoulCaliburGreen'
	'RetroHursty69 SouthParkGreen'
	'RetroHursty69 SpaceAceGreen'
	'RetroHursty69 SpaceChannel5Green'
	'RetroHursty69 SpaceInvadersGreen'
	'RetroHursty69 SpidermanGreen'
	'RetroHursty69 SplatoonGreen'
	'RetroHursty69 SplinterCellGreen'
	'RetroHursty69 SpongeBobGreen'
	'RetroHursty69 SpyroGreen'
	'RetroHursty69 StarFoxGreen'
	'RetroHursty69 StarWarsGreen'
	'RetroHursty69 StreetFighterGreen'
	'RetroHursty69 StreetsOfRageGreen'
	'RetroHursty69 SupermanGreen'
	'RetroHursty69 TMNTGreen'
	'RetroHursty69 TekkenGreen'
	'RetroHursty69 TerminatorGreen'
	'RetroHursty69 TetrisGreen'
	'RetroHursty69 ToadGreen'
	'RetroHursty69 TombRaiderGreen'
	'RetroHursty69 ToyStoryGreen'
	'RetroHursty69 TronGreen'
	'RetroHursty69 TwistedMetalGreen'
	'RetroHursty69 VirtuaFighterGreen'
	'RetroHursty69 WWEGreen'
	'RetroHursty69 WaluigiGreen'
	'RetroHursty69 WarioGreen'
	'RetroHursty69 WormsGreen'
	'RetroHursty69 XMenGreen'
	'RetroHursty69 YoshiGreen'
	'RetroHursty69 ZeldaGreen'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function chromeyneon_themes() {
    local themes=(
	'RetroHursty69 1943Neon'
	'RetroHursty69 AladdinNeon'
	'RetroHursty69 AlexKiddNeon'
	'RetroHursty69 AngryBirdsNeon'
	'RetroHursty69 AntManNeon'
	'RetroHursty69 AquamanNeon'
	'RetroHursty69 AsteroidsNeon'
	'RetroHursty69 AstroBoyNeon'
	'RetroHursty69 BatmanNeon'
	'RetroHursty69 BombermanNeon'
	'RetroHursty69 BubbleBobbleNeon'
	'RetroHursty69 BumbleBeeNeon'
	'RetroHursty69 CaptainAmericaNeon'
	'RetroHursty69 DarkstalkersNeon'
	'RetroHursty69 DayTentacleNeon'
	'RetroHursty69 DaytonaUsaNeon'
	'RetroHursty69 DeadpoolNeon'
	'RetroHursty69 DigimonNeon'
	'RetroHursty69 DonkeyKongCountryNeon'
	'RetroHursty69 DonkeyKongNeon'
	'RetroHursty69 DrMarioNeon'
	'RetroHursty69 DragonBallZNeon'
	'RetroHursty69 DragonsLairNeon'
	'RetroHursty69 DukeNukemNeon'
	'RetroHursty69 ETNeon'
	'RetroHursty69 EarthwormJimNeon'	
	'RetroHursty69 ElevatorActionNeon'
	'RetroHursty69 FZeroNeon'	
	'RetroHursty69 FalloutNeon'
	'RetroHursty69 FatalFuryNeon'
	'RetroHursty69 FinalFantasyNeon'
	'RetroHursty69 FinalFightNeon'    	
	'RetroHursty69 FortniteNeon'
	'RetroHursty69 FroggerNeon'
	'RetroHursty69 FullThrottleNeon'
	'RetroHursty69 GTANeon'
	'RetroHursty69 GalagaNeon'
	'RetroHursty69 GalaxianNeon'
	'RetroHursty69 GameAndWatchNeon'
	'RetroHursty69 GarfieldNeon'
	'RetroHursty69 GauntletNeon'
	'RetroHursty69 GexNeon'
	'RetroHursty69 GhoulsNGhostsNeon'
	'RetroHursty69 GodOfWarNeon'
	'RetroHursty69 GrimFandangoNeon'
	'RetroHursty69 HalfLifeNeon'
	'RetroHursty69 HaloNeon'	
	'RetroHursty69 HarleyQuinnNeon'
	'RetroHursty69 HulkNeon'
	'RetroHursty69 IncrediblesNeon'
	'RetroHursty69 IndianaJonesNeon'
	'RetroHursty69 IronManNeon'
	'RetroHursty69 JetSetRadioNeon'
	'RetroHursty69 KOFNeon'
	'RetroHursty69 KillerInstinctNeon'
	'RetroHursty69 KingKRoolNeon'	
	'RetroHursty69 KingdomHeartsNeon'
	'RetroHursty69 KirbyNeon'
	'RetroHursty69 LegoNeon'
	'RetroHursty69 LittleBigPlanetNeon'
	'RetroHursty69 LuigiNeon'
	'RetroHursty69 ManiacMansionNeon'
	'RetroHursty69 MarioNeon'
	'RetroHursty69 MatrixNeon'
	'RetroHursty69 MegaManNeon'
	'RetroHursty69 MetalSlugNeon'
	'RetroHursty69 MetroidNeon'
	'RetroHursty69 MickeyMouseNeon'	
	'RetroHursty69 MinecraftNeon'
	'RetroHursty69 MonkeyBallNeon'
	'RetroHursty69 MortalKombatNeon'
	'RetroHursty69 OddworldNeon'
	'RetroHursty69 OptimusPrimeNeon'
	'RetroHursty69 OutRunNeon'
	'RetroHursty69 PacmanNeon'
	'RetroHursty69 ParappaNeon'
	'RetroHursty69 PitfallNeon'
	'RetroHursty69 PikminNeon'
	'RetroHursty69 PokemonNeon'
	'RetroHursty69 PowerPuffNeon'
	'RetroHursty69 PredatorNeon'	
	'RetroHursty69 PrincePersiaNeon'
	'RetroHursty69 ProfessorLaytonNeon'
	'RetroHursty69 PunchOutNeon'
	'RetroHursty69 QBertNeon'
	'RetroHursty69 RactchetClankNeon'
	'RetroHursty69 RaymanNeon'
	'RetroHursty69 ResidentEvilNeon'
	'RetroHursty69 RidgeRacerNeon'
	'RetroHursty69 RoboCopNeon'
	'RetroHursty69 SF2Neon'
	'RetroHursty69 SF3rdStrikeNeon'
	'RetroHursty69 ScoobyDooNeon'
	'RetroHursty69 ShenmueNeon'    	
	'RetroHursty69 ShrekNeon'
	'RetroHursty69 SimCityNeon'
	'RetroHursty69 SimpsonsNeon'
	'RetroHursty69 SimsNeon'
	'RetroHursty69 SmashBrosNeon'
	'RetroHursty69 SmurfsNeon'
	'RetroHursty69 SonicNeon'
	'RetroHursty69 SoulCaliburNeon'
	'RetroHursty69 SouthParkNeon'
	'RetroHursty69 SpaceAceNeon'
	'RetroHursty69 SpaceChannel5Neon'
	'RetroHursty69 SpaceInvadersNeon'
	'RetroHursty69 SpidermanNeon'
	'RetroHursty69 SplatoonNeon'
	'RetroHursty69 SplinterCellNeon'
	'RetroHursty69 SpongeBobNeon'
	'RetroHursty69 SpyroNeon'
	'RetroHursty69 StarFoxNeon'
	'RetroHursty69 StarWarsNeon'
	'RetroHursty69 StreetFighterNeon'
	'RetroHursty69 StreetsOfRageNeon'
	'RetroHursty69 SupermanNeon'
	'RetroHursty69 TMNTNeon'
	'RetroHursty69 TekkenNeon'
	'RetroHursty69 TerminatorNeon'
	'RetroHursty69 TetrisNeon'
	'RetroHursty69 ToadNeon'
	'RetroHursty69 TombRaiderNeon'
	'RetroHursty69 ToyStoryNeon'
	'RetroHursty69 TronNeon'
	'RetroHursty69 TwistedMetalNeon'
	'RetroHursty69 VirtuaFighterNeon'
	'RetroHursty69 WWENeon'
	'RetroHursty69 WaluigiNeon'
	'RetroHursty69 WarioNeon'
	'RetroHursty69 WormsNeon'
	'RetroHursty69 WrestlefestNeon'
	'RetroHursty69 XMenNeon'
	'RetroHursty69 YoshiNeon'
	'RetroHursty69 ZeldaNeon'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function hurstypicks_themes() {
    local themes=(
        'RetroHursty69 bluray'
        'RetroHursty69 boxalloyblue'
        'RetroHursty69 boxalloyred'
        'RetroHursty69 cardcrazy'
        'RetroHursty69 circuit'
        'RetroHursty69 corg'
		'RetroHursty69 CosmicRise'
        'RetroHursty69 fabuloso'
		'RetroHursty69 floyd'
        'RetroHursty69 greenilicious'
        'RetroHursty69 heychromey'
        'RetroHursty69 hurstybluetake2'
        'RetroHursty69 lightswitch'
        'RetroHursty69 HyperLuigi'
        'RetroHursty69 HyperMario'		
        'RetroHursty69 magazinemadness'
		'RetroHursty69 magazinemadness2'
		'RetroHursty69 marco'
		'RetroHursty69 mariobrosiii'
		'RetroHursty69 meshy'
		'RetroHursty69 NeonFantasy'
        'RetroHursty69 retroroid'
		'RetroHursty69 ShabangCRT'
        'RetroHursty69 Slick_Red'
        'RetroHursty69 soda'
        'RetroHursty69 stirling'
        'RetroHursty69 supersweet'
        'RetroHursty69 supersynthy16x9'
        'RetroHursty69 swatch'
		'RetroHursty69 uniflyered'
        'RetroHursty69 whiteslide'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function handheld_themes() {
    local themes=(
    'RetroHursty69 AIGEN_PLUS_4x3'
    'RetroHursty69 BlurayGameHat'
	'RetroHursty69 CarbonGameHat'
	'RetroHursty69 CardCrazyGameHat'
	'RetroHursty69 ChromeyGameHat'
	'RetroHursty69 CircuitGameHat'
	'RetroHursty69 MagazineMadnessGameHat'
	'RetroHursty69 NegativeGameHat'
	'RetroHursty69 RetroroidGameHat'
	'RetroHursty69 SodaGameHat'
	'RetroHursty69 SublimeGameHat'
	'RetroHursty69 SweetBlueGameHat'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done	
}
function slick_themes() {
    local themes=(
        'RetroHursty69 Slick_Blue'
	'RetroHursty69 Slick_BlueCube'
        'RetroHursty69 Slick_Bluey'
        'RetroHursty69 Slick_Brick'
	'RetroHursty69 Slick_Brush'
	'RetroHursty69 Slick_Bubble'
        'RetroHursty69 Slick_Castle'
        'RetroHursty69 Slick_CheckerPlate'
        'RetroHursty69 Slick_CityHeights'
        'RetroHursty69 Slick_CityLights'
	'RetroHursty69 Slick_Dazzle'
	'RetroHursty69 Slick_Edge'
	'RetroHursty69 Slick_Fire'
	'RetroHursty69 Slick_Funk'
        'RetroHursty69 Slick_Green'
	'RetroHursty69 Slick_Haze'
        'RetroHursty69 Slick_Lime'
        'RetroHursty69 Slick_Orange'
	'RetroHursty69 Slick_Pacman'
	'RetroHursty69 Slick_Pink'
        'RetroHursty69 Slick_Red'
	'RetroHursty69 Slick_Sick'
	'RetroHursty69 Slick_Smash'
	'RetroHursty69 Slick_Snazzy'
	'RetroHursty69 Slick_Spinny'
        'RetroHursty69 Slick_Steel'
	'RetroHursty69 Slick_Sunset'
	'RetroHursty69 Slick_Swingin'
        'RetroHursty69 Slick_Swish'
        'RetroHursty69 Slick_Tech'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function hyper_themes() {
    local themes=(
        'RetroHursty69 HyperAladdin'
		'RetroHursty69 HyperAlexKidd'
		'RetroHursty69 HyperAmigo'		
        'RetroHursty69 HyperAngryBirds'
        'RetroHursty69 HyperAnimalCrossing'
        'RetroHursty69 HyperAntMan'
		'RetroHursty69 HyperAstaroth'		
        'RetroHursty69 HyperBanjo'
        'RetroHursty69 HyperBatman'
        'RetroHursty69 HyperBayonetta'
		'RetroHursty69 HyperBenGrimm'		
        'RetroHursty69 HyperBomberman'
        'RetroHursty69 HyperBubbleBobble'
		'RetroHursty69 HyperBubsy'
		'RetroHursty69 HyperC3PO'		
        'RetroHursty69 HyperCaptainAmerica'
        'RetroHursty69 HyperCastlevania'
		'RetroHursty69 HyperChewbacca'		
		'RetroHursty69 HyperChunLi'
        'RetroHursty69 HyperContra'
        'RetroHursty69 HyperCuphead'		
        'RetroHursty69 HyperCrashBandicoot'
		'RetroHursty69 HyperDarkstalkers'
		'RetroHursty69 HyperDarthVader'		
        'RetroHursty69 HyperDayTentacle'		
        'RetroHursty69 HyperDeadOrAlive'
        'RetroHursty69 HyperDeadPool'		
        'RetroHursty69 HyperDevilMayCry'
        'RetroHursty69 HyperDigDug'		
        'RetroHursty69 HyperDonkeyKong'
        'RetroHursty69 HyperDonkeyKongJr'
		'RetroHursty69 HyperDrEggman'
		'RetroHursty69 HyperFulgor'		
        'RetroHursty69 HyperFrogger'
		'RetroHursty69 HyperGodOfWar'		
        'RetroHursty69 HyperGTA1'
        'RetroHursty69 HyperGTA2'
		'RetroHursty69 HyperHalo'
		'RetroHursty69 HyperHanSolo'		
		'RetroHursty69 HyperHarleyQuinn'		
		'RetroHursty69 HyperHulk'
		'RetroHursty69 HyperIndianaJones'		
		'RetroHursty69 HyperIronMan'		
		'RetroHursty69 HyperIvy'		
		'RetroHursty69 HyperJakDaxter'		
        'RetroHursty69 HyperJinKazama'
        'RetroHursty69 HyperKirby'
        'RetroHursty69 HyperLink'
		'RetroHursty69 HyperKOF1'
		'RetroHursty69 HyperKOF2'
		'RetroHursty69 HyperKOF3'
		'RetroHursty69 HyperKOF4'
		'RetroHursty69 HyperKOF5'
		'RetroHursty69 HyperKOF6'
		'RetroHursty69 HyperKOF7'
		'RetroHursty69 HyperKOF8'
		'RetroHursty69 HyperKOF9'
		'RetroHursty69 HyperKOF10'
		'RetroHursty69 HyperKOF11'
		'RetroHursty69 HyperKOF12'
		'RetroHursty69 HyperKOF13'
		'RetroHursty69 HyperKOF14'
		'RetroHursty69 HyperKOF15'
		'RetroHursty69 HyperKOF16'
		'RetroHursty69 HyperKOF17'
		'RetroHursty69 HyperKOF18'
		'RetroHursty69 HyperKOF19'
		'RetroHursty69 HyperKOF20'
		'RetroHursty69 HyperLego'		
        'RetroHursty69 HyperLuigi'
		'RetroHursty69 HyperMameinaBox'
        'RetroHursty69 HyperMario'
		'RetroHursty69 HyperMitsurugi'		
		'RetroHursty69 HyperMK1'
		'RetroHursty69 HyperMK2'
		'RetroHursty69 HyperMK3'
		'RetroHursty69 HyperMK4'
		'RetroHursty69 HyperMK5'
		'RetroHursty69 HyperMK6'
		'RetroHursty69 HyperMK7'
		'RetroHursty69 HyperMK8'
		'RetroHursty69 HyperMK9'
		'RetroHursty69 HyperMK10'
		'RetroHursty69 HyperMK11'
		'RetroHursty69 HyperMK12'
		'RetroHursty69 HyperMK13'
		'RetroHursty69 HyperNeoCortex'
		'RetroHursty69 HyperNintendo1'
		'RetroHursty69 HyperNintendo2'
		'RetroHursty69 HyperNintendo3'
		'RetroHursty69 HyperNintendo4'
		'RetroHursty69 HyperNintendo5'
		'RetroHursty69 HyperNintendo6'
		'RetroHursty69 HyperNintendo7'
		'RetroHursty69 HyperNintendo8'
		'RetroHursty69 HyperNintendo9'
		'RetroHursty69 HyperNintendo10'
		'RetroHursty69 HyperNintendo11'
		'RetroHursty69 HyperNintendo12'
		'RetroHursty69 HyperNintendo13'
		'RetroHursty69 HyperNintendo14'
		'RetroHursty69 HyperNintendo15'
		'RetroHursty69 HyperNintendo16'
		'RetroHursty69 HyperNintendo17'
		'RetroHursty69 HyperNintendo18'
		'RetroHursty69 HyperNintendo19'
		'RetroHursty69 HyperNintendo20'
		'RetroHursty69 HyperNintendo21'
		'RetroHursty69 HyperNintendo22'
		'RetroHursty69 HyperNintendo23'
		'RetroHursty69 HyperNintendo24'
		'RetroHursty69 HyperNintendo25'
		'RetroHursty69 HyperNintendo26'
		'RetroHursty69 HyperNintendo27'
		'RetroHursty69 HyperNintendo28'
		'RetroHursty69 HyperNintendo29'
		'RetroHursty69 HyperNintendo30'
		'RetroHursty69 HyperNintendo31'
		'RetroHursty69 HyperNintendo32'
		'RetroHursty69 HyperNintendo33'
		'RetroHursty69 HyperNintendo34'
		'RetroHursty69 HyperNintendo35'
		'RetroHursty69 HyperNintendo36'
		'RetroHursty69 HyperNintendo37'
		'RetroHursty69 HyperNintendo38'
		'RetroHursty69 HyperNintendo39'
		'RetroHursty69 HyperNintendo40'
		'RetroHursty69 HyperNintendo41'
		'RetroHursty69 HyperNintendo42'
		'RetroHursty69 HyperNintendo43'
		'RetroHursty69 HyperNintendo44'
		'RetroHursty69 HyperNintendo45'
		'RetroHursty69 HyperNintendo46'
		'RetroHursty69 HyperNintendo47'
		'RetroHursty69 HyperNintendo48'
		'RetroHursty69 HyperNintendo49'
		'RetroHursty69 HyperNintendo50'		
        'RetroHursty69 HyperPacman'
		'RetroHursty69 HyperPayDay'
		'RetroHursty69 HyperR2D2'		
		'RetroHursty69 HyperRachet'
		'RetroHursty69 HyperRetroArena'		
        'RetroHursty69 HyperRyu'
		'RetroHursty69 HyperSackBoy'		
        'RetroHursty69 HyperScorpion'
        'RetroHursty69 HyperSonic'
        'RetroHursty69 HyperSpaceInvaders'
        'RetroHursty69 HyperSpiderman'
		'RetroHursty69 HyperSplinterCell'
		'RetroHursty69 HyperSpaceChannel5'		
        'RetroHursty69 HyperSpyro'
		'RetroHursty69 HyperStreetFighter1'
		'RetroHursty69 HyperStreetFighter2'
		'RetroHursty69 HyperStreetFighter3'
		'RetroHursty69 HyperStreetFighter4'
		'RetroHursty69 HyperStreetFighter5'
		'RetroHursty69 HyperStreetFighter6'
		'RetroHursty69 HyperStreetFighter7'
		'RetroHursty69 HyperStreetFighter8'
		'RetroHursty69 HyperStreetFighter9'
		'RetroHursty69 HyperStreetFighter10'
		'RetroHursty69 HyperStreetFighter11'
		'RetroHursty69 HyperTails'
		'RetroHursty69 HyperTaki'		
        'RetroHursty69 HyperTerryBogard'
		'RetroHursty69 HyperThor'		
        'RetroHursty69 HyperTMNT'
        'RetroHursty69 HyperToad'
		'RetroHursty69 HyperXMen1'
		'RetroHursty69 HyperXMen2'
		'RetroHursty69 HyperXMen3'
		'RetroHursty69 HyperXMen4'
		'RetroHursty69 HyperXMen5'
		'RetroHursty69 HyperXMen6'
		'RetroHursty69 HyperXMen7'
		'RetroHursty69 HyperXMen8'
		'RetroHursty69 HyperXMen9'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done	
}

function mario_themes() {
    local themes=(
         'RetroHursty69 DrMarioSweet'
         'RetroHursty69 MarioBrosSweet'
         'RetroHursty69 MarioKartSweet'
         'RetroHursty69 MarioPartySweet'
         'RetroHursty69 PaperMarioSweet'
         'RetroHursty69 DrMarioCool'
         'RetroHursty69 MarioBrosCool'
         'RetroHursty69 MarioCool'
         'RetroHursty69 MarioKartCool'
         'RetroHursty69 MarioPartyCool'
		 'RetroHursty69 DrMarioSpin'
		 'RetroHursty69 MarioSpin'
		 'RetroHursty69 mariobrosiii'
         'RetroHursty69 mario_melee'
		 'RetroHursty69 DrMarioBlue'
  		 'RetroHursty69 MarioBlue'
		 'RetroHursty69 DrMarioGreen'
		 'RetroHursty69 MarioGreen'
		 'RetroHursty69 DrMarioNeon'
		 'RetroHursty69 MarioNeon'
		 'RetroHursty69 mariobrosiii'
         'RetroHursty69 HyperMario'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function GPi_themes() {
    local themes=(
        'RetroHursty69 GPi_Bluray'
        'RetroHursty69 GPi_Circuit'
        'RetroHursty69 GPi_CosmicRise'
        'RetroHursty69 GPi_Crash'
        'RetroHursty69 GPi_GameCard'
        'RetroHursty69 GPi_GPiBoy'
        'RetroHursty69 GPi_GBColor'		
        'RetroHursty69 GPi_GBGreen'
        'RetroHursty69 GPi_HeyChromeyOfficial'
        'RetroHursty69 GPi_Mario'
        'RetroHursty69 GPi_PopBox'
        'RetroHursty69 GPi_Retroroid'
        'RetroHursty69 GPi_SteelChromey'
		'RetroHursty69 GPi_SuperSweet'
        'RetroHursty69 GPi_Sublime'
		'RetroHursty69 GPi_Soda'
		'RetroHursty69 GPi_Sonic'
		'RetroHursty69 GPi_TriClops'
		'RetroHursty69 GPi_Trio'
		'RetroHursty69 GPi_UniFlyered'
        'RetroHursty69 GPi_BalrogCapcom'
        'RetroHursty69 GPi_BisonCapcom'
        'RetroHursty69 GPi_BlankaCapcom'
        'RetroHursty69 GPi_CammyCapcom'
        'RetroHursty69 GPi_CapCommandoCapcom'		
        'RetroHursty69 GPi_ChunLiCapcom'
        'RetroHursty69 GPi_DhalsimCapcom'        
        'RetroHursty69 GPi_DeeJayCapcom'
        'RetroHursty69 GPi_DemitriCapcom'
        'RetroHursty69 GPi_GhoulsCapcom'
		'RetroHursty69 GPi_GuileCapcom'
        'RetroHursty69 GPi_HondaCapcom'
		'RetroHursty69 GPi_KenCapcom'
		'RetroHursty69 GPi_RyuCapcom'
		'RetroHursty69 GPi_SagatCapcom'
		'RetroHursty69 GPi_THawkCapcom'
		'RetroHursty69 GPi_ZangiefCapcom'		
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function Comic_themes() {
    local themes=(
			'RetroHursty69 ComicMK'
			'RetroHursty69 ComicMARVEL'
			'RetroHursty69 ComicMARIO'
			'RetroHursty69 ComicDARKSTALKERS'
			'RetroHursty69 ComicSTREETFIGHT'
			'RetroHursty69 ComicZELDA'
			'RetroHursty69 ComicXMEN'
			'RetroHursty69 ComicSONIC'
			'RetroHursty69 ComicPACMAN'
			'RetroHursty69 ComicCRASHB'
			'RetroHursty69 ComicCOVERS'		
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function Adios_themes() {
    local themes=(
			'RetroHursty69 Adios_007'
			'RetroHursty69 Adios_Aliens'			
			'RetroHursty69 Adios_Akuma'
			'RetroHursty69 Adios_AlexKidd'
			'RetroHursty69 Adios_Assassins'			
			'RetroHursty69 Adios_Axel'
			'RetroHursty69 Adios_Banjo'			
			'RetroHursty69 Adios_Billy'
			'RetroHursty69 Adios_Batman'
			'RetroHursty69 Adios_Battletoads'			
			'RetroHursty69 Adios_Bison'
			'RetroHursty69 Adios_BobaFett'
			'RetroHursty69 Adios_Boo'
			'RetroHursty69 Adios_BOrchid'
			'RetroHursty69 Adios_Bowser'
			'RetroHursty69 Adios_BowserJr'
			'RetroHursty69 Adios_C3PO'
			'RetroHursty69 Adios_ChunLi'
			'RetroHursty69 Adios_Crash'
			'RetroHursty69 Adios_DevilMayCry'			
			'RetroHursty69 Adios_DiddyKong'
			'RetroHursty69 Adios_DonkeyKong'
			'RetroHursty69 Adios_DonkeyKongJr'
			'RetroHursty69 Adios_Doom'
			'RetroHursty69 Adios_DoubleDragon'			
			'RetroHursty69 Adios_Drake'
			'RetroHursty69 Adios_Dragonball'			
			'RetroHursty69 Adios_DrMario'
			'RetroHursty69 Adios_DuckHunt'			
			'RetroHursty69 Adios_DukeNukem'
			'RetroHursty69 Adios_EarthwormJim'			
			'RetroHursty69 Adios_Eggman'
			'RetroHursty69 Adios_Freeman'			
			'RetroHursty69 Adios_Ganon'			
			'RetroHursty69 Adios_Gears'
			'RetroHursty69 Adios_GodofWar'
			'RetroHursty69 Adios_Ghouls'
			'RetroHursty69 Adios_Goro'
			'RetroHursty69 Adios_GTA'
			'RetroHursty69 Adios_Halo'
			'RetroHursty69 Adios_Heichi'
			'RetroHursty69 Adios_Hulk'			
			'RetroHursty69 Adios_Hwoarang'
			'RetroHursty69 Adios_Invaders'
			'RetroHursty69 Adios_Jago'
			'RetroHursty69 Adios_Jak'
			'RetroHursty69 Adios_Jin'			
			'RetroHursty69 Adios_JohnnyCage'
			'RetroHursty69 Adios_Joker'
			'RetroHursty69 Adios_Ken'
			'RetroHursty69 Adios_KOF'
			'RetroHursty69 Adios_Koopa'
			'RetroHursty69 Adios_Lara'
			'RetroHursty69 Adios_Link'
			'RetroHursty69 Adios_Luigi'
			'RetroHursty69 Adios_Luke'
			'RetroHursty69 Adios_Mario'
			'RetroHursty69 Adios_MarioGolf'
			'RetroHursty69 Adios_Megaman'
			'RetroHursty69 Adios_MetalGear'
			'RetroHursty69 Adios_Monkey'
			'RetroHursty69 Adios_Nights'
			'RetroHursty69 Adios_Ninja'
			'RetroHursty69 Adios_Nook'
			'RetroHursty69 Adios_Pacman'
			'RetroHursty69 Adios_Paul'			
			'RetroHursty69 Adios_Penelope'
			'RetroHursty69 Adios_PepsiMan'
			'RetroHursty69 Adios_Predator'
			'RetroHursty69 Adios_Punchout'
			'RetroHursty69 Adios_Rayman'
			'RetroHursty69 Adios_ResidentEvil'
			'RetroHursty69 Adios_Ryu'
			'RetroHursty69 Adios_SackBoy'
			'RetroHursty69 Adios_Samurai'
			'RetroHursty69 Adios_ShyGuy'
			'RetroHursty69 Adios_Sonic'
			'RetroHursty69 Adios_Spiderman'
			'RetroHursty69 Adios_Splatoon'
			'RetroHursty69 Adios_SplinterCell'
			'RetroHursty69 Adios_Spock'
			'RetroHursty69 Adios_StarFox'
			'RetroHursty69 Adios_Strikers'
			'RetroHursty69 Adios_Sully'			
			'RetroHursty69 Adios_Superman'
			'RetroHursty69 Adios_Tails'
			'RetroHursty69 Adios_Terminator'
			'RetroHursty69 Adios_TerryB'
			'RetroHursty69 Adios_TMNT'
			'RetroHursty69 Adios_Toad'
			'RetroHursty69 Adios_Toadette'
			'RetroHursty69 Adios_TonyHawk'
			'RetroHursty69 Adios_Vader'
			'RetroHursty69 Adios_VirtuaFighter'
			'RetroHursty69 Adios_Wolverine'
			'RetroHursty69 Adios_WonderWoman'
			'RetroHursty69 Adios_Yoda'
			'RetroHursty69 Adios_Yoshi'
			'RetroHursty69 Adios_Zelda'			
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function Slanty_themes() {
    local themes=(
			'RetroHursty69 Slanty_Agent47'
			'RetroHursty69 Slanty_AlexKidd'
			'RetroHursty69 Slanty_Astroboy'
			'RetroHursty69 Slanty_Batman'
			'RetroHursty69 Slanty_Battletoads'
			'RetroHursty69 Slanty_Bomberman'
			'RetroHursty69 Slanty_Boogerman'
			'RetroHursty69 Slanty_BOrchid'
			'RetroHursty69 Slanty_Bowser'
			'RetroHursty69 Slanty_BubbleBobble'
			'RetroHursty69 Slanty_Castlevania'
			'RetroHursty69 Slanty_CrashBandicoot'
			'RetroHursty69 Slanty_DarkStalkers'
			'RetroHursty69 Slanty_DigDug'
			'RetroHursty69 Slanty_DKJunior'
			'RetroHursty69 Slanty_DonkeyKong'
			'RetroHursty69 Slanty_Doom'
			'RetroHursty69 Slanty_DrMario'
			'RetroHursty69 Slanty_Earthbound'
			'RetroHursty69 Slanty_EarthwormJim'
			'RetroHursty69 Slanty_Eggman'
			'RetroHursty69 Slanty_FinalFantasy'
			'RetroHursty69 Slanty_FZero'
			'RetroHursty69 Slanty_GameWatch'
			'RetroHursty69 Slanty_Ganon'
			'RetroHursty69 Slanty_GoW'
			'RetroHursty69 Slanty_Halo'
			'RetroHursty69 Slanty_Heichi'
			'RetroHursty69 Slanty_Hulk'
			'RetroHursty69 Slanty_Jin'
			'RetroHursty69 Slanty_King'			
			'RetroHursty69 Slanty_KingdomHearts'
			'RetroHursty69 Slanty_Kirby'
			'RetroHursty69 Slanty_KoF'
			'RetroHursty69 Slanty_Koopa'
			'RetroHursty69 Slanty_Lego'
			'RetroHursty69 Slanty_Lemmings'
			'RetroHursty69 Slanty_Link'
			'RetroHursty69 Slanty_Luigi'
			'RetroHursty69 Slanty_Mario'
			'RetroHursty69 Slanty_Megaman'
			'RetroHursty69 Slanty_Metroid'
			'RetroHursty69 Slanty_MKGoro'
			'RetroHursty69 Slanty_MKScorpion'
			'RetroHursty69 Slanty_MKSubZero'
			'RetroHursty69 Slanty_Nights'
			'RetroHursty69 Slanty_NinjaGaiden'
			'RetroHursty69 Slanty_Nook'
			'RetroHursty69 Slanty_Pacman'
			'RetroHursty69 Slanty_Pikachu'
			'RetroHursty69 Slanty_Piranha'			
			'RetroHursty69 Slanty_PrincePersia'
			'RetroHursty69 Slanty_Punchout'
			'RetroHursty69 Slanty_QBert'
			'RetroHursty69 Slanty_Robotron'
			'RetroHursty69 Slanty_SackBoy'
			'RetroHursty69 Slanty_SFBison'
			'RetroHursty69 Slanty_SFChunLi'
			'RetroHursty69 Slanty_SFRyu'
			'RetroHursty69 Slanty_Simpsons'
			'RetroHursty69 Slanty_Sonic'
			'RetroHursty69 Slanty_SoR'
			'RetroHursty69 Slanty_Spiderman'
			'RetroHursty69 Slanty_SplinterCell'
			'RetroHursty69 Slanty_SpongeBob'
			'RetroHursty69 Slanty_Spyro'
			'RetroHursty69 Slanty_StarFox'
			'RetroHursty69 Slanty_TMNT'
			'RetroHursty69 Slanty_Toad'
			'RetroHursty69 Slanty_TombRaider'
			'RetroHursty69 Slanty_VirtuaFighter'
			'RetroHursty69 Slanty_Wario'
			'RetroHursty69 Slanty_WonderBoy'
			'RetroHursty69 Slanty_Wrestling'
			'RetroHursty69 Slanty_XMen'
			'RetroHursty69 Slanty_Yoshi'
			'RetroHursty69 Slanty_Zelda'			
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}

function Community_themes() {
    local themes=(
        'RetroPie carbon'
        'RetroPie carbon-centered'
        'RetroPie carbon-nometa'
        'RetroPie simple'
        'RetroPie simple-dark'
        'RetroPie clean-look'
        'RetroPie color-pi'
        'RetroPie nbba'
        'RetroPie simplified-static-canela'
        'RetroPie turtle-pi'
        'RetroPie zoid'
        'ehettervik pixel'
        'ehettervik pixel-metadata'
        'ehettervik pixel-tft'
        'ehettervik luminous'
        'ehettervik minilumi'
        'ehettervik workbench'
        'AmadhiX eudora'
        'AmadhiX eudora-bigshot'
        'AmadhiX eudora-concise'
        'Omnija simpler-turtlepi'
        'Omnija simpler-turtlemini'
        'Omnija metro'
        'lilbud material'
        'mattrixk io'
        'mattrixk metapixel'
        'mattrixk spare'
        'robertybob space'
        'robertybob simplebigart'
        'robertybob tv'
        'HerbFargus tronkyfran'
        'lilbud flat'
        'lilbud flat-dark'
        'lilbud minimal'
        'lilbud switch'
        'lilbud angular'
        'FlyingTomahawk futura-V'
        'FlyingTomahawk futura-dark-V'
        'G-rila fundamental'
        'ruckage nes-mini'
        'ruckage famicom-mini'
        'ruckage snes-mini'
        'anthonycaccese crt'
        'anthonycaccese crt-centered'
        'anthonycaccese art-book'
        'anthonycaccese art-book-4-3'
        'anthonycaccese art-book-pocket'
        'anthonycaccese art-book-micro'
        'anthonycaccese tft'
        'anthonycaccese picade'
        'TMNTturtleguy ComicBook'
        'TMNTturtleguy ComicBook_4-3'
        'TMNTturtleguy ComicBook_SE-Wheelart'
        'TMNTturtleguy ComicBook_4-3_SE-Wheelart'
        'ChoccyHobNob cygnus'
        'DTEAM-1 cygnus-blue-flames'
        'dmmarti steampunk'
        'dmmarti hurstyblue'
        'dmmarti maximuspie'
        'dmmarti showcase'
        'dmmarti kidz'
        'dmmarti unified'
        'dmmarti gamehat'
        'rxbrad freeplay'
        'rxbrad gbz35'
        'rxbrad gbz35-dark'
        'garaine marioblue'
        'garaine bigwood'
        'MrTomixf Royal_Primicia'
        'lostless playstation'
        'mrharias superdisplay'
        'coinjunkie synthwave'
        'nickearl retrowave'
        'nickearl retrowave_4_3'
        'pacdude minijawn'
        'Saracade scv720'
        'chicueloarcade Chicuelo'
        'SuperMagicom nostalgic'
        'lipebello retrorama'
        'lipebello retrorama-turbo'
        'lipebello strangerstuff'
        'lipebello spaceoddity'
        'lipebello spaceoddity-43'
        'lipebello spaceoddity-wide'
        'lipebello swineapple'
        'waweedman pii-wii'
        'waweedman Blade-360'
        'waweedman Venom'
        'waweedman Spider-Man'
        'blowfinger77 locomotion'
        'justincaseurskynet Arcade1up-5x4-Horizontal'
        'KALEL1981 Super-Retroboy'
        'xovox RetroCRT-240p'
        'xovox RetroCRT-240p-Rainbow'
        'xovox RetroCRT-240p-Vertical'
        'arcadeforge push-a'
        'arcadeforge push-a-v'
        'arcadeforge pixel-heaven'
        'arcadeforge pixel-heaven-text'
        'arcadeforge 240p_Bubblegum'
        'arcadeforge 240p-honey'
        'dionmunk clean'
        'c64-dev epicnoir'
        'AndreaMav arcade-crt'
        'AndreaMav arcade-crt2020'
        'Zechariel VectorPie'
        'KALEL1981 nes-box'
        'KALEL1981 super-arcade1up-5x4'
        'KALEL1981 gold-standard'
        'Elratauru angular-artwork'
        'cjonasw raspixel-320-240'
        'crxone 3twenty2fourty'
        'leochely Guilty-Gear'		
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}


function SmoothyUno_themes() {
    local themes=(
	'RetroHursty69 007Uno'
	'RetroHursty69 AceAttorneyUno'
	'RetroHursty69 AeroAcroBatUno'
	'RetroHursty69 AladdinUno'
	'RetroHursty69 AlexKiddUno'
	'RetroHursty69 AnimalCrossingUno'
	'RetroHursty69 ArtofFightingUno'
	'RetroHursty69 AssassinsCreedUno'
	'RetroHursty69 BarbieUno'
	'RetroHursty69 BatmanMovieUno'
	'RetroHursty69 BattletoadsUno'
	'RetroHursty69 BombermanUno'
	'RetroHursty69 BoogermanUno'
	'RetroHursty69 BOrchidUno'
	'RetroHursty69 BowserUno'
	'RetroHursty69 CaptainAmericaUno'
	'RetroHursty69 CasperUno'
	'RetroHursty69 CoolSpotUno'
	'RetroHursty69 CrashBandicootUno'
	'RetroHursty69 DarkstalkersUno'
	'RetroHursty69 DeadorAliveUno'
	'RetroHursty69 DiabloUno'
	'RetroHursty69 DigDugUno'
	'RetroHursty69 DigimonUno'
	'RetroHursty69 DonkeyKongUno'
	'RetroHursty69 DoomUno'
	'RetroHursty69 DragonBallUno'
	'RetroHursty69 DrEggmanUno'
	'RetroHursty69 DrMarioUno'
	'RetroHursty69 DukeNukemUno'
	'RetroHursty69 EarthwormJimUno'
	'RetroHursty69 ElderScrollsUno'
	'RetroHursty69 FamilyGuyUno'
	'RetroHursty69 FatalFuryUno'
	'RetroHursty69 FinalFantasyUno'
	'RetroHursty69 FireEmblemUno'
	'RetroHursty69 FroggerUno'
	'RetroHursty69 FZeroUno'
	'RetroHursty69 GarfieldUno'
	'RetroHursty69 GauntletUno'
	'RetroHursty69 GexUno'
	'RetroHursty69 GhostbustersUno'
	'RetroHursty69 GhoulsnGhostsUno'
	'RetroHursty69 GodofWarUno'
	'RetroHursty69 GoldenAxeUno'
	'RetroHursty69 GoldenSunUno'
	'RetroHursty69 GrimFandangoUno'
	'RetroHursty69 GTAUno'
	'RetroHursty69 HarryPotterUno'
	'RetroHursty69 HarvestMoonUno'
	'RetroHursty69 HelloKittyUno'
	'RetroHursty69 HitmanUno'
	'RetroHursty69 HulkUno'
	'RetroHursty69 IndianaUno'
	'RetroHursty69 JakDaxterUno'
	'RetroHursty69 JetsonsUno'
	'RetroHursty69 JudgeDreddUno'
	'RetroHursty69 KingdomHeartsUno'
	'RetroHursty69 KingofFightersUno'
	'RetroHursty69 KirbyUno'
	'RetroHursty69 LegoUno'
	'RetroHursty69 LemmingsUno'
	'RetroHursty69 LufiaUno'
	'RetroHursty69 LuigisMansionUno'
	'RetroHursty69 LuigiUno'
	'RetroHursty69 MarioGolfUno'
	'RetroHursty69 MarioKartUno'
	'RetroHursty69 MarioTennisUno'
	'RetroHursty69 MarioUno'
	'RetroHursty69 MechWarriorUno'
	'RetroHursty69 MegamanUno'
	'RetroHursty69 MetalSlugUno'
	'RetroHursty69 MetroidUno'
	'RetroHursty69 MickeyMouseUno'
	'RetroHursty69 MinecraftUno'
	'RetroHursty69 MK1Uno'
	'RetroHursty69 MK2Uno'
	'RetroHursty69 MonkeyBallUno'
	'RetroHursty69 MsPacmanUno'
	'RetroHursty69 MuppetsUno'
	'RetroHursty69 NarutoUno'
	'RetroHursty69 NinjaGaidenUno'
	'RetroHursty69 OddworldUno'
	'RetroHursty69 PacmanJrUno'
	'RetroHursty69 PacmanUno'
	'RetroHursty69 PangUno'
	'RetroHursty69 ParodiusUno'
	'RetroHursty69 PinballUno'
	'RetroHursty69 PinkPantherUno'
	'RetroHursty69 PokemonUno'
	'RetroHursty69 PopeyeUno'
	'RetroHursty69 PredatorUno'
	'RetroHursty69 PrincePersiaUno'
	'RetroHursty69 PunchoutUno'
	'RetroHursty69 PunisherUno'
	'RetroHursty69 PuzzleUno'
	'RetroHursty69 QBertUno'
	'RetroHursty69 QuakeUno'
	'RetroHursty69 RacingUno'
	'RetroHursty69 RainbowSixUno'
	'RetroHursty69 RamboUno'
	'RetroHursty69 RatchetClankUno'
	'RetroHursty69 RaymanUno'
	'RetroHursty69 RenStimpyUno'
	'RetroHursty69 ResidentEvilUno'
	'RetroHursty69 RoadRunnerUno'
	'RetroHursty69 RobocopUno'
	'RetroHursty69 RobotronUno'
	'RetroHursty69 RugratsUno'
	'RetroHursty69 SailorMoonUno'
	'RetroHursty69 SamuraiShoUno'
	'RetroHursty69 ScoobyDooUno'
	'RetroHursty69 SF1Uno'
	'RetroHursty69 SF2Uno'
	'RetroHursty69 ShiningForceUno'
	'RetroHursty69 ShinobiUno'
	'RetroHursty69 ShrekUno'
	'RetroHursty69 SimpsonsUno'
	'RetroHursty69 SimsUno'
	'RetroHursty69 SmurfsUno'
	'RetroHursty69 SonicOGUno'
	'RetroHursty69 SonicUno'
	'RetroHursty69 SouthParkUno'
	'RetroHursty69 SpaceInvadersUno'
	'RetroHursty69 SpidermanUno'
	'RetroHursty69 SplatterhouseUno'
	'RetroHursty69 SplinterCellUno'
	'RetroHursty69 SpyroUno'
	'RetroHursty69 StarfoxUno'
	'RetroHursty69 StarTrekUno'
	'RetroHursty69 StarWarsUno'
	'RetroHursty69 StreetsofRageUno'
	'RetroHursty69 TamagotchiUno'
	'RetroHursty69 TekkenUno'
	'RetroHursty69 TMNTUno'
	'RetroHursty69 ToadUno'
	'RetroHursty69 TombRaiderUno'
	'RetroHursty69 TonyHawkUno'
	'RetroHursty69 ToyStoryUno'
	'RetroHursty69 TransformersUno'
	'RetroHursty69 TronUno'
	'RetroHursty69 TwistedMetalUno'
	'RetroHursty69 UnchartedUno'
	'RetroHursty69 ViewtifulJoeUno'
	'RetroHursty69 VirtuaFighterUno'
	'RetroHursty69 WolfensteinUno'
	'RetroHursty69 WonderBoyUno'
	'RetroHursty69 WorldHeroesUno'
	'RetroHursty69 WoverineUno'
	'RetroHursty69 WWFUno'
	'RetroHursty69 YoshiUno'
	'RetroHursty69 Yu-Gi-OhUno'
	'RetroHursty69 ZeldaUno'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done    
} 

function SmoothyDuo_themes() {
    local themes=(
	'RetroHursty69 AceAttorneyDuo'
	'RetroHursty69 AeroAcroBatDuo'
	'RetroHursty69 AladdinDuo'
	'RetroHursty69 AlexKiddDuo'
	'RetroHursty69 AnimalCrossingDuo'
	'RetroHursty69 ArtofFightingDuo'
	'RetroHursty69 AssassinsCreedDuo'
	'RetroHursty69 BarbieDuo'
	'RetroHursty69 BatmanCartoonDuo'
	'RetroHursty69 BatmanMovieDuo'
	'RetroHursty69 BattletoadsDuo'
	'RetroHursty69 BombermanDuo'
	'RetroHursty69 BoogermanDuo'
	'RetroHursty69 BowserDuo'
	'RetroHursty69 CaptAmericaDuo'
	'RetroHursty69 CasperDuo'
	'RetroHursty69 CrashBandicootDuo'
	'RetroHursty69 DarkstalkersDuo'
	'RetroHursty69 DeadorAliveDuo'
	'RetroHursty69 DigDugDuo'
	'RetroHursty69 DigimonDuo'
	'RetroHursty69 DonkeyKongDuo'
	'RetroHursty69 DoomDuo'
	'RetroHursty69 DragonBallDuo'
	'RetroHursty69 DrEggmanDuo'
	'RetroHursty69 DrMarioDuo'
	'RetroHursty69 EarthwormJimDuo'
	'RetroHursty69 FatalFuryDuo'
	'RetroHursty69 FinalFantasyDuo'
	'RetroHursty69 FireEmblemDuo'
	'RetroHursty69 FroggerDuo'
	'RetroHursty69 FZeroDuo'
	'RetroHursty69 GauntletDuo'
	'RetroHursty69 GhostbustersDuo'
	'RetroHursty69 GhoulsnGhostsDuo'
	'RetroHursty69 GodofWarDuo'
	'RetroHursty69 HitmanDuo'
	'RetroHursty69 HulkDuo'
	'RetroHursty69 IndiananDuo'
	'RetroHursty69 JakDaxterDuo'
	'RetroHursty69 JudgeDreddDuo'
	'RetroHursty69 KillerInstinctDuo'
	'RetroHursty69 KingdomHeartsDuo'
	'RetroHursty69 KingofFightersDuo'
	'RetroHursty69 KirbyDuo'
	'RetroHursty69 LegoDuo'
	'RetroHursty69 LuigiDuo'
	'RetroHursty69 LuigisMansionDuo'
	'RetroHursty69 MarioDuo'
	'RetroHursty69 MarioGolfDuo'
	'RetroHursty69 MarioKartDuo'
	'RetroHursty69 MarioTennisDuo'
	'RetroHursty69 MegaManDuo'
	'RetroHursty69 MetalSlugDuo'
	'RetroHursty69 MetroidDuo'
	'RetroHursty69 MinecraftDuo'
	'RetroHursty69 MK1Duo'
	'RetroHursty69 MK2Duo'
	'RetroHursty69 MonkeyBallDuo'
	'RetroHursty69 MsPacmanDuo'
	'RetroHursty69 NarutoDuo'
	'RetroHursty69 NinjaGaidenDuo'
	'RetroHursty69 OddworldDuo'
	'RetroHursty69 PacmanDuo'
	'RetroHursty69 ParodiusDuo'
	'RetroHursty69 PokemonDuo'
	'RetroHursty69 PopeyeDuo'
	'RetroHursty69 PrincePersiaDuo'
	'RetroHursty69 PunchOutDuo'
	'RetroHursty69 QBertDuo'
	'RetroHursty69 RatchetClankDuo'
	'RetroHursty69 RaymanDuo'
	'RetroHursty69 RenStimpyDuo'
	'RetroHursty69 ResidentEvilDuo'
	'RetroHursty69 RoadRunnerDuo'
	'RetroHursty69 RobocopDuo'
	'RetroHursty69 RugratsDuo'
	'RetroHursty69 SailorMoonDuo'
	'RetroHursty69 SamuraiShodownDuo'
	'RetroHursty69 ScoobyDooDuo'
	'RetroHursty69 SF1Duo'
	'RetroHursty69 SF2Duo'
	'RetroHursty69 ShiningForceDuo'
	'RetroHursty69 ShinobiDuo'
	'RetroHursty69 ShrekDuo'
	'RetroHursty69 SimpsonsDuo'
	'RetroHursty69 SimsDuo'
	'RetroHursty69 SmurfsDuo'
	'RetroHursty69 SonicDuo'
	'RetroHursty69 SouthParkDuo'
	'RetroHursty69 SpaceInvadersDuo'
	'RetroHursty69 SplatterhouseDuo'
	'RetroHursty69 SplinterCellDuo'
	'RetroHursty69 SpyroDuo'
	'RetroHursty69 StarfoxDuo'
	'RetroHursty69 StarTrekDuo'
	'RetroHursty69 StarWarsDuo'
	'RetroHursty69 StreetsofRageDuo'
	'RetroHursty69 TamagotchiDuo'
	'RetroHursty69 TekkenDuo'
	'RetroHursty69 TMNTDuo'
	'RetroHursty69 ToadDuo'
	'RetroHursty69 TombRaiderDuo'
	'RetroHursty69 ToyStoryDuo'
	'RetroHursty69 TransformersDuo'
	'RetroHursty69 TronDuo'
	'RetroHursty69 TwistedMetalDuo'
	'RetroHursty69 UnchartedDuo'
	'RetroHursty69 ViewtifulJoeDuo'
	'RetroHursty69 VirtuaFighterDuo'
	'RetroHursty69 WolfensteinDuo'
	'RetroHursty69 WolverineDuo'
	'RetroHursty69 WonderBoyDuo'
	'RetroHursty69 WorldHeroesDuo'
	'RetroHursty69 WWFDuo'
	'RetroHursty69 YoshiDuo'
	'RetroHursty69 Yu-Gi-OhDuo'
	'RetroHursty69 ZeldaDuo'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done    
} 






gui_hurstythemes
