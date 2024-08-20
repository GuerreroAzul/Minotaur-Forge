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

#Setting
TITLE="GameLoop"
PREFIX="GameLoop"
CATEGORY="Games;"
WINEVERSION="9.0"
ARQUITECTURE="x86"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="Hong Kong Gathering Media Limited"
HOMEPAGE="https://www.gameloop.com/"
LOGO="https://i.imgur.com/bszmPOY.png"
BANNER="https://i.imgur.com/Di6W76j.png"

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

#Dependencies
#Solution: (0390:fixme:d3d:wined3d_check_device_multisample_type multisample_type 32 not handled yet.)
POL_Call POL_Install_d3dx9
#Solution: (00d0:fixme:richedit:fnTextSrv_OnTxSetCursor Ignoring most params)
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Wine_OverrideDLL "native,builtin" "riched20"
POL_Wine_OverrideDLL "native,builtin" "riched30"
# POL_Call POL_Install_msxml6
# POL_Wine_OverrideDLL "native,builtin" "msxml6"

# Script start
cd "$HOME"

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

# Shortcut
POL_Shortcut "AppMarket.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
