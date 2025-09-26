#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerrreroAzul
# Contributor: GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerrreroAzul] 2024-08-07 09:30 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 XFCE
# Script creation:
#   Wine version: 9.0
#   System version: Windows 7
#   Architecture: 32bits
# Reference
#   Link download: https://www.ea.com/es/games/amazing-adventures/amazing-adventures-the-lost-tomb / https://store.steampowered.com/app/3510/Amazing_Adventures_The_Lost_Tomb/

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
TITLE="Amazing Adventures The Lost Tomb"
PREFIX="AATLT"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerrreroAzul"
COMPANY="PopCap Games"
HOMEPAGE="https://www.ea.com/es/games/amazing-adventures/amazing-adventures-the-lost-tomb"
LOGO="https://i.imgur.com/cFCoEHR.png"
BANNER="https://i.imgur.com/YoLtCeH.png"


# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

# Setup Image
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

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  # Compressor GuerreroAzul
  if [ ! -f "$HOME/.local/bin/aaz" ]; then
    POL_Download_Resource "https://archive.org/download/DLL-POL/aaz.sh" "53551e6e55190e7613a69eb76f32ceef" "aaz"
    mkdir -p "$HOME/.local/bin"
    cp "$POL_USER_ROOT/ressources/aaz/aaz.sh" -d "$HOME/.local/bin/aaz"
    chmod +x "$HOME/.local/bin/aaz"
  fi

  # Install Program
  POL_Download_Resource "https://archive.org/download/Game-POL/Amazing%20Adventures%20-%20The%20Lost%20Tomb/archive.aaz" "36976aa64e158dad112e7bfcbbd93165" "$PREFIX"
  aaz x "$POL_USER_ROOT/ressources/$PREFIX/archive.aaz" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/"
else
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"

  # Install Program
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$INSTALLER"
fi

# Shortcut
POL_Shortcut "AmazingAdventures.exe" "$TITLE" "" "" "$CATEGORY"

# Update icon
# wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$SHORTCUT"
# wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$SHORTCUT"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0