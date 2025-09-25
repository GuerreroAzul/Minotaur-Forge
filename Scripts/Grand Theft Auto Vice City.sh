#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: LinuxScripter
# License: Retail
 
# CHANGELOG
# [GuerrreroAzul] (2025-06-16 19-42 GMT-6) / Linux Mint 22.1 x86_64
#   The following features have been updated:
#     + Wine version 9.0
#   Added the following features:
#     + System version: Windows 7
#     + Category: Games
# [Dadu042] (2018-08-21 22-46)
#   [Setting initial]
#     + Version wine: 3.0.2

 
# REFERENCE
# [GuerreroAzul]
# Documentation POL: https://www.playonlinux.com/en/app-225-Grand_Theft_Auto__Vice_City.html
# Mod Vice Extended: https://libertycity.net/files/gta-vice-city/167639-vice-extended-june-2025-update.html
# Icon Shortcut: https://www.deviantart.com/blitzk93/gallery#content

        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Grand Theft Auto Vice City"
PREFIX="GTAVC"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="LinuxScripter And GuerreroAzul"
COMPANY="Rockstar Games"
HOMEPAGE="https://www.rockstargames.com/games/vicecity"
LOGO="https://i.imgur.com/wuS3euS.png"
BANNER="https://i.imgur.com/28Pj9np.png"
URL="https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20Vice%20City/x86/setup.exe"
MD5URL="3e5718650121ed8d72654efecc315841" 
FILE="setup.exe"

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
# Microsoft DirectX 9
POL_Call POL_Install_d3dx9
 
# Script start
POL_SetupWindow_InstallMethod "LOCAL, DVD, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_Download_Resource "$URL" "$MD5URL" "$PREFIX"
    INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/$FILE"
elif [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup.exe" "SETUP.EXE"
    INSTALLER="$CDROM/SETUP.EXE"
    cd "$CDROM"
else
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
fi
 
# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# File save
if [ -f "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto Vice City/reVC.exe" ]; then
  rm -rf "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto Vice City/ViceExtended/userfiles"
  ln -s "$(xdg-user-dir DOCUMENTS)/GTA Vice City User Files" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto Vice City/ViceExtended/userfiles"
fi

# Shortcut
if [ -f "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto Vice City/reVC.exe" ]; then
  POL_Shortcut "reVC.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"
else
  POL_Shortcut "gtavc.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"
fi

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0