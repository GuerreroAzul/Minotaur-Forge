#!/usr/bin/env PlayOnLinux-Bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerreroAzul] 2024-08-21 08-05 (UTC -06-00)
#   Script version: 1.1.1
#   Wine Version: 9.0
#   System version: win7
#   REFERENCE:
#     GuerreroAzul: Documentation POL. - https://appdb.winehq.org/objectManager.php?sClass=application&iId=178
#     GuerreroAzul: Link Download. - https://www.flstudio.com
# [GuerrreroAzul] (2023-11-10) Wine 4.15 x32 / Linux Mint 21.2 x86_64

 

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variable
Title="FL Studio"
Prefix="FLStudio"
Category="Audio;"
WineVersion="6.17"
Arquitecture="x64"
SystemVersion="win7"
Edithor="GuerreroAzul"
Company="FL Studio"
OfficialSite="https://www.flstudio.com"
Logo="https://i.imgur.com/5uNFnCo.png"
Banner="https://i.imgur.com/5XM8pwB.png"
FileSetup="FL64.exe"
  
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
  
# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
Installer="$APP_ANSWER"
FileSoftware=$(echo "$Installer" | rev | cut -d'/' -f1 | rev)
 
# Install Program
POL_Wine start /unix "$Installer"
POL_Wine_WaitExit "$Installer"

# Shortcut
POL_Shortcut "$FileSetup" "$Title" "" "" "$Category"
 
#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
