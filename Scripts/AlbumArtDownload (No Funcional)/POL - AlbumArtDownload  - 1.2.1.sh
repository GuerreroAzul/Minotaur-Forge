#!/usr/bin/env PlayOnLinux-Bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerreroAzul] 2024-08-21 08-05 (UTC -06-00)
#   Script version: 1.2.1
#   Wine Version: 4.15 -> 9.0
#   System version: win7 -> win11
#   REFERENCE:
#     GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-4586-Album_Art_Downloader.html
#     GuerreroAzul: Link Download. - https://sourceforge.net/projects/album-art/files/album-art-xui/
# [GuerrreroAzul] (2023-11-10) Wine 4.15 x32 / Linux Mint 21.2 x86_64
#   Script version: 1.1.1
#   Wine Version: 4.15
#   System version: win7 
 

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variable
Title="Album Art Downloader"
Prefix="AlbumArtDownloader"
Category="Graphics;"
WineVersion="9.0"
SystemVersion="win11"
Edithor="GuerreroAzul"
Company="alexvallat, marclandis"
OfficialSite="https://sourceforge.net/projects/album-art/"
Logo="https://i.imgur.com/cTK36L8.png"
Banner="https://i.imgur.com/ba7r3Zz.png"
DownloadSoftware="https://phoenixnap.dl.sourceforge.net/project/album-art/album-art-xui/AlbumArtDownloaderXUI-1.05.exe 830c050655ea9bf3075acf71cf9d0f34"
FileSetup="AlbumArt.exe"
  
# Setup Image
POL_GetSetupImages "$Logo" "$Banner" "$Title"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
# Welcome message
POL_SetupWindow_presentation "$Title" "$Company" "$OfficialSite" "$Edithor" "$Prefix"
 
# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"
 
# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$Title!"
fi
 
# Prepare resources for installation!
POL_Wine_SelectPrefix "$Prefix"
POL_Wine_PrefixCreate "$WineVersion"
Set_OS "$SystemVersion"
 
#Dependencies
POL_Call POL_Install_vcrun2008
 
#Install .Net Framework 4.7.2
# DOWNLOAD_NET="https://download.visualstudio.microsoft.com/download/pr/1f5af042-d0e4-4002-9c59-9ba66bcf15f6/124d2afe5c8f67dfa910da5f9e3db9c1/ndp472-kb4054531-web.exe"
# MD5_NET="b3844d880d71de6d787190d2e378101b"
# NET="ndp472-kb4054531-web.exe"
 
# POL_System_TmpCreate "$PREFIX"
# cd "$POL_System_TmpDir"
 
# POL_Download "$DOWNLOAD_NET" "$MD5_NET"
# NET_FRAMEWORK="$POL_System_TmpDir/$NET"
 
# POL_Wine start /unix "$NET_FRAMEWORK"
# POL_Wine_WaitExit "$NET_FRAMEWORK"
# POL_Wine_OverrideDLL "native" "mscoree"
# POL_Wine_reboot
  
# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$Prefix"
  cd "$POL_System_TmpDir"

  DownloadLink=$(echo ${DownloadSoftware} | cut -d" " -f1)
  FingerPrint=$(echo ${DownloadSoftware} | cut -d" " -f2)
  FileSoftware=${DownloadLink##*/}
  
  POL_Download "$DownloadLink" "$FingerPrint"
  Installer="$POL_System_TmpDir/$FileSoftware"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  Installer="$APP_ANSWER"
  FileSoftware=$(echo "$Installer" | rev | cut -d'/' -f1 | rev)
fi
 
# Install Program
POL_Wine start /unix "$Installer" /S
POL_Wine_WaitExit "$Installer"

# Shortcut
POL_Shortcut "$FileSetup" "$Title" "" "" "$Category"
 
#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
