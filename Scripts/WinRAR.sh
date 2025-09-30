#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: Retail
 
# CHANGELOG
# [GuerreroAzul] 2025-09-28 12:14 (UTC -06-00) / Wine 9.0 / Linux Mint 22.2 x86_64
#   Script version: 1.1.1
#     Updating to a dynamic software list.
# [GuerrreroAzul] (2024-03-12 14:00 GMT-6) Wine 9.0 / Linux Mint 21.3 x86_64
#   Update version wine: 8.6 --> 9.0
#   Update version OS: win7 --> win10
 
# [GuerrreroAzul] (2024-02-06 14:00 GMT-6) Wine 8.6 / Linux Mint 21.3 x86_64
#   Creation of the script
 
# REFERENCE
# GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
# GuerreroAzul: Link Download. - https://www.win-rar.com/download.html

        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="WinRAR"
PREFIX="WinRAR"
CATEGORY="Accesories;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="LABRAR®"
HOMEPAGE="https://www.win-rar.com/"
LOGO="https://i.imgur.com/IX5pv1c.png"
BANNER="https://i.imgur.com/XzPLBfB.png"
 
#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Download image manual
mkdir -p "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

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
# Compressor AAZ
# if [ ! -f "$HOME/.local/bin/aaz" ]; then
#   POL_Download_Resource "https://archive.org/download/DLL-POL/aaz.sh" "53551e6e55190e7613a69eb76f32ceef" "aaz"
#   mkdir -p "$HOME/.local/bin"
#   cp "$POL_USER_ROOT/ressources/aaz/aaz.sh" -d "$HOME/.local/bin/aaz"
#   chmod +x "$HOME/.local/bin/aaz"
# fi

# Script start
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"

  # Download List
  mkdir -p "$POL_USER_ROOT/ressources/list/"
  rm -f "$POL_USER_ROOT/ressources/list/$PREFIX.lst"
  wget --header="User-Agent: Mozilla/5.0" -qO "$POL_USER_ROOT/ressources/list/$PREFIX.lst" "https://archive.org/download/Resources-POL/List%20URL/$PREFIX.lst"

  # Charge list
  source "$POL_USER_ROOT/ressources/list/$PREFIX.lst"

  # [GuerreroAzul] List of versions
  POL_SetupWindow_menu "$(eval_gettext 'Select the version you want to install'):" "$TITLE" "$LISTVERSION" " "

  LANGUAGE=${LANG%%_*}
  VERSION_A="${APP_ANSWER}${LANGUAGE}"

  if [ -n "${LISTURL[$VERSION_A]}" ]; then
    URL=$(echo ${LISTURL[$VERSION_A]} | cut -d" " -f1)
    MD5URL=$(echo ${LISTURL[$VERSION_A]} | cut -d" " -f2)
    FILE=${URL##*/}
  else
    VERSION_B="${APP_ANSWER}en"
    URL=$(echo ${LISTURL[$VERSION_B]} | cut -d" " -f1)
    MD5URL=$(echo ${LISTURL[$VERSION_B]} | cut -d" " -f2)
    FILE=${URL##*/}
  fi

  POL_Wine_WaitBefore "$PREFIX"
  wget -q "$URL" -O "$POL_USER_ROOT/ressources/$PREFIX/$FILE"

  echo -e 'RAR registration data
    IVTeam
    Unlimited Company License
    UID=cc6ce144d42ff154d715
    6412212250d715229ef289a3094aa9acd3a3983c432baad83014cf
    c8c34fafc920c907f20d60fce6cb5ffde62890079861be57638717
    7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565
    b41bcf56929486b8bcdac33d50ecf773996001b3489abc38c54ced
    3194efcf538fd47f999a76ba67115c6c73235e9217d24f2eb99824
    eb3588ca1ee0a605bf67a9a506011547ec936ab7a5669a0c606989
    c820ab519d807fe51bb3060dcb35ae0ac8874ae6630e0770417431' > "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$PREFIX/rarreg.key"
  #POL_Download_Resource "$URL" "$MD5URL" "$PREFIX"
  INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/$FILE"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
  FILE=$(echo "$INSTALLER" | rev | cut -d'/' -f1 | rev)
fi
 
# Install Program
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_Wine start /unix "$INSTALLER" /S
  POL_Wine_WaitExit "$INSTALLER"
else
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$INSTALLER"
fi
 
# Shortcut 
POL_Shortcut "$PREFIX.exe" "$TITLE" "" "" "$CATEGORY"
POL_Extension_Write rar "$TITLE"
POL_Extension_Write zip "$TITLE"
POL_Extension_Write 7z "$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
