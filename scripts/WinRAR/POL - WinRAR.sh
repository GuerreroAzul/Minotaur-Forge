#!/usr/bin/env playonLinux-bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# Contributor: --
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerreroAzul] 2024-10-26 08-28 (UTC -06-00)
#   Script version: 1.2.2
#   Update software version: 3.41
#   Update system version: win10
#   Wine version: 3.0.3 - 9.0
#   Link download: Link version 3.01
# Added the following features: 
#   Category: Accesories
#   System version: Windows 10
# [GuerrreroAzul] (2024-03-12 14:00 GMT-6) Wine 9.0 / Linux Mint 21.3 x86_64
# Changes:
#   Update version wine: 8.6 --> 9.0
#   Update version OS: win7 --> win10
# [GuerrreroAzul] (2024-02-06 14:00 GMT-6) Wine 8.6 / Linux Mint 21.3 x86_64
# Changes: 
#   Creation of the script
# Reference:
#   GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-4618-Winrar.html
#   GuerreroAzul: Link Download. - https://www.win-rar.com/download.html

# Start script
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
Title="WinRAR"
Prefix="winrar"
Category="Accesories;"
WineVersion="9.0"
SystemVersion="win10"
Edithor="GuerrreroAzul"
Company="RARLAB"
OfficialSite=" https://www.win-rar.com"
Logo="https://i.imgur.com/IX5pv1c.png"
Banner="https://i.imgur.com/XzPLBfB.png"

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
POL_Wine_PrefixCreate "$WineVersion"
Set_OS "$SystemVersion"
 
#Dependencies
POL_Call POL_Install_corefonts
 
# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
Installer="$APP_ANSWER"
FileSoftware=$(echo "$Installer" | rev | cut -d'/' -f1 | rev)
 
# Install Program
POL_Wine start /unix "$Installer"
POL_Wine_WaitExit "$Installer"
 
# Shortcut
POL_Shortcut "$Prefix.exe" "$Title" "" "" "$Category"

# Extension
POL_Extension_Write zip "$Title"
POL_Extension_Write rar "$Title"
POL_Extension_Write 7zip "$Title"
 
# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
