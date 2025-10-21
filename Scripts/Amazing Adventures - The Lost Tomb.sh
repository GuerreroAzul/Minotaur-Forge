#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerrreroAzul
# Contributor: GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerrreroAzul] 2025-10-20 21:44 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Script version: 1.0.4
#   Title correction on installation.
# [GuerrreroAzul] 2025-09-30 21:03 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Script version: 1.0.3
#   Update Link Download And Link Resources.
# [GuerrreroAzul] 2025-09-30 21:03 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Script version: 1.0.2
#     Updating to a dynamic software list.
# [GuerrreroAzul] 2024-08-07 09:30 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 XFCE
# Script creation:
#   Wine version: 9.0
#   System version: Windows 7
#   Architecture: 32bits
# Reference
#   Link download: https://www.ea.com/es/games/amazing-adventures/amazing-adventures-the-lost-tomb / https://store.steampowered.com/app/3510/Amazing_Adventures_The_Lost_Tomb/

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
TITLE="Amazing Adventures The Lost Tomb"
PREFIX="AATLT"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerrreroAzul"
COMPANY="PopCap Games"
HOMEPAGE="https://www.ea.com/es/games/amazing-adventures/amazing-adventures-the-lost-tomb"
LOGO="https://i.imgur.com/cFCoEHR.png"
BANNER="https://i.imgur.com/YoLtCeH.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

# Setup Image
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
# Verification of digital signatures and Microsoft certificates. (Download dll: https://es.dll-files.com/)
# Crypto API32
# POL_Download_Resource "https://archive.org/download/Resources-POL/CRYPT32/x86/10.0.19041.21/crypt32.dll" "26620d486c4892d15200149924be2cf8" "crypt32"
# cp -f "$POL_USER_ROOT/ressources/crypt32/crypt32.dll" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/system32/"
# POL_Wine_OverrideDLL "native, builtin" crypt32.dll

# Microsoft Abstract Syntax Notation 1
# POL_Download_Resource "https://archive.org/download/Resources-POL/MSASN1/x86/10.0.18362.1/msasn1.dll" "5e66a3ed8f267aa2ccea3ffcfe9ffecc" "msasn1"
# cp -f "$POL_USER_ROOT/ressources/msasn1/msasn1.dll" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/system32/"
# POL_Wine_OverrideDLL "native, builtin" msasn1.dll

# Microsoft Trust Verification APIs
# POL_Download_Resource "https://archive.org/download/Resources-POL/WINTRUST/x86/10.0.18362.387/wintrust.dll" "b403ccad0dda00a64bf49f975b7b5afd" "wintrust"
# cp -f "$POL_USER_ROOT/ressources/wintrust/wintrust.dll" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/system32/"
# POL_Wine_OverrideDLL "native, builtin" wintrust.dll
# POL_Wine regsvr32 /s wintrust.dll

# DirectX End-User Runtimes (June 2010)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20DirectX%20End-User%20Runtime/29.9.1974.1%20%28June%202010%29/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4" "DirectX-2010.06"
POL_Wine start /unix "$POL_USER_ROOT/ressources/DirectX-2010.06/directx_Jun2010_redist.exe" /Q /T:"C:/users/$USER/Temp/directx_Jun2010_redist"
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"
POL_Wine --ignore-errors "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/directx_Jun2010_redist/DXSETUP.exe" &>/dev/null
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  # Install Program
  POL_Download_Resource "https://archive.org/download/Game-POL/Amazing%20Adventures%20-%20The%20Lost%20Tomb/File.zip" "8f025f460c8c4da7aef5943137132706" "$PREFIX"
  POL_System_unzip "$POL_USER_ROOT/ressources/$PREFIX/File.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$TITLE"
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
POL_Shortcut "AmazingAdventures.exe" "$TITLE" "" "" "$CATEGORY"

# Update icon
# wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$SHORTCUT"
# wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$SHORTCUT"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0