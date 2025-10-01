#!/usr/bin/env playonLinux-bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Tiago Arnold "contato@radaction.com.br"
# Contributor: RainPedia, Dadu042, Varlyakov And GuerrreroAzul
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerreroAzul] 2025-09-27 06-06 (UTC -06-00) / wine 9.0 x86 / Linux Mint 22.2 x86_64
#   Script version: 1.7.3
#   - Updating to a dynamic software list.
# [GuerreroAzul] 2024-08-16 13-03 (UTC -06-00) / Wine 9.0 x86 / Linux Mint 21.3 x86_64
#   Script version: 1.7.1
#   Update software version: 3.40 -> 3.41
#   Update system version: win10 -> win11
# [GuerreroAzul] 2024-04-26 10:50 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 21.3 x86_64
# The following features have been updated:
#   Wine version: 3.0.3 - 9.0
#   Link download: Link version 3.0 to 3.40
# Added the following features: 
#   Category: Network
#   System version: Windows 10
# Reference
#   Documentation: https://www.playonlinux.com/en/app-3035-Winbox.html
#   Link Download: https://mikrotik.com/download
#
# [Varlyakov] 2022-06-14 22:17 / Wine 3.0.3 x86
# The following features have been updated:
#   Link download: https://download.mikrotik.com/winbox/3.36/winbox.exe / MD5: ae0b5a345570a1317798d5b4bf61b012
# 
# [Dadu042] 2022-04-01 / Wine 3.0.3 x86
# The following features have been updated:
#   Wine version 3.0 -> 3.0.3
#
# [RainPedia] 2022-04-02 / Wine 3.0 x86
# The following features have been updated:
#   Wine version 1.6.2 -> 3.0
#   Link download: https://download.mikrotik.com/winbox/3.35/winbox.exe / MD5: 9473cfce0061b0853801a283c8d87a79
#
# [Tiago Arnold] 2016-09-13 21:27 / Wine 1.6.2 x86 / Ubuntu 16.04 LTS
# [contato@radaction.com.br] 
# Script creation:
#   Wine version: 1.6.2
#   System version: Windows XP
#   Architecture: 32bits
# Reference
#   Link Download: Link download: http://download2.mikrotik.com/routeros/winbox/3.13/winbox.exe / MD5: 5d97cafd31963ab6360c9b056f6ba26b825a4a2f

# Start script
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
TITLE="WinBox"
PREFIX="WinBox"
CATEGORY="Network;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="\nTiago Arnold \"contato@radaction.com.br\" \nRainPedia, Dadu042, Varlyakov \nGuerrreroAzul"
COMPANY="Mikrotik"
HOMEPAGE="https://www.mikrotik.com/"
LOGO="https://i.imgur.com/mtBHg4G.png"
BANNER="https://i.imgur.com/l0WtSka.png"

# Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Download image manual
mkdir -p "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

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
# Compressor AAZ
# if [ ! -f "$HOME/.local/bin/aaz" ]; then
#   POL_Download_Resource "https://archive.org/download/DLL-POL/aaz.sh" "53551e6e55190e7613a69eb76f32ceef" "aaz"
#   mkdir -p "$HOME/.local/bin"
#   cp "$POL_USER_ROOT/ressources/aaz/aaz.sh" -d "$HOME/.local/bin/aaz"
#   chmod +x "$HOME/.local/bin/aaz"
# fi

# Script start
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"

  # Download List
  mkdir -p "$POL_USER_ROOT/ressources/list/"
  rm -f "$POL_USER_ROOT/ressources/list/WinBox.lst"
  wget --header="User-Agent: Mozilla/5.0" -qO "$POL_USER_ROOT/ressources/list/WinBox.lst" "https://archive.org/download/Resources-POL/List%20URL/WinBox.lst"

  # Charge list
  source "$POL_USER_ROOT/ressources/list/WinBox.lst"

  # [GuerreroAzul] List of WinBox versions
  POL_SetupWindow_menu "$(eval_gettext 'Select the version you want to install'):" "$TITLE" "$LISTVERSION" " "
  URL=$(echo ${LISTURL[$APP_ANSWER]} | cut -d" " -f1)
  MD5URL=$(echo ${LISTURL[$APP_ANSWER]} | cut -d" " -f2)
  FILE=${URL##*/}


  POL_Download_Resource "$URL" "$MD5URL" "$PREFIX"
  INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/$FILE"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
  FILE=$(echo "$INSTALLER" | rev | cut -d'/' -f1 | rev)
fi
 
# Install Program
mkdir -p "$WINEPREFIX/drive_c/Program Files/$PREFIX/"
cp "$INSTALLER" -d "$WINEPREFIX/drive_c/Program Files/$PREFIX/"
 
# Shortcut
POL_Shortcut "$FILE" "$TITLE" "" "" "$CATEGORY"

# Update icon
# wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$SHORTCUT"
# wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$SHORTCUT"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
