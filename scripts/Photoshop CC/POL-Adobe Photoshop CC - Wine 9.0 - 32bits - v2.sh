#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
Script licence : GPL3
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-03-12 14:00 GMT-6) Wine 9.0 / Linux Mint 21.3 x86_64
  Version software: Adobe Photoshop CC 14.0
  Update version wine: 3.20 --> 9.0
  Add version OS: win10
  Code: Code ordering for better understanding and improving loading times.
[Ronin Dusette] (2014-10-20)
  First script.
[Dadu042] (2019-05-20)
  Change Wine version (easier for newbies, because 4.0 is the latest available from POL 4.2.12)
  Warn POL version.
[Dadu042] (2019-05-17)
  Wine 4.0 -> 3.21 (I fix my mistake because POL 4.2.12 does not support Wine 4)
[Dadu042] (2019-11-28)
  Standardize Changelog.
  POL_RequiredVersion 4.2.12 (support Wine 3.0.3 max) -> 4.3.4
  Remove useless msxml3 (because msxml6 is also installed).
  Fix app categories.
[Dadu042] (2020-02-01 11:00)
  Wine 3.21 -> 3.20 (I fix my mistake because POL 4.2.x does not support Wine v3.21)
  POL_RequiredVersion 4.3.4 -> 4.1.0
  Standardize POL_Install_AdobeAir

REFERENCE
GuerreroAzul: Documentation Ref.
  https://www.playonlinux.com/en/app-2316-Adobe_Photoshop_CS6.html
  https://www.playonlinux.com/en/app-2582-Adobe_Photoshop_CC_2014.html
GuerreroAzul: Link Download. - https://www.adobe.com/products/photoshop.html
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Adobe Photoshop 2014"
PREFIX="AdobePhotoshop"
CATEGORY="Graphics;RasterGraphics;"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="Dadu042, Ronin Dusette, Vladislav Khomenko and GuerreroAzul"
COMPANY="Adobe Systems Inc."
HOMEPAGE="https://www.adobe.com"
LOGO="http://files.playonlinux.com/resources/setups/PhotoshopCS6/top.jpg"
BANNER="http://files.playonlinux.com/resources/setups/PhotoshopCS6/left.jpg"

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
POL_Call POL_Install_atmlib
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB
    
# Installation Adobe Air
POL_Call POL_Install_AdobeAir

# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Shortcut 
POL_Shortcut "photoshop.exe" "$TITLE" "" "" "$CATEGORY"
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
