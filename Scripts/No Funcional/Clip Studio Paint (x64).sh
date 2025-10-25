#!/usr/bin/env playonlinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: GNU General Public License v3.0

# CHANGELOG

# [GuerreroAzul] 2025-10-21 19:12 (UTC -06-00) / Wine 9.0 / Linux Mint 22.2 x86_64 xfce
#   Script version: 1.0.0 (Creation of the script)
#   wine: 6.17
#   version OS: Windows 10
#   Category: Graphics; Photos;
#   References
#     Documentation POL: https://www.playonlinux.com/en/app-4989-Clip_Studio_Paint.html
#     Download Link: https://www.clipstudio.net/en

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Clip Studio Paint"
PREFIX="CSP"
CATEGORY="Graphics; Photos;"
WINEVERSION="8.1-staging"
ARCHITECTURE="amd64"
OSVERSION="win10"
EDITHOR="GuerreroAzul"
COMPANY="Celsys, Inc."
HOMEPAGE="https://www.clipstudio.net/"
LOGO="https://i.imgur.com/viNXMfj.png"
BANNER="https://i.imgur.com/GER3NsH.png"


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
POL_System_SetArch "$ARQUITECTURE"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# Dependencies
# Distributed Component Object Model (Windows 98)
POL_Download_Resource "https://web.archive.org/web/20080222203526if_/http://download.microsoft.com/download/d/1/3/d13cd456-f0cf-4fb2-a17f-20afc79f8a51/DCOM98.EXE" "9a7bc7ff37168217123a5e28aadef897" "dcom98"
Set_OS "win98"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dcom98/DCOM98.EXE" /Q
POL_Wine_WaitExit "Distributed Component Object Model (Windows 98)"
Set_OS "$OSVERSION"

# Microsoft XML Parser 3.0 
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20XML%20Core%20Services/3.0/msxml3.msi" "7049c6531837341363fe69d068d001b0" "msxml3"
POL_Wine msiexec /i "$POL_USER_ROOT/ressources/msxml3/msxml3.msi" /q
POL_Wine_WaitExit "Microsoft XML Parser 3.0"

# Microsoft XML Core Services 6.0
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20XML%20Core%20Services/6.0/msxml6_x64.zip" "118dc670ace3533efd5733ae41f32370" "msxml6"
POL_System_unzip "$POL_USER_ROOT/ressources/msxml6/msxml6_x64.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/msxml6"
POL_Wine msiexec /i "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/msxml6/msxml6_x64.msi" /q
POL_Wine_WaitExit "Microsoft XML Core Services 6.0"

# Microsoft Edge WebView2
RUNTIME_PATH="$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files (x86)/Microsoft/EdgeWebView/Application"
POL_Download_Resource "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/454b3964-bfe5-4eff-82da-74c3125b592b/Microsoft.WebView2.FixedVersionRuntime.141.0.3537.99.x64.cab" "c95824219dd1c613e1e8b6e40ece9caa" "webview2"
POL_Wine_WaitBefore "Microsoft Edge WebView2"
cabextract -d "$RUNTIME_PATH" "$POL_USER_ROOT/ressources/webview2/Microsoft.WebView2.FixedVersionRuntime.141.0.3537.99.x64.cab"
# Organizing files
if [ -d "$RUNTIME_PATH/Microsoft.WebView2.FixedVersionRuntime.141.0.3537.99.x64" ]; then
  POL_Wine_WaitBefore "Microsoft Edge WebView2"
  mv "$RUNTIME_PATH/Microsoft.WebView2.FixedVersionRuntime.141.0.3537.99.x64" "$RUNTIME_PATH/141.0.3537.99"
fi

# Microsoft Fonts
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Fonts/Fonts.zip" "a9669ee3387be9d3bc504eb799723799" "Fonts"
POL_System_unzip "$POL_USER_ROOT/ressources/Fonts/Fonts.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/"

# DirectX End-User Runtimes (June 2010)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20DirectX%20End-User%20Runtime/29.9.1974.1%20%28June%202010%29/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4" "DirectX-2010.06"
POL_Wine start /unix "$POL_USER_ROOT/ressources/DirectX-2010.06/directx_Jun2010_redist.exe" /Q /T:"C:/users/$USER/Temp/directx_Jun2010_redist"
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"
POL_Wine --ignore-errors "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/users/$USER/Temp/directx_Jun2010_redist/DXSETUP.exe" &>/dev/null
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"

# Microsoft Visual C++ Redistributable (2015-2022)
# POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/Visual%20Studio%202015-2022/VC_redist.x86.exe"  "99f52708b06b9c695a8d64a44740bf08" "vcrun2022"
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/Visual%20Studio%202015-2022/VC_redist.x64.exe" "486f81facf798678c3244c7cf35a557f" "vcrun2022"
POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2022/vc_redist.x64.exe" /quiet
POL_Wine_WaitExit "Microsoft Visual C++ Redistributable (2015-2022)"

# Select mode install
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_Download_Resource "https://vd.clipstudio.net/clipcontent/paint/app/414/CSP_414w_setup.exe" "66b99b4f52860e1be8cace0b1a1f39e1" "$PREFIX"
  INSTALLER="$POL_USER_ROOT/ressources/$PREFIX/CSP_414w_setup.exe"

  POL_Wine start /unix "$INSTALLER"
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
POL_Shortcut "CLIPStudioPaint.exe" "$TITLE" "" "" "$CATEGORY"
POL_Extension_Write cst "$TITLE"
POL_Extension_Write csnf "$TITLE"

# Update icon
# wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
# wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0