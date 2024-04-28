#!/usr/bin/env PlayOnLinux-Bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-04-17 08:12 GMT-6) Wine 8.1-staging x64 / Linux Mint 21.3 x86_64
  First script. 

REFERENCE
GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
GuerreroAzul: Link Download. - https://www.advancedrenamer.com/download
'

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Advanced Renamer"
PREFIX="advancedrenamer"
CATEGORY="Other;"
WINEVERSION="8.1-staging"
OSVERSION="win7"
ARQUITECTURE="x64"
EDITHOR="GuerreroAzul"
COMPANY="Hulubulu Software and Kim Jensen"
HOMEPAGE="https://www.advancedrenamer.com/"
LOGO="https://i.imgur.com/XANMtUe.png"
BANNER="https://i.imgur.com/Di6W76j.png"
DOWNLOAD_URL="https://www.advancedrenamer.com/down/advanced_renamer_setup_3_94_3.exe"
FILE_INSTALL="advanced_renamer_setup_3_94_3.exe"
MD5_CHECKSUM="c0bbede64e98f1d1bdb93d6ca65a3ed7"

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

# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Shortcut
POL_Shortcut "ARen.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0