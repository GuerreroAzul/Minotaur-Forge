#!/usr/bin/env playonLinux-bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Tiago Arnold "contato@radaction.com.br"
# Contributor: RainPedia, Dadu042, Varlyakov And GuerrreroAzul
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerreroAzul] 2024-08-16 13-03 (UTC -06-00)
#   Script version: 1.7.1
#   Update software version: 3.40 -> 3.41
#   Update system version: win10 -> win11
# [GuerreroAzul] 2024-04-26 10:50 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 21.3 x86_64
# The following features have been updated:
#   Wine version: 3.0.3 - 9.0
#   Link download: Link version 3.0 to 3.40
# Added the following features: 
#   Category: Network
#   System version: Windows 10
# Reference
#   Documentation: https://www.playonlinux.com/en/app-3035-Winbox.html
#   Link Download: https://mikrotik.com/download
#
# [Varlyakov] 2022-06-14 22:17 / Wine 3.0.3 x86
# The following features have been updated:
#   Link download: https://download.mikrotik.com/winbox/3.36/winbox.exe / MD5: ae0b5a345570a1317798d5b4bf61b012
# 
# [Dadu042] 2022-04-01 / Wine 3.0.3 x86
# The following features have been updated:
#   Wine version 3.0 -> 3.0.3
#
# [RainPedia] 2022-04-02 / Wine 3.0 x86
# The following features have been updated:
#   Wine version 1.6.2 -> 3.0
#   Link download: https://download.mikrotik.com/winbox/3.35/winbox.exe / MD5: 9473cfce0061b0853801a283c8d87a79
#
# [Tiago Arnold] 2016-09-13 21:27 / Wine 1.6.2 x86 / Ubuntu 16.04 LTS
# [contato@radaction.com.br] 
# Script creation:
#   Wine version: 1.6.2
#   System version: Windows XP
#   Architecture: 32bits
# Reference
#   Link Download: Link download: http://download2.mikrotik.com/routeros/winbox/3.13/winbox.exe / MD5: 5d97cafd31963ab6360c9b056f6ba26b825a4a2f

