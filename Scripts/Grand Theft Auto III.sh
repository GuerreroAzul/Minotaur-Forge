#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# License: Retail
 
# CHANGELOG
# [GuerreroAzul] 2025-10-03 11-47 (UTC -06-00) // Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Version: 1.0.3
#   - Update URL Download Game
#   - Update Funtions And Dependencies
# [GuerrreroAzul] (2025-06-10 08-55 GMT-6) / Linux Mint 22.1 x86_64
#   The following features have been updated:
#     + Wine version 9.0
#   Added the following features:
#     + System version: Windows 7
#     + Category: Games
# [Dadu042] (2019-06-01 13:21) Wine 2.22 / Ubuntu 18.04 x64
#   Rewrite the script for because the previous (2009-10-31) fail working (on POL 4.3.4).
#   [Setting initial]
#     + Version wine: 2.22
#     + Category: Game;
#     + Version system: winxp
#   [Reference]
#     + Document: https://en.wikipedia.org/wiki/Grand_Theft_Auto_III

 
# REFERENCE
# [GuerreroAzul]
# Documentation POL: https://www.playonlinux.com/en/app-239-Grand_Theft_Auto_III.html
# Mod Liberty Extended: https://libertycity.net/files/gta-3/191140-liberty-extended-2-0.html
# Mod Widescreen Fix: https://libertycity.net/files/gta-3/91934-gta-iii-widescreen-fix.html
# Icon Shortcut: https://libertycity.net/files/gta-3/165832-gta-3-icon-trilogy-style.html
        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Grand Theft Auto III"
PREFIX="GTA3"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="Dadu042 And GuerreroAzul"
COMPANY="Rockstar Games"
HOMEPAGE="https://www.rockstargames.com/games/grandtheftauto3"
LOGO="https://i.imgur.com/70JclLT.png"
BANNER="https://i.imgur.com/3x8HfZH.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

#Setup Image
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
# Compressor AAZ
if [ ! -f "$HOME/.local/bin/aaz" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Funtions/aaz.sh" "057fe635857d9db4555c33f4ce4b839f" "aaz"
  mkdir -p "$HOME/.local/bin"
  cp "$POL_USER_ROOT/ressources/aaz/aaz.sh" -d "$HOME/.local/bin/aaz"
  chmod +x "$HOME/.local/bin/aaz"
fi

# DirectX End-User Runtimes (June 2010)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20DirectX%20End-User%20Runtime/29.9.1974.1%20%28June%202010%29/archive.aaz" "57d73733cac213c3a126c935455d7b1d" "DirectX-2010.06"
aaz x "$POL_USER_ROOT/ressources/DirectX-2010.06/archive.aaz" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/directx_Jun2010_redist"
POL_Wine --ignore-errors "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/directx_Jun2010_redist/DXSETUP.exe"
 
# Script start
# Install for download
POL_SetupWindow_InstallMethod "LOCAL, DVD, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20III/archive.aaz" "5655223ca64495d08ccaf726e1a049d0" "$PREFIX"

  # Unzip program
  POL_Wine_WaitBefore "$TITLE"
  aaz x "$POL_USER_ROOT/ressources/$PREFIX/archive.aaz" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/"
 
  # File save 
  rm -rf "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto III/LibertyExtended/userfiles"
  mkdir -p "$(xdg-user-dir DOCUMENTS)/GTA3 User Files"
  ln -s "$(xdg-user-dir DOCUMENTS)/GTA3 User Files" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Grand Theft Auto III/LibertyExtended/userfiles"
  
  POL_Shortcut "re3.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"

# Install CD/DVD
elif [ "$INSTALL_METHOD" = "DVD" ]; then
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "setup.exe" "SETUP.EXE"
  INSTALLER="$CDROM/SETUP.EXE"
  cd "$CDROM"

  # Install Program
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$TITLE"

  POL_Shortcut "gta3.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"

# Install local
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
    POL_Wine_WaitExit "$INSTALLER"
  fi

  POL_Shortcut "gta3.exe" "$TITLE" "" "" "$CATEGORY"
  POL_Shortcut_QuietDebug "$TITLE"
fi

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0