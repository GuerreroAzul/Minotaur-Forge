#!/usr/bin/env playonLinux-bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# Contributor: --
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerreroAzul] 2024-10-26 15-33 (UTC -06-00)
# Changes:
#   Script version: 1.0.1
#   Software version: 2.1.3
#   System version: Windows 10
#   Wine version: 8.1-staging
#   Category: Games
#   System version: Windows 10
# Reference:
#   GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-4591-Plants_Vs_Zombies.html
#   GuerreroAzul: Link Download. - https://plantvz.online/

# Start script
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
Title="Plants Vs Zombies Fusion"
Prefix="PlantsVsZombiesRH"
Category="Games;"
WineVersion="8.1-staging"
SystemVersion="win10"
Arquitecture="x64"
Edithor="GuerrreroAzul"
Company="Blue Fly"
OfficialSite="https://plantvz.online/"
Logo="https://i.imgur.com/KaMX5Dt.png"
Banner="https://i.imgur.com/ba7r3Zz.png"

# Setup Image
POL_GetSetupImages "$Logo" "$Banner" "$Title"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
# Welcome message
POL_SetupWindow_presentation "$Title" "$Company" "$OfficialSite" "$Edithor" "$Prefix"
 
# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"
 
# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$Title!"
fi
 
# Prepare resources for installation!
POL_Wine_SelectPrefix "$Prefix"
POL_System_SetArch "$Arquitecture"
POL_Wine_PrefixCreate "$WineVersion"
Set_OS "$SystemVersion"
 
#Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dx9
 
# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')""$Title"
Installer="$APP_ANSWER"
 
# Install Program
#Installation started
POL_Wine start /unix "$Installer"
POL_Wine_WaitExit "$Installer"
 
# Shortcut
POL_Shortcut "$Prefix.exe" "$Title" "" "" "$Category"
 
# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
