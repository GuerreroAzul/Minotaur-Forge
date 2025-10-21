#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerrreroAzul] 2025-10-20 21:53 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Script version: 1.0.1
#   Title correction on installation.
#   Update Link Download And Link Resources.
# [GuerreroAzul] 2025-10-01 19:40 (UTC -06-00) / Wine 9.0 / Linux Mint 22.2 x86_64 xfce
#   Script version: 1.0.0 (Creation of the script)
#   wine: 9.0
#   version OS: win7
#   Category: Games
#
# REFERENCE
# GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-4976-Plants_Vs_Zombies_Hybrid_Edition.html
# GuerreroAzul Download - https://www.pvz-hybrid.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Plants Vs Zombie Hybrid Edition"
PREFIX="PVZHE"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="潜艇伟伟迷"
HOMEPAGE="https://www.pvzhe.com/"
LOGO="https://i.imgur.com/40Ek4HL.png"
BANNER="https://i.imgur.com/qZyKko1.png"

# Download image manual
mkdir -p "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

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

# Dependencies
# ...

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_Download_Resource "https://archive.org/download/Game-POL/Plants%20Vs%20Zombies%20Hybrid%20Edition/3.9/File.zip" "71eba4b21b78d895a056ec63d7ba7680" "$PREFIX"
  POL_System_unzip "$POL_USER_ROOT/ressources/$PREFIX/File.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp"

  POL_Wine start /unix "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/植物大战僵尸杂交版v3.9/植物大战僵尸杂交版v3.9安装程序.exe"
    POL_Wine_WaitExit "$TITLE"
else
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"

  # Install Program
  EXT="${INSTALLER##*.}"
  
  if [[ "$EXT" == "zip" ]]; then
    # Archive zip
    POL_Wine_WaitBefore "$TITLE"
    unzip -q "$INSTALLER" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  elif [[ "$EXT" == "rar" ]]; then
    # Archive rar
    POL_Wine_WaitBefore "$TITLE"
    unrar x -inul "$INSTALLER" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
  else
    POL_Wine start /unix "$INSTALLER"
    POL_Wine_WaitExit "$TITLE"
  fi
fi

# Shortcut
POL_Shortcut "pvzHE-Launcher.exe" "$TITLE" "" "" "$CATEGORY"

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0