# Start script
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
Title="WinBox"
Prefix="winbox"
Category="Network;"
WineVersion="9.0"
SystemVersion="win11"
Edithor="\nTiago Arnold \"contato@radaction.com.br\" \nRainPedia, Dadu042, Varlyakov And GuerrreroAzul"
Company="Mikrotik"
OfficialSite="https://www.mikrotik.com/"
Logo="https://imgur.com/mtBHg4G.png"
Banner="https://imgur.com/l0WtSka.png"
declare -A DownloadSoftware=( 
[3.41]="https://download.mikrotik.com/routeros/winbox/3.41/winbox.exe ecd682ad1a7b6f5ea1ef40fd22f543d5"
[3.40]="https://download.mikrotik.com/routeros/winbox/3.40/winbox.exe 6f9c00d718608cf18e42f617bc9d8e04"
[3.39]="https://download.mikrotik.com/routeros/winbox/3.39/winbox.exe 96bff72a6f8cc57a60d4414f7c85f110"
[3.38]="https://download.mikrotik.com/routeros/winbox/3.38/winbox.exe 70aeaee6be7806c1ea830f9b9ef61bbc"
[3.37]="https://download.mikrotik.com/routeros/winbox/3.37/winbox.exe 0fc726908853b7678e59a1fe20e02b84"
[3.36]="https://download.mikrotik.com/routeros/winbox/3.36/winbox.exe ae0b5a345570a1317798d5b4bf61b012"
[3.35]="https://download.mikrotik.com/routeros/winbox/3.35/winbox.exe 9473cfce0061b0853801a283c8d87a79"
[3.34]="https://download.mikrotik.com/routeros/winbox/3.34/winbox.exe 1d20f03f826a30d702abf842e92ca861"
[3.33]="https://download.mikrotik.com/routeros/winbox/3.33/winbox.exe afaf7baa9daeca11ff460a3f14daa550"
[3.32]="https://download.mikrotik.com/routeros/winbox/3.32/winbox.exe 1a40c3f362d7f068d2a744b541e6c887"
[3.31]="https://download.mikrotik.com/routeros/winbox/3.31/winbox.exe e06012e3ad5c62c8682b8ee720b11e00"
[3.30]="https://download.mikrotik.com/routeros/winbox/3.30/winbox.exe 304cd68c19e24288f2cbdd93ae07cb60"
[3.29]="https://download.mikrotik.com/routeros/winbox/3.29/winbox.exe 4d7ca878c9980484c552e684a3e175a1"
[3.28]="https://download.mikrotik.com/routeros/winbox/3.28/winbox.exe d6b53ece8c20cf28f16303c1e79bd51c"
[3.27]="https://download.mikrotik.com/routeros/winbox/3.27/winbox.exe db78a2a9e57ad5d816076dec38e6e835"
[3.26]="https://download.mikrotik.com/routeros/winbox/3.26/winbox.exe 099e5f53909702bfa9bff2215bd466d8"
[3.25]="https://download.mikrotik.com/routeros/winbox/3.25/winbox.exe 7b4b98876b8f605576104352365b3566"
[3.24]="https://download.mikrotik.com/routeros/winbox/3.24/winbox.exe dc428a1ddfdf662a7e5d19d345b01c7d"
[3.23]="https://download.mikrotik.com/routeros/winbox/3.23/winbox.exe 80ed7311b5ef826e96720a124cb52217"
[3.22]="https://download.mikrotik.com/routeros/winbox/3.22/winbox.exe efbcfe5ae1239af74998956e355243eb"
[3.21]="https://download.mikrotik.com/routeros/winbox/3.21/winbox.exe 7fcefebd214656dfd9ceac65d9fc2712"
[3.20]="https://download.mikrotik.com/routeros/winbox/3.20/winbox.exe 349006b674c3ac6699a666a516fc752a"
[3.19]="https://download.mikrotik.com/routeros/winbox/3.19/winbox.exe 8bdd4dc75d8d47e0b76db4ad182fe8a1"
[3.18]="https://download.mikrotik.com/routeros/winbox/3.18/winbox.exe fe0a8fb59460f41c5a2a1ca6d5e6729d"
[3.17]="https://download.mikrotik.com/routeros/winbox/3.17/winbox.exe e3aced288f0eb4ef429e4aed5a7acadc"
[3.16]="https://download.mikrotik.com/routeros/winbox/3.16/winbox.exe 2741dab2fba3e1ec6fd703d5e4973491"
[3.15]="https://download.mikrotik.com/routeros/winbox/3.15/winbox.exe eec6f5986afaaad3047c3dc5d8ed95a0"
[3.14]="https://download.mikrotik.com/routeros/winbox/3.14/winbox.exe 4990532aa3173ac226ac86619bab009b"
[3.13]="https://download.mikrotik.com/routeros/winbox/3.13/winbox.exe 613143f7a48a725b8227c4caccbddf63"
[3.12]="https://download.mikrotik.com/routeros/winbox/3.12/winbox.exe 6c707302f2a07f3a5167a49cb654656d"
[3.11]="https://download.mikrotik.com/routeros/winbox/3.11/winbox.exe f3a5f5bd15d234fa1465dccc8971b92a"
[3.10]="https://download.mikrotik.com/routeros/winbox/3.10/winbox.exe 42b860cbbce4143d37410494d1afbb14"
[3.9]="https://download.mikrotik.com/routeros/winbox/3.9/winbox.exe 8c2581b36efb107ab52b545e6f49e3ae"
[3.8]="https://download.mikrotik.com/routeros/winbox/3.8/winbox.exe ddf4d6b9dfd1b7966799300f5f4fe2cc"
[3.7]="https://download.mikrotik.com/routeros/winbox/3.7/winbox.exe 01537f7121c5202e4b79980bbfbf331d"
[3.6]="https://download.mikrotik.com/routeros/winbox/3.6/winbox.exe 8a46c8e33fe97eb4be02439ad40332c0"
[3.5]="https://download.mikrotik.com/routeros/winbox/3.5/winbox.exe 3ea43a0b21c271870301e4801bcb1d97"
[3.4]="https://download.mikrotik.com/routeros/winbox/3.4/winbox.exe 946bb6e015bd6e70b4a68608e3c3c5ab"
[3.3]="https://download.mikrotik.com/routeros/winbox/3.3/winbox.exe bdf2fbb062826ee99c5afaddd4d982a2"
[3.2]="https://download.mikrotik.com/routeros/winbox/3.2/winbox.exe 46581edcd82914d721ffe52ef5e00f90"
[3.1]="https://download.mikrotik.com/routeros/winbox/3.1/winbox.exe 994bae2a3a26ba16536c3e991eba2c08"
[3.0]="https://download.mikrotik.com/routeros/winbox/3.0/winbox.exe 7a72d69c27657f660b8b6a4af1473158"
)
RecommendedVersion="3.41"
SoftwareVersion="3.40 
3.39 3.38 3.37 3.36 3.35 3.34 3.33 3.32 3.31 3.30 
3.29 3.28 3.27 3.26 3.25 3.24 3.23 3.22 3.21 3.20 
3.19 3.18 3.17 3.16 3.15 3.14 3.13 3.12 3.11 3.10 
3.9 3.8 3.7 3.6 3.5 3.4 3.3 3.2 3.1 3.0"

# Setup Image
POL_SetupWindow_setImages "$Logo" "$Banner" "$Title"
 
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
POL_Call POL_Install_corefonts
 
# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$Prefix"
  cd "$POL_System_TmpDir"
 
  # [GuerreroAzul] List of WinBox versions
  POL_SetupWindow_menu "$(eval_gettext 'Select the version you want to install'):" "$Title" "$RecommendedVersion (Recommended) | Select another version" " | "
  if [ "$APP_ANSWER" = "Select another version"]; then
    POL_SetupWindow_menu "$(eval_gettext 'Select the version you want to install'):" "$TITLE" "$SoftwareVersion" " "
    DownloadLink=$(echo ${DownloadSoftware[$APP_ANSWER]} | cut -d" " -f1)
    FingerPrint=$(echo ${DownloadSoftware[$APP_ANSWER]} | cut -d" " -f2)
    FileSoftware=${DownloadLink##*/}
  else
    DownloadLink=$(echo ${DownloadSoftware[$RecommendedVersion]} | cut -d" " -f1)
    FingerPrint=$(echo ${DownloadSoftware[$RecommendedVersion]} | cut -d" " -f2)
    FileSoftware=${DownloadLink##*/}
  fi

  POL_Download "$DownloadLink" "$FingerPrint"
  Installer="$POL_System_TmpDir/$FileSoftware"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  Installer="$APP_ANSWER"
  FileSoftware=$(echo "$Installer" | rev | cut -d'/' -f1 | rev)
fi
 
# Install Program
mkdir -p "$WINEPREFIX/drive_c/Program Files/$Prefix/"
cp "$Installer" -d "$WINEPREFIX/drive_c/Program Files/$Prefix/"
 
# Shortcut
POL_Shortcut "$FileSoftware" "$Title" "" "" "$Category"
 
# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
