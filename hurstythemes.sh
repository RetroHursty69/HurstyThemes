#!/usr/bin/env bash

# This file is NOT part of The RetroPie Project
#
# This script is a third party script to install the RetroHursty
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

function gui_hurstythemes() {
    local themes=(
        'RetroHursty69 magazinemadness'
        'RetroHursty69 stirling'
        'RetroHursty69 boxalloyred'
        'RetroHursty69 boxalloyblue'
        'RetroHursty69 greenilicious'
        'RetroHursty69 retroroid'
        'RetroHursty69 merryxmas'
        'RetroHursty69 cardcrazy'
        'RetroHursty69 license2game'
        'RetroHursty69 comiccrazy'
        'RetroHursty69 snazzy'
        'RetroHursty69 tributeGoT'
        'RetroHursty69 tributeSTrek'
        'RetroHursty69 tributeSWars'
        'RetroHursty69 crisp'
        'RetroHursty69 crisp_light'
        'RetroHursty69 primo'
        'RetroHursty69 primo_light'
        'RetroHursty69 back2basics'
        'RetroHursty69 retrogamenews'
        'RetroHursty69 bluray'
        'RetroHursty69 soda'
        'RetroHursty69 lightswitch'
        'RetroHursty69 darkswitch'
        'RetroHursty69 whiteslide'
        'RetroHursty69 graffiti'
        'RetroHursty69 whitewood'
        'RetroHursty69 sublime'
        'RetroHursty69 infinity'
        'RetroHursty69 neogeo_only'
        'RetroHursty69 boxcity'
        'RetroHursty69 vertical_arcade'
        'RetroHursty69 cabsnazzy'
        'RetroHursty69 garfieldism'
        'RetroHursty69 halloweenspecial'
        'RetroHursty69 heychromey'
        'RetroHursty69 homerism'
        'RetroHursty69 spaceinvaders'
        'RetroHursty69 disenchantment'
        'RetroHursty69 minions'
        'RetroHursty69 tmnt'
        'RetroHursty69 pacman'
        'RetroHursty69 dragonballz'
        'RetroHursty69 minecraft'
        'RetroHursty69 incredibles'
        'RetroHursty69 mario_melee'
        'RetroHursty69 evilresident'
        'RetroHursty69 hurstyspin'
        'RetroHursty69 cyber'
        'RetroHursty69 supersweet'
        'RetroHursty69 donkeykonkey'
        'RetroHursty69 snapback'
        'RetroHursty69 heman'
        'RetroHursty69 pitube'
        'RetroHursty69 batmanburton'
        'RetroHursty69 AngryBirdSweet'
        'RetroHursty69 AssassinsSweet'
        'RetroHursty69 BanjoSweet'
        'RetroHursty69 BatmanSweet'
        'RetroHursty69 BayonettaSweet'
        'RetroHursty69 BombermanSweet'
        'RetroHursty69 BubbleBobbleSweet'
        'RetroHursty69 CaptAmericaSweet'
        'RetroHursty69 CastlevaniaSweet'
        'RetroHursty69 ChronoTriggerSweet'
        'RetroHursty69 ChunLiSweet'
        'RetroHursty69 ContraSweet'
        'RetroHursty69 CrashBandiSweet'
        'RetroHursty69 DKCountrySweet'
        'RetroHursty69 DarkstalkersSweet'
        'RetroHursty69 DayTentacleSweet'
        'RetroHursty69 DigDugSweet'
        'RetroHursty69 DigimonSweet'
        'RetroHursty69 DoomSweet'
        'RetroHursty69 DoubleDragonSweet'
        'RetroHursty69 DrMarioSweet'
        'RetroHursty69 DrWhoSweet'
        'RetroHursty69 DragonballZSweet'
        'RetroHursty69 DragonsLairSweet'
        'RetroHursty69 DukeNukemSweet'
        'RetroHursty69 EarthwormJimSweet'
        'RetroHursty69 FZeroSweet'
        'RetroHursty69 FalloutSweet'
        'RetroHursty69 FatalFurySweet'
        'RetroHursty69 FinalFantasySweet'
        'RetroHursty69 FoxSweet'
        'RetroHursty69 FroggerSweet'
        'RetroHursty69 GEXSweet'
        'RetroHursty69 GOWSweet'
        'RetroHursty69 GTASweet'
        'RetroHursty69 GhoulsSweet'
        'RetroHursty69 GoldenEyeSweet'
        'RetroHursty69 HalfLifeSweet'
        'RetroHursty69 HaloSweet'
        'RetroHursty69 HitmanSweet'
        'RetroHursty69 HulkSweet'
        'RetroHursty69 IncrediblesSweet'
        'RetroHursty69 IronManSweet'
        'RetroHursty69 JetSetSweet'
        'RetroHursty69 KOFSweet'
        'RetroHursty69 KillerInstinctSweet'
        'RetroHursty69 KillLaKillSweet'
        'RetroHursty69 KindomHeartsSweet'
        'RetroHursty69 KirbySweet'
        'RetroHursty69 KratosSweet'
        'RetroHursty69 LaraCroftSweet'
        'RetroHursty69 LuigiSweet'
        'RetroHursty69 MOTUSweet'
        'RetroHursty69 MarioBrosSweet'
        'RetroHursty69 MarioKartSweet'
        'RetroHursty69 MatrixSweet'
        'RetroHursty69 MegaManSweet'
        'RetroHursty69 MetalGearSweet'
        'RetroHursty69 MetalSlugSweet'
        'RetroHursty69 MetroidSweet'
        'RetroHursty69 MillenniumSweet'
        'RetroHursty69 MortalKombatSweet'
        'RetroHursty69 NinjaGaidenSweet'
        'RetroHursty69 OddWorldSweet'
        'RetroHursty69 OptimusSweet'
        'RetroHursty69 PaRappaSweet'
        'RetroHursty69 PacmanSweet'
        'RetroHursty69 ParodiusSweet'
        'RetroHursty69 PepsiManSweet'
        'RetroHursty69 PokemonSweet'
        'RetroHursty69 PowerRangersSweet'
        'RetroHursty69 QBertSweet'
        'RetroHursty69 RaymanSweet'
        'RetroHursty69 RedDeadSweet'
        'RetroHursty69 RoboCopSweet'
        'RetroHursty69 RockBandSweet'
        'RetroHursty69 RyuSweet'
        'RetroHursty69 SMWorldSweet'
        'RetroHursty69 SWHothSweet'
        'RetroHursty69 SackBoySweet'
        'RetroHursty69 SamuraiShoSweet'
        'RetroHursty69 SimpsonsSweet'
        'RetroHursty69 SimsSweet'
        'RetroHursty69 SonicSweet'
        'RetroHursty69 SoulCaliburSweet'
        'RetroHursty69 SpeedRacerSweet'
        'RetroHursty69 SpidermanSweet'
        'RetroHursty69 SplinterCellSweet'
        'RetroHursty69 SpyroSweet'
        'RetroHursty69 StreetsRageSweet'
        'RetroHursty69 TMNTSweet'
        'RetroHursty69 TekkenSweet'
        'RetroHursty69 ToyStorySweet'
        'RetroHursty69 UnchartedSweet'
        'RetroHursty69 WarioSweet'
        'RetroHursty69 WoWSweet'
        'RetroHursty69 WrestleManiaSweet'
        'RetroHursty69 XMenSweet'
        'RetroHursty69 YoshiSweet'
        'RetroHursty69 ZeldaSweet'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        options+=(U "Update install script - script will exit when updated")

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
