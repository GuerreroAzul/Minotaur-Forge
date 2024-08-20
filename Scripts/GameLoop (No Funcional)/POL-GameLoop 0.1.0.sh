#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-03-12 13:30 GMT-6) Wine 6.17 x64 / Linux Mint 21.3 x86_64
  Creation of the script

REFERENCE
GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
GuerreroAzul: Link Download. - https://www.gameloop.com/
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="GameLoop"
PREFIX="gameloop"
CATEGORY="Games;"
WINEVERSION="6.17"
ARQUITECTURE="x64"
OSVERSION="win10"
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
POL_System_SetArch "$ARQUITECTURE"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

#Dependencies
POL_Call POL_Install_riched20
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "riched20"
POL_Wine_OverrideDLL "native,builtin" "msxml6"

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
