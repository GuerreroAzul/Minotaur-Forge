#!/usr/bin/env playonLinux-bash
# Date : (2011-11-06 18-56)
# Last revision : (2025-02-16 08-31)
# Wine version used : 9.0
# Distribution used to test : Linux Mint 22.1 Xfce4
# Author: GuerreroAzul
# PlayOnLinux: 4.3.4
# Script licence : GPL3
# Program Licence: Retail
# Reference: https://www.playonlinux.com/en/app-373-7Zip.html

# CHANGELOG
# [GuerreroAzul] (2025-02-16 08-31)
#   Update wine version : 
# [SuperPlumus] (2014-12-25 11-59)
#   Update Wine version 1.3.5 -> System
#   Update 7-Zip version 4.65 -> 9.20
#   Update messages
#   Change title and prefix names
# [SuperPlumus] (2014-12-25 11-59)
#   Clean code
# [p-90-for-retail] (2018-3-3 18-26)
#   Update 7-Zip version 9.20 -> 18.01
# [Yaotl] (2020-8-4 00-59)
#   Update System Wine -> 5.0.1
#   Update 7-Zip version 18.01 -> 19.00
#   Change Optimize code
#   Change Add local installation option
# [Dadu042] (2020-09-22 15-00)
#   Update System Wine 5.0.1 -> 5.0.2
#   Add POL_Shortcut category

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
TITLE="7-zip"
PREFIX="7zip"
CATEGORY="Archiving;"
WINE_VERSION="9.0"
OS_VERSION="win10"
POL_VERSION="4.3.4"
EDITHOR="GuerrreroAzul"
COMPANY="Igor Pavlov."
HOME_PAGE="https://www.7-zip.org/"
LOGO="https://imgur.com/XviIkPZ.png"
BANNER="https://imgur.com/ba7r3Zz.png"
DOWNLOAD_SOFTWARE="https://www.7-zip.org/a/7z2409.exe"
MD5_SOFTWARE="00cbef9691efad7a56332fbcf51aa762"
FILE_SOFTWARE=${DOWNLOAD_SOFTWARE##*/}

# Icons
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init
POL_Debug_Init

# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOME_PAGE" "$EDITHOR" "$PREFIX"

# PlayOnLinux Version Check
POL_RequiredVersion "$POL_VERSION" || POL_Debug_Fatal "$(eval_gettext '$TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')" "$TITLE!"

# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"
Set_OS "$OS_VERSION"

# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"

  POL_Download_Resource "$DOWNLOAD_SOFTWARE" "$MD5_SOFTWARE" "$PREFIX"
  INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/$FILE_SOFTWARE"
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
fi

# Install Program
POL_Wine start /unix "$INSTALLER" /S
POL_Wine_WaitExit "$TITLE"

# Shortcut
POL_Shortcut "7zFM.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0