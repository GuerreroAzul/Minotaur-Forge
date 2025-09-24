#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail
 
CHANGELOG
[GuerrreroAzul] (2025-08-11 17-16 GMT-6) / Linux Mint 22.1 x86_64
  Script creation:
    + Wine version 8.1-staging
    + System version: Windows 10
    + Category: Games
    + Architecture: 64bits
 
REFERENCE
[GuerreroAzul]
Documentation POL: 
Link Download: https://pvzge.com/en/download/
Icon Shortcut: 
'

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Setting
TITLE="Plants Vs Zombies 2 Gardendless"
PREFIX="PVZGE"
CATEGORY="Games;"
WINEVERSION="8.1-staging"
OSVERSION="win10"
ARQUITECTURE="x64"
EDITHOR="GuerreroAzul"
COMPANY="Gaozih"
HOMEPAGE="https://pvzge.com/"
LOGO="https://i.imgur.com/1jmpalA.png"
BANNER="https://i.imgur.com/44yu2PO.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

# Setup Images
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
 
#wine Setup And Installation
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "$ARQUITECTURE"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# Install Dependencies
# ...
 
# Install Program
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"
 
# Install Program
cd $WINEPREFIX
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Shortcut
#POL_Shortcut "$PREFIX.exe" "$TITLE" "" "" "$CATEGORY"
#POL_Shortcut_QuietDebug "$TITLE"

# Update icon
#wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
#wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0