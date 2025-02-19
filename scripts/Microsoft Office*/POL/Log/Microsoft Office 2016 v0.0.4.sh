#!/usr/bin/env PlayOnLinux-Bash
# Date: (2020-09-12 13:25)
# Last revisio: (2023-12-15 14:00)
# Wine version used: 7.0-rc5
# Distribution used to test: Ubuntu 20.04; Linux Mint 21.2 x86_64 
# Author: Quentin Pâris, Eduardo Lucio and N0rbert, GuerreroAzul, Dingo35
   
# ---------------------------------------------------------------------------------------------------------
   
# CHANGELOG
# Version 0.0.1 by N0rbert - with Wine 3.0 it crashes on Welcome screen when trying
# to call "unimplemented function KERNEL32.dll.FindNLSStringEx called in 32-bit code"
# So we need Wine 3.4+ here, but I can't run this script with it on my Ubuntu 16.04 LTS.
#
# based on Version 1.1.0.0 [Quentin Pâris and Eduardo Lucio (Questor)] (2018-02-17 15-24) - Paris/Brazil
# for office2007pro (playonlinux://www.playonlinux.com/repository/download.php?id=2665)
#
# Version 0.0.2 by Dingo35 - riched20 and msxml6 need to be installed before the installer is called;
# added automated file copies; added code to close stuck window; tested script with script_checker.sh
#   
# Version 0.0.3 by Dingo35 - some small code beautifying; removed winetricks check because winetricks is
# not needed by POL_Call POL_Install; moved the check for 64bits setup to correct place
#
# Version 0.0.4 By GuerreroAzul - Not Funcional (Testing of Installation)

# ---------------------------------------------------------------------------------------------------------
   
# Under BSD License!
   
# Copyright (c) 2018, Quentin Pâris, Eduardo Lucio and N0rbert, GuerreroAzul
# All rights reserved.
   
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the free software community nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
   
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Quentin Pâris and Eduardo Lucio BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   
# ---------------------------------------------------------------------------------------------------------
   
# NOTE: Complete liste of references! By Questor
# https://github.com/PlayOnLinux/POL-POM-4/blob/master/lib/wine.lib
# https://www.playonlinux.com/en/app-2665-Microsoft_Office_2016.html
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_11:_List_of_Functions
# http://wiki.playonlinux.com/index.php/Components_and_Functions
# https://www.playonlinux.com/repository/source.php?script=822
# https://github.com/PlayOnLinux/POL-POM-4/blob/367e50865168b5b931611fa33b0c1d8426143a90/lib/scripts.lib
# https://github.com/PlayOnLinux/POL-POM-4/blob/367e50865168b5b931611fa33b0c1d8426143a90/lib/wine.lib
# https://askubuntu.com/questions/879304/wine-2-0-says-it-supports-office-2016-how-do-i-actually-install-it
# https://github.com/RobertJames/playonlinux/blob/75ef37523f299255a539a89b63dc87d7afc096d4/template.POL
   
# N0rbert's links:
# https://bugs.winehq.org/show_bug.cgi?id=41911 (really we need Wine 3.4+ to fix FindNLSStringEx errors)
   
#GuerreroAzul Links:
#https://askubuntu.com/questions/975104/how-do-i-install-ms-office-2016-on-playonlinux
#https://www.playonlinux.com/es/app-2665-Microsoft_Office_2013.html
#https://appdb.winehq.org/objectManager.php?sClass=version&iId=34941&iTestingId=111893
#https://www.playonlinux.com/repository/?cat=100
#https://appdb.winehq.org/objectManager.php?sClass=version&iId=34941
#Office version stable: https://www.intercambiosvirtuales.org/software/office-professional-plus-2016-vl-espanol-x86-x64-actualizado-diciembre-2018
#Wine Version: https://www.playonlinux.com/wine/binaries/phoenicis/upstream-linux-x86/PlayOnLinux-wine-8.0-rc2-upstream-linux-x86.tar.gz

# ---------------------------------------------------------------------------------------------------------
   
# Initialization!
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Parameters
TITLE="Microsoft Office 2016"
PREFIX="Office2016"
# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=36804
# WINEVERSION 3.0.1     --> Error DW20.exe; Firstrun.exe;

