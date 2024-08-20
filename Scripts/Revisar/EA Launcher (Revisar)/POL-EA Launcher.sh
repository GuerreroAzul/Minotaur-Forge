#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: Retail

# CHANGELOG
# [GuerreroAzul] (2024-08-10 13:57 GMT-6) Wine 9.0 / Linux Mint 22 x86_64
#   [Setting initial]
#     Version wine: 9.0
#     Category: Game;
#     Version system: win11
#  REFERENCES
#    Download: https://www.ea.com/es-es/ea-app#downloads

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="EA Launcher"
PREFIX="EaLauncher"
CATEGORY="Games;"
WINEVERSION="8.1-staging"
ARQUITECTURE="x64"
OSVERSION="win11"
EDITHOR="GuerreroAzul"
COMPANY="Electronic Arts Inc."
HOMEPAGE="https://www.rockstargames.com/es/games/grandtheftauto3"
LOGO="https://imgur.com/lwYsA2I.png"
BANNER="https://imgur.com/ba7r3Zz.png"

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
# POL_System_SetArch "$ARQUITECTURE"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# Dependencies
# [Fonts]
#POL_Call POL_Install_corefonts
#POL_Call POL_Install_d3dx9
#POL_Call POL_Install_msxml3
#POL_Call POL_Install_FontsSmoothRGB

# POL_Call POL_Install_mdac28
#POL_Download_Resource "https://web.archive.org/web/20050930211303/http://download.microsoft.com/download/4/a/a/4aafff19-9d21-4d35-ae81-02c48dcbbbff/MDAC_TYP.EXE"
#POL_Wine_OverrideDLL "native,builtin" odbc32 odbccp32 oledb32
#cd "$POL_USER_ROOT/ressources/"
#POL_Wine MDAC_TYP.EXE /q /C:"setup /QNT"

# Prepare installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"
cd "$POL_System_TmpDir"

# Shortcut 
POL_Shortcut "EAappInstaller.exe" "$TITLE" "" "" "$CATEGORY"
#POL_Shortcut_QuietDebug "$TITLE"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0