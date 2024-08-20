#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# License: Retail

# CHANGELOG
# [GuerreroAzul] (2024-08-09 14:41 GMT-6) Wine 9.0 / Linux Mint 22 x86_64
#   [Setting]
#     Version wine: 9.0
#     Version system: win11
# [GuerreroAzul] (2024-03-16 10:40 GMT-6) Wine 4.0.1-staging / Linux Mint 21.3 x86_64
#   [Setting]
#     Version wine: 4.0.1-staging
#     Version system: winxp
#   [Reference]
#     Pay Game: https://www.rockstargames.com/es/games/grandtheftauto3
#     WineHQ 4.0.1-staging: https://appdb.winehq.org/objectManager.php?sClass=version&iId=12413
# [Dadu042] (2019-06-01 13:21) Wine 2.22 / Ubuntu 18.04 x64
#   Rewrite the script for because the previous (2009-10-31) fail working (on POL 4.3.4).
#   [Setting initial]
#     Version wine: 2.22
#     Category: Game;
#     Version system: winxp
#   [Reference]
#     Document: https://en.wikipedia.org/wiki/Grand_Theft_Auto_III

# KNOWN ISSUES:
# None


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Grand Theft Auto III"
PREFIX="GTA_III"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win11"
EDITHOR="Dadu042 And GuerreroAzul"
COMPANY="Rockstar Games, Inc."
HOMEPAGE="https://www.rockstargames.com/es/games/grandtheftauto3"
LOGO="https://imgur.com/7jsITcK.png"
BANNER="https://imgur.com/Io2juXq.png"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init
POL_Debug_Init

# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"

# PlayOnLinux Version Check
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\n Please update!')"

# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# [Dadu042]: GPU setting 
# Really indispensable?
# POL_SetupWindow_VMS "16"

# [GuerreroAzul]:
#    Library DirectX 9: Improves game fluidity
POL_Call POL_Install_d3dx9

# [Dadu042]: 
#POL_Call POL_Install_VideoDriver
#POL_Wine_X11Drv "DXGrab" "Y"

# Prepare installation
cd "$HOME"

POL_SetupWindow_InstallMethod "LOCAL,CD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
else
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "setup.exe"
  INSTALLER="$CDROM/Setup.exe"
fi

# Install program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"
cd "$POL_System_TmpDir"

# Shortcut 
POL_Shortcut "gta3.exe" "$TITLE" "" "" "$CATEGORY"
POL_Shortcut_QuietDebug "$TITLE"

POL_SetupWindow_message "When you will run GTA 3, wait a few seconds and double-click to launch correctly\nthe game.\n\nFRENCH: Quand vous lancerez GTA 3, patientez quelques secondes puis double-cliquez pour\nlancer correctement le jeu." "$TITLE"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0