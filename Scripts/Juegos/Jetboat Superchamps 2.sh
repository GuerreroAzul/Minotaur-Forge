#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: GNU General Public License v3.0
 
# CHANGELOG
# [GuerrreroAzul] 2025-10-21 18:54 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Script version: 1.0.2
#   version OS: Windows XP --> Windows 7
#   Update Link Download And Link Resources.
# [GuerreroAzul] 2025-09-30 19:40 (UTC -06-00) / Wine 9.0 / Linux Mint 22.2 x86_64 xfce
#   Script version: 1.0.1 (Creation of the script)
#   wine: 9.0
#   version OS: winxp
#   Category: Games
 
# [GuerrreroAzul] (2024-02-06 14:00 GMT-6) Wine 8.6 / Linux Mint 21.3 x86_64
#   
 
# REFERENCE
# GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-4981-jet_boat_superchamps_2.html

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Jetboat Superchamps 2"
PREFIX="JBS2"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="Small Rockets"
HOMEPAGE=""
LOGO="https://i.imgur.com/BOMbjOu.png"
BANNER="https://i.imgur.com/ba7r3Zz.png"

# Download image manual
mkdir -p "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init
 
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
# ...

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_Download_Resource "https://archive.org/download/Game-POL/Jetboat%20Superchamps%202/File.zip" "c5ba4f03b8a7d5c02894e8b0cdb9d766" "$PREFIX"
  POL_System_unzip "$POL_USER_ROOT/ressources/$PREFIX/File.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
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
    POL_Wine_WaitBefore "$TITLE"
    unrar x -inul "$INSTALLER" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  else
    POL_Wine start /unix "$INSTALLER"
    POL_Wine_WaitExit "$INSTALLER"
  fi
fi

# Shortcut
POL_Shortcut "jbs2.exe" "$TITLE" "" "" "$CATEGORY"

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0