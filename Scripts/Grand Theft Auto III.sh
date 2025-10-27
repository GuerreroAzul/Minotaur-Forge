#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# License: Retail
 
# CHANGELOG
# [GuerreroAzul] 2025-10-27 15-20 (UTC -06-00) // Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Version Script: 1.0.5
#   - Update URL Download Game
#   - Update DirectX End-User Runtimes (June 2010)
#   - Install Direct Show Filters Fix
#   - Update Install Mod
# [GuerreroAzul] 2025-10-03 11-47 (UTC -06-00) // Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Version: 1.0.4
#   - Update URL Download Game
#   - Update Funtions And Dependencies
#   - Suport for Mod Liberty Extended
# [GuerrreroAzul] (2025-06-10 08-55 GMT-6) / Linux Mint 22.1 x86_64
#   The following features have been updated:
#     + Wine version 9.0
#   Added the following features:
#     + System version: Windows 7
#     + Category: Games
# [Dadu042] (2019-06-01 13:21) Wine 2.22 / Ubuntu 18.04 x64
#   Rewrite the script for because the previous (2009-10-31) fail working (on POL 4.3.4).
#   [Setting initial]
#     + Version wine: 2.22
#     + Category: Game;
#     + Version system: winxp
#   [Reference]
#     + Document: https://en.wikipedia.org/wiki/Grand_Theft_Auto_III
 
# REFERENCE
# [GuerreroAzul]
# Documentation POL: https://www.playonlinux.com/en/app-239-Grand_Theft_Auto_III.html
# Mod Liberty Extended: https://libertycity.net/files/gta-3/191140-liberty-extended-2-0.html
# Mod Widescreen Fix: https://libertycity.net/files/gta-3/91934-gta-iii-widescreen-fix.html
# Icon Shortcut: https://dynami-battles.fandom.com/pt-br/wiki/Claude_(GTA_III)

# Extras Mod
# HD Vehicles: https://es.libertycity.net/files/gta-3/38239-paquete-de-vehculos-hd-de-gta3-iii.html
# HD Pack Texture: https://es.libertycity.net/files/gta-3/185097-paquete-de-texturas-hd-pantallas-de-carga-men-etc..html
# High Quality Splash Screens: https://gamemodding.com/es/gta-3/others/49925-high-quality-splash-screens.html
# Remaster HUD: https://es.libertycity.net/files/gta-3/174502-hud-remasterizado.html
# Sound: https://es.libertycity.net/files/gta-3/168609-nuevos-sonidos-v2.0.html
# Shoot and moves: https://es.libertycity.net/files/gta-3/168527-disparar-sobre-la-marcha.html
# Tree: https://es.libertycity.net/files/gta-3/99916-reforma-de-flora-de-liberty-city.html
# Intro: https://es.libertycity.net/files/gta-3/215068-vdeo-intro-mejorado.html
        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Grand Theft Auto III"
PREFIX="GTA3"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="Dadu042 And GuerreroAzul"
COMPANY="Rockstar Games"
HOMEPAGE="https://www.rockstargames.com/games/grandtheftauto3"
LOGO="https://i.imgur.com/nWTJL64.png"
BANNER="https://i.imgur.com/3x8HfZH.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"
 
# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"
 
# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi
 
# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"
 
# Dependencies
# DirectX End-User Runtimes (June 2010)
POL_System_TmpCreate "directx_Jun2010_redist"
cd "$POL_System_TmpDir"
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20DirectX%20End-User%20Runtime/29.9.1974.1%20%28June%202010%29/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4" "DirectX-2010.06"
POL_Wine start /unix "$POL_USER_ROOT/ressources/DirectX-2010.06/directx_Jun2010_redist.exe" /Q /T:"Z:$POL_System_TmpDir"
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"

# POL_Wine_WaitBefore "DirectX End-User Runtimes (June 2010)"
POL_SetupWindow_wait_next_signal "Instalando DirectX (Jun 2010)" "$TITLE"
cabextract -q -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/system32" "$POL_System_TmpDir"/*.cab
POL_System_TmpDelete

# Direct Show Filters Fix
POL_Call POL_Install_DirectShowFiltersFix

# Script start
POL_SetupWindow_InstallMethod "LOCAL, DVD, DOWNLOAD"
# Install for download
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  # Download
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/GTA3.zip" "80aef15329c0edeb79c5d20a8cefd225"  "$PREFIX"
  POL_System_unzip "$POL_USER_ROOT/ressources/$PREFIX/GTA3.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"

  # WidescreenFix
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/WidescreenFix.zip" "7473627fa4c85238dc16b498f95f1da4"  "$PREFIX"
  POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/WidescreenFix.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
# Install CD/DVD
elif [ "$INSTALL_METHOD" = "DVD" ]; then
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "setup.exe" "SETUP.EXE"
  INSTALLER="$CDROM/SETUP.EXE"
  cd "$CDROM"

  # WidescreenFix
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/WidescreenFix.zip" "7473627fa4c85238dc16b498f95f1da4"  "$PREFIX"
  POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/WidescreenFix.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  
  # Install Program
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$TITLE"

# Install local
else
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"

  # Install Program
  EXT="${INSTALLER##*.}"
  
  if [[ "$EXT" == "zip" ]]; then
    # Archive zip
    POL_Wine_WaitBefore "$TITLE"
    unzip -q "$INSTALLER" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  elif [[ "$EXT" == "rar" ]]; then
    # Archive rar
    if ! command -v unrar >/dev/null 2>&1; then
      sudo apt install -y unrar

      POL_Wine_WaitBefore "$TITLE"
      unrar x -inul "$INSTALLER" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
    fi
  else
    POL_Wine start /unix "$INSTALLER"
    POL_Wine_WaitExit "$INSTALLER"
  fi

  # WidescreenFix
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/WidescreenFix.zip" "7473627fa4c85238dc16b498f95f1da4"  "$PREFIX"
  POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/WidescreenFix.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
fi

# Install mod Liberty Extended
POL_SetupWindow_question "$(eval_gettext 'Do you want to install the Liberty Extended mod?')" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]; then
  # Select version
  POL_SetupWindow_menu "$(eval_gettext 'Which version of Liberty Extended do you want to install?')" "$TITLE" "2.0 Build 2025.10, 2.0 Build 2025.07" ", "

  # Download Mod
  if [ "$APP_ANSWER" = "2.0 Build 2025.07" ]; then
    POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/LibertyExtended-2507.zip" "ee04fd8244943ba6c60f7012d2ca80a4"  "$PREFIX"
    POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/LibertyExtended-2507.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  else
    POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/LibertyExtended-2510.zip" "a17da5834e37e336fbc4915d9854e61a"  "$PREFIX"
    POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/LibertyExtended-2510.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  fi

  # MoreMods
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/MoreMods-2510.zip" "c2d507bf289063d364110effff81d9d2"  "$PREFIX"
  POL_System_unzip -o "$POL_USER_ROOT/ressources/$PREFIX/MoreMods-2510.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"

  # File save 
  rm -rf "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto III/LibertyExtended/userfiles"
  mkdir -p "$(xdg-user-dir DOCUMENTS)/GTA3 User Files"
  ln -s "$(xdg-user-dir DOCUMENTS)/GTA3 User Files" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto III/LibertyExtended/userfiles"
  
  # Shortcut
  POL_Shortcut "re3.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"
else
  # Shortcut
  POL_Shortcut "gta3.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"
fi

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_SetupWindow_Close
exit 0