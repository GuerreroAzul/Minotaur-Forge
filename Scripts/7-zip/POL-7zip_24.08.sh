#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: thib25
# Contributor: Tautul, ndykimpe and GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerrreroAzul] 2024-08-14 14-25 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 Xfce4
#   Updates:
#     Wine version: 5.0.2 -> 9.0
#     System version: system -> Windows 11
#     Version Software: 19.0 -> 24.08
#   References:
#     Link download: https://sourceforge.net/projects/sevenzip/
#     Documentation: https://www.playonlinux.com/en/app-373-7Zip.html
# [SuperPlumus] 2014-12-25 11:59 / wine 1.3.5 
#   Update Wine version 1.3.5 -> System
#   Update 7-Zip version 4.65 -> 9.20
#   Update messages
#   Change title and prefix names
# [SuperPlumus] 2014-12-25 11:59
#   Clean code
# [p-90-for-retail] 2018-3-3 18:26
#   Update 7-Zip version 9.20 -> 18.01
# [Yaotl] 2020-8-4 00-59
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
WINEVERSION="9.0"
OSVERSION="win11"
EDITHOR="thib25 \n Dadu042, Yaotl, SuperPlumus, ndykimpe and GuerrreroAzul"
COMPANY="Igor Pavlov."
HOMEPAGE="https://www.7-zip.org/"
LOGO="https://imgur.com/XviIkPZ.png"
BANNER="https://imgur.com/ba7r3Zz.png"

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
# ...

# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    if [ "$POL_ARCH" == "amd64" ]; then
        POL_Download "https://7-zip.org/a/7z1900-x64.exe" "d7b20f933be6cdae41efbe75548eba5f"
        INSTALLER="$POL_System_TmpDir/7z1900-x64.exe"
    else
        POL_Download "https://7-zip.org/a/7z1900.exe" "fabe184f6721e640474e1497c69ffc98"
        INSTALLER="$POL_System_TmpDir/7z1900.exe"
    fi
fi

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

# Shortcut
POL_Shortcut "AmazingAdventures.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0