#!/usr/bin/env playonlinux-bash

# Date : See changelog.
# Last revision : See changelog.
# Wine version used : 2.22
# Distribution used to test : 
# Author : Tr4sK & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [GuerreroAzul] 2025-10-03 21-21 (UTC -06-00) / Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Version: 1.0.2
#   Add Category: Games
#   Update Wine Version: 2.22 --> 9.0
#   Add OS Version: Windows 7
#   Add Company, HomePage, Logo And Banner
#   Inactive GAME_VMS, POL_Install_steam
#   Add Dependencies: AAZ, DirectX End-User Runtimes (June 2010)
# [Dadu042] (2019-10-05) / Wine 2.22
#   Wine 1.7.35 -> 2.22
# [Tr4sK or GNU_Raziel] (2009-05-23 14-30) / Wine 1.7.35 / Kubuntu 18.04 x64
#   First script.

# REFERENCE
# [GuerreroAzul] 2025-10-03 21-21 (UTC -06-00)
# Documentation POL: https://www.playonlinux.com/en/app-79-Grand_Theft_Auto__San_Andreas.html
# Icon Shortcut: https://libertycity.net/files/gta-san-andreas/10206-icons.html
# Credits Mods: https://www.youtube.com/watch?v=nOj2q_YGgj4


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Grand Theft Auto San Andreas"
PREFIX="GTASA"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="Tr4sK or GNU_Raziel \nDadu042 And GuerreroAzul"
COMPANY="Rockstar Games"
HOMEPAGE="https://www.rockstargames.com/games/sanandreas"
LOGO="https://i.imgur.com/Y7und33.png"
BANNER="https://i.imgur.com/ZSIaYgZ.png"

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
  # Download
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive01.aaz" "bff678a87e7d3c14b564e46ce2fbea01" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive02.aaz" "a4b33832205cb3993eb76eb6e0306a3c" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive03.aaz" "900e2da840f26ff5506f44e7a7cdcade" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive04.aaz" "037bd1bf2a29e3e86c35db30a77450e8" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive05.aaz" "a63f5cebc6d199c225c7195e212dbaf7" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive06.aaz" "bb243505d58aa231ae82236d35c49253" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive07.aaz" "ae496038b42a7c9c9135872fb29ce25a" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive08.aaz" "e0a8660620631a2926dd81dea0e8f731" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive09.aaz" "b1728ceff4c834d1aa71e4a6dad5a688" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive10.aaz" "90598af5ec4fdfec3788f17dc9a7e58a" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive11.aaz" "c50f5b30a1b09713a9265b0e823645d6" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive12.aaz" "b2acf59ef5209977c3fcb41b87173eb8" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive13.aaz" "a1d83f73b7d6106a090232c1f67409c6" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive14.aaz" "9b6f6855fd11b7e69ae7910b8d4e263e" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive15.aaz" "7798c40edc09e8b154a15ed126c69708" "$PREFIX"
  POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/archive16.aaz" "f4a84c593c333a3454b76eb9456b23be" "$PREFIX"

  # Unzip program
  for i in $(seq -w 1 16); do
    POL_Wine_WaitBefore "$TITLE - ${i}"
    aaz x "$POL_USER_ROOT/ressources/$PREFIX/archive${i}.aaz" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$PREFIX"
  done

# Install CD/DVD
elif [ "$INSTALL_METHOD" = "DVD" ]; then
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "setup.exe" "SETUP.EXE"
  INSTALLER="$CDROM/SETUP.EXE"
  cd "$CDROM"

  # Install Program
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$TITLE"

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
fi

# Install mods
POL_SetupWindow_question "$(eval_gettext 'Want to install mod?')" "$TITLE"
elif [ "$APP_ANSWER" = "TRUE" ]; then
  POL_SetupWindow_question "$(eval_gettext 'Do you want to install all mods? \n\nThese are the following mods to install:\n
  ➛ SA Essentials Pack\n')" "$TITLE"
  
  elif [ "$APP_ANSWER" = "TRUE" ]; then
    LISTMOD="SA Essentials Pack"
  else
    if command -v zenity &>/dev/null; then
      LISTMOD=$(zenity --list --checklist \
      --title="Install Mods" \
      --text="Select the mods to install"\
      --column="" --column="Mods" \
      FALSE "SA Essentials Pack" \
      --separator=", " \
      --width=400 --height=300)
    else
      wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install zenity to install mods.')" "$TITLE!"
    fi
  fi

  # SA Essentials Pack
  # URL: https://www.mixmods.com.br/2019/06/sa-essentials-pack/
  if [[ "$LISTMOD" == *"SA Essentials Pack"* ]]; then
    POL_Download_Resource "https://archive.org/download/Game-POL/Grand%20Theft%20Auto%20San%20Andreas/Mods/SA_Essentials_Pack.aaz" "3c6ba8d91db10c5579ee17d45e665b17" "GTASA_MODS"
    aaz x "$POL_USER_ROOT/ressources/GTASA_MODS/SA_Essentials_Pack.aaz" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/$PREFIX"
  fi

fi


# Shortcut
POL_Shortcut "gta_sa.exe" "$TITLE" "" "" "$CATEGORY"
POL_Shortcut_QuietDebug "$TITLE"

# Update icon
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 32x32! "$POL_USER_ROOT/icones/32/$TITLE"
wget --header="User-Agent: Mozilla/5.0" "$LOGO" -O "$POL_USER_ROOT/icones/full_size/$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0