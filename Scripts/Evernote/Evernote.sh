#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail
 
CHANGELOG
[GuerrreroAzul] (2025-08-08 20-26 GMT-6) / Linux Mint 22.1 x86_64
  Script creation:
    + Wine version 9.0
    + System version: Windows 10
    + Category: Accesories
[thib25] (2009-10-08 19-10) 
  Script creation:
    + Wine version: 1.1.30
    + Architecture: 32bits
 
REFERENCE
[GuerreroAzul]
Documentation POL: https://www.playonlinux.com/en/topic-2960-Colin_Mcrae_Rally_2.html
Link Download: https://evernote.com/es-es/download
Icon Shortcut: https://www.deviantart.com/loobootoo/art/Evernote-158267137
'
        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setting
TITLE="Evernote"
PREFIX="Evernote"
CATEGORY="Accesories;"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="GuerreroAzul"
COMPANY="Codemasters"
HOMEPAGE="https://www.ea.com/ea-studios/codemasters"
LOGO="https://i.imgur.com/WN1PF5O.png"
BANNER="https://i.imgur.com/ST9Jm11.png"

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

# Mode Unattended
POL_SetupWindow_question "$(eval_gettext 'Do you want to use unattended mode?\n\n
The following options will be performed automatically:\n
❖ Download and install $TITLE.\n
❖ Download and install the mods.')" "$TITLE"
UNATTENDED="$APP_ANSWER"

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"
 
# Install Dependencies
POL_Call POL_Install_d3dx9 # Microsoft DirectX 9
 
# Install Program
if [ "$UNATTENDED" = "TRUE" ]; then
  INSTALL_METHOD="DOWNLOAD"
else
  POL_SetupWindow_InstallMethod "LOCAL, DVD, DOWNLOAD"
fi

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_Download_Resource "https://archive.org/download/Game-POL/Colin%20McRae%20Rally%202/$PREFIX.exe" "39c14354ccc98e6878adc6e98968e06d" "$PREFIX"
    INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/$PREFIX.exe"
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
cd $WINEPREFIX
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

#Install INPUT8
POL_Download_Resource "https://archive.org/download/DLL-POL/INPUT8/dinput8.dll" "dfe561ad494e657cbc0a9a222ba1a792" "dinput8"
cp "$POL_USER_ROOT/ressources/dinput8/dinput8.dll" -d "$WINEPREFIX/drive_c/Program Files/Codemasters/$TITLE/"

# Install mods
if [ "$UNATTENDED" = "TRUE" ]; then
  APP_ANSWER="TRUE"
else
  POL_SetupWindow_question "$(eval_gettext 'Do you want to install the mods package?\n\n
  ❖ CMR2 Official WRC Liveries.')" "$TITLE"
fi

if [ "$APP_ANSWER" = "TRUE" ]; then
  POL_Download_Resource "https://archive.org/download/Game-POL/Colin%20McRae%20Rally%202/CMR2_Official_WRC_Liveries.exe" "59e00d37450e39af3d6e2b7e7cdf2b77" "$PREFIX"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/$PREFIX/CMR2_Official_WRC_Liveries.exe"
  POL_Wine_WaitExit "CMR2 Official WRC Liveries"
fi

# Shortcut
if [ -f "$WINEPREFIX/drive_c/Program Files/Codemasters/$TITLE/$PREFIX.exe" ]; then
  POL_Shortcut "$PREFIX.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"

  # Update icon
  wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
  wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"
fi

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0