# By GuerreroAzul: Ref. of wine: https://www.solvetic.com/tutoriales/article/7594-como-instalar-microsoft-office-2016-en-linux/
# WINEVERSION 3.21      --> Error DW20.exe; Firstrun.exe;

# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=37735
# WINEVERSION 4.1       --> GARBAGE
# WINEVERSION 4.2       --> GARBAGE

# WINEVERSION 5.0       --> Does not hand over control to window manager

# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=37735
# WINEVERSION 5.0.1     --> GARBAGE

# WINEVERSION 5.8       --> Not Funcional; closed windows

# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=37735
# WINEVERSION 5.11      --> Not Funcional; closed windows

# WINEVERSION 5.16      --> Gives problems selecting multiple choice boxes (like Account/Update Options)

# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=37735
# WINEVERSION 6.2       --> Not Funcional; closed windows

# By GuerreroAzul: Ref. of wine: https://appdb.winehq.org/objectManager.php?sClass=version&iId=34941
# WINEVERSION 7.0-rc5   --> Error Firstrun.exe
# WINEVERSION 8.0.2     --> There is not instance

# GuerreroAzul:
# WINEVERSION 8.0-rc2   --> Version Developer (94% Installation) --> Error of Installation


WINEVERSION="7.0-rc5"
OSVERSION="win7"

#Source
EDITOR="Quentin Pâris, Eduardo Lucio and N0rbert, GuerreroAzul, Dingo35"
HOMEPAGE="http://www.microsoft.com"
AUTHOR="Microsoft Inc."
ICON="https://i.imgur.com/licFVuF.png"
BANNER="https://i.imgur.com/ff6PkEZ.png"

#Welcome Message  
POL_GetSetupImages "$ICON" "$BANNER" "$EDITOR" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 3064
   
POL_SetupWindow_presentation "$TITLE" "$AUTHOR" "$HOMEPAGE"  "$TITLE" 
POL_Debug_Init

# ---------------------------------------------------------------------------------------------------------
# Select wine
POL_SetupWindow_menu "Select version wine:" "$TITLE" "wine-stable|wine-developer" "|"

if [ "$APP_ANSWER" = "wine-developer" ]; then
    if [ -d "$POL_USER_ROOT/wine/linux-x86/8.0-rc2" ]; then
       WINEVERSION="8.0-rc2"
    else
        WINEVERSION="8.0-rc2"
        POL_Download_Resource "https://www.playonlinux.com/wine/binaries/phoenicis/upstream-linux-x86/PlayOnLinux-wine-8.0-rc2-upstream-linux-x86.tar.gz" "2c80f3f7c921419d135dd942a2ea9842" "wine-8.0-rc2" 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Install wine 8.0-rc2 Developer...')" "$TITLE"
        mkdir -p "$POL_USER_ROOT/wine/linux-x86/8.0-rc2"
        tar -xf "$POL_USER_ROOT/ressources/wine-8.0-rc2/PlayOnLinux-wine-8.0-rc2-upstream-linux-x86.tar.gz" -C "$POL_USER_ROOT/wine/linux-x86/8.0-rc2/"
    fi
fi

# ---------------------------------------------------------------------------------------------------------
# Perform some validations!
POL_RequiredVersion 4.3.3 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION!nPlease update!"
   
#Linux
if [ "$POL_OS" = "Linux" ]; then
    wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE!"
fi
   
#MAC
if [ "$POL_OS" = "Mac" ]; then
    # NOTE: Samba support! By Quentin Pâris
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi
   
POL_Wine_WaitBefore "$TITLE"
[ "$CDROM" ] && cd "$CDROM"
   
POL_System_SetArch "x86"
POL_SetupWindow_InstallMethod "LOCAL,DVD"
if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "x86/setup.exe" "setup.exe"
    SetupIs="$CDROM_SETUP"
    cd "$CDROM"
else
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    SetupIs="$APP_ANSWER"
fi
  
#Validation of 32Bits
if [ ! "$(file $SetupIs | grep 'x86-64')" = "" ]; then
    POL_Debug_Fatal "$(eval_gettext "The 64bits version is not compatible! Sorry!")";
fi

# ---------------------------------------------------------------------------------------------------------
# Prepare resources for installation!  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# By GuerreroAzul: Ref. of library. https://appdb.winehq.org/objectManager.php?sClass=version&iId=34941&iTestingId=111893
# riched20 gdiplus msxml6 mspatcha riched30 dotnet20 dotnet40 mfc100 corefonts

