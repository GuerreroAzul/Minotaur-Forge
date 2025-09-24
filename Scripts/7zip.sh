#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: thib25 & Tutul (update) && andykimpe (update)
License: Retail
 
CHANGELOG
[GuerrreroAzul] (2025-08-27 11-32 GMT-6) / Linux Mint 22.1 x86_64
  Added the following features:
    + Wine version 5.0.2 -> 9.0
    + System version: Windows 10
    + Category: Accesories
[SuperPlumus] (2014-12-25 11-59)
  Update Wine version 1.3.5 -> System
  Update 7-Zip version 4.65 -> 9.20
  Update messages
  Change title and prefix names
[SuperPlumus] (2014-12-25 11-59)
  Clean code
[p-90-for-retail] (2018-3-3 18-26)
  Update 7-Zip version 9.20 -> 18.01
[Yaotl] (2020-8-4 00-59)
  Update System Wine -> 5.0.1
  Update 7-Zip version 18.01 -> 19.00
  Change Optimize code
  Change Add local installation option
[Dadu042] (2020-09-22 15-00)
  Update System Wine 5.0.1 -> 5.0.2
  Add POL_Shortcut category
 
REFERENCE
[GuerreroAzul]
Documentation POL: https://www.playonlinux.com/en/app-373-7Zip.html
Link Download: https://sourceforge.net/projects/sevenzip/
Icon: https://www.deviantart.com/fediafedia/art/New-7-zip-Icon-107528914
'
        
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setting
TITLE="7-zip"
PREFIX="7zip"
CATEGORY="Accesories"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="thib25 \nTutul, andykimpe And GuerreroAzul"
COMPANY="Igor Pavlov"
HOMEPAGE="https://www.7-zip.org/"
LOGO="https://i.imgur.com/ePALeUA.png"
BANNER="https://i.imgur.com/ba7r3Zz.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

# Setup Images
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
 
# Install Dependencies
# ...

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_Download_Resource "https://www.7-zip.org/a/7z2501.msi" "bb7887fa47672e39fc8531aec885706b" "$PREFIX"
    INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/7z2501.msi"
else
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
fi
 
# Install Program
cd $WINEPREFIX
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Shortcut
POL_Shortcut "7zFM.exe" "$TITLE" "" "" "$CATEGORY;"
POL_Shortcut_QuietDebug "$TITLE"

POL_Extension_Write 7z "$TITLE"
POL_Extension_Write zip "$TITLE"
POL_Extension_Write rar "$TITLE"
POL_Extension_Write "001" "$TITLE"
POL_Extension_Write cab "$TITLE"
POL_Extension_Write iso "$TITLE"
POL_Extension_Write xz "$TITLE"
POL_Extension_Write txz "$TITLE"
POL_Extension_Write lzma "$TITLE"
POL_Extension_Write tar "$TITLE"
POL_Extension_Write cpio "$TITLE"
POL_Extension_Write bz2 "$TITLE"
POL_Extension_Write bzip2 "$TITLE"
POL_Extension_Write tbz2 "$TITLE"
POL_Extension_Write tbz "$TITLE"
POL_Extension_Write gz "$TITLE"
POL_Extension_Write gzip "$TITLE"
POL_Extension_Write tpz "$TITLE"
POL_Extension_Write zst "$TITLE"
POL_Extension_Write tzst "$TITLE"
POL_Extension_Write z "$TITLE"
POL_Extension_Write taz "$TITLE"
POL_Extension_Write lzh "$TITLE"
POL_Extension_Write lha "$TITLE"
POL_Extension_Write rpm "$TITLE"
POL_Extension_Write deb "$TITLE"
POL_Extension_Write erj "$TITLE"
POL_Extension_Write vhd "$TITLE"
POL_Extension_Write vhdx "$TITLE"
POL_Extension_Write wim "$TITLE"
POL_Extension_Write swm "$TITLE"
POL_Extension_Write esd "$TITLE"
POL_Extension_Write fat "$TITLE"
POL_Extension_Write ntfs "$TITLE"
POL_Extension_Write dmg "$TITLE"
POL_Extension_Write hfs "$TITLE"
POL_Extension_Write xar "$TITLE"
POL_Extension_Write squashfs "$TITLE"
POL_Extension_Write apfs "$TITLE"

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0