# Library Riched20
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# Library MSXML6
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "msxml6"

# Library .Net Framework 4.0
POL_Call POL_Install_dotnet40

# Fix black windows (added by N0rbert)
POL_Wine_Direct3D "MaxVersionGL" "30002"


# ---------------------------------------------------------------------------------------------------------
# Install!

#By GuerreroAzul: Define the OS again. The libraries changed the configuration.
Set_OS "$OSVERSION"

Set_Managed "Off"
# NOTE: Installs office! By Questor
POL_Wine start /unix "$SetupIs"
#POL_Wine_WaitExit "$TITLE"

# By GuerreroAzul: Pause to monitor the installation
POL_SetupWindow_message "Wait a moment while the installation begins, when the installation is finished press next." "$TITLE"
   
# ---------------------------------------------------------------------------------------------------------
# Prepare resources for applications!
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvSubsystems32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/C2R32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvStream32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
   
# Fix a crash when loading a file
# NOTE: Fix "move and change the window size (maximize/minimize/restore/resize
# etc...) bugs"! By Questor
# [Ref.: https://bugs.winehq.org/show_bug.cgi?id=44552]
#Set_Managed "Off"

# ---------------------------------------------------------------------------------------------------------
# Create shortcuts, entries to extensions and finalize!
   
# NOTE: Create shortcuts! By Questor
POL_Shortcut "WINWORD.EXE" "Microsoft Word 2016" "" "" "Office;WordProcessor;"
POL_Shortcut "EXCEL.EXE" "Microsoft Excel 2016" "" "" "Office;Spreadsheet;"
POL_Shortcut "POWERPNT.EXE" "Microsoft Powerpoint 2016" "" "" "Office;Presentation;"
   
# NOTE: No category for collaborative work? By Quentin Pâris
POL_Shortcut "ONENOTE.EXE" "Microsoft OneNote 2016" "" "" "Network;InstantMessaging;"
   
# NOTE: "Calendar;ContactManagement;"? By Quentin Pâris
POL_Shortcut "OUTLOOK.EXE" "Microsoft Outlook 2016" "" "" "Network;Email;"
   
# NOTE: Add an entry to PlayOnLinux's extension file. If the entry already
# exists, it will replace it! By Questor
# [Ref.: https://github.com/PlayOnLinux/POL-POM-4/blob/master/lib/playonlinux.lib]
POL_Extension_Write doc "Microsoft Word 2016"
POL_Extension_Write docx "Microsoft Word 2016"
POL_Extension_Write xls "Microsoft Excel 2016"
POL_Extension_Write xlsx "Microsoft Excel 2016"
POL_Extension_Write ppt "Microsoft Powerpoint 2016"
POL_Extension_Write pptx "Microsoft Powerpoint 2016"
   
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "Microsoft Word 2016" "source "$POL_USER_ROOT/tools/samba3/init""
    POL_Shortcut_InsertBeforeWine "Microsoft Excel 2016" "source "$POL_USER_ROOT/tools/samba3/init""
    POL_Shortcut_InsertBeforeWine "Microsoft Powerpoint 2016" "source "$POL_USER_ROOT/tools/samba3/init""
    POL_Shortcut_InsertBeforeWine "Microsoft OneNote 2016" "source "$POL_USER_ROOT/tools/samba3/init""
    POL_Shortcut_InsertBeforeWine "Microsoft Outlook 2016" "source "$POL_USER_ROOT/tools/samba3/init""
fi
  
# ---------------------------------------------------------------------------------------------------------
#we get stuck with the Office window that doesn't close....
cd "$POL_USER_ROOT/wineprefix"
POL_SetupWindow_wait_next_signal  "$(eval_gettext 'Killing big white window that is stuck, please wait...')" "$APPLICATION_TITLE"
for prefix in *
do
    export WINEPREFIX="$POL_USER_ROOT/wineprefix/$prefix"
               (POL_Wine_AutoSetVersionEnv
    wineserver -k)
    POL_Debug_Message "Killed $prefix"
done

# ---------------------------------------------------------------------------------------------------------
POL_SetupWindow_Close
exit 0