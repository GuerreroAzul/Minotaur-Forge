#!/usr/bin/env PlayOnLinux-Bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Quentin PÂRIS And Dadu042
# Contributor: GuerreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerreroAzul] 2024-09-05 11-17 (UTC -06-00)
#   Script version: 1.7.1
#   Wine Version: 9.0
#   System version: win7
#   REFERENCE:
#     Documentation POL: 
#       https://appdb.winehq.org/objectManager.php?sClass=application&iId=31
#       Microsoft Office 2007: https://www.playonlinux.com/en/app-436-Microsoft_Office_2007.html https://appdb.winehq.org/objectManager.php?sClass=version&iId=4992
#     Link Download: 
#       Microsoft Office 2007: https://archive.org/details/microsoft-office-2007-sp3 https://archive.org/details/of-2007-is-esp
#       Microsoft Office 2010: https://archive.org/details/office-2010-iso-32b-2021

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variable
Title="Microsoft Office 2007"
Prefix="MS-Office-2007"
Category="Office;"
WineVersion="9.0"
SystemVersion="win7"
Edithor="Quentin PÂRIS, Dadu042 And GuerreroAzul"
Company="Microsoft"
OfficialSite="https://www.microsoft.com"
  
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
# Microsoft .Net Framework 2.0 SP1 32bits
POL_Download_Resource "https://download.microsoft.com/download/0/8/c/08c19fa4-4c4f-4ffb-9d6c-150906578c9e/NetFx20SP1_x86.exe" "c61111d7d62306b997ce7dd04898b1ca" "dotnet20"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet20/NetFx20SP1_x86.exe" /q /norestart 
POL_Wine_WaitExit "Microsoft .Net Framework 2.0 SP1 32bits"

# Microsoft Fonts
POL_Call POL_Install_corefonts

# Riched20
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# MSXML6
POL_Call POL_Install_msxml6

# Script start
POL_SetupWindow_InstallMethod "LOCAL,DVD"
if [ "$INSTALL_METHOD" = "DVD" ]; then
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "setup.exe"
  Installer="$CDROM_SETUP"
  cd "$CDROM"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  Installer="$APP_ANSWER"
fi

# Install Program
POL_Wine start /unix "$Installer"
POL_Wine_WaitExit "$Installer"

# Shortcut
POL_Shortcut "WINWORD.EXE" "Microsoft Office Word 2007" "" "" "Office;"
POL_Shortcut "EXCEL.EXE" "Microsoft Office Excel 2007" "" "" "Office;"
POL_Shortcut "POWERPNT.EXE" "Microsoft Office Powerpoint 2007" "" "" "Office;"

# Extension
POL_Extension_Write doc "Microsoft Office Word 2007"
POL_Extension_Write docx "Microsoft Office Word 2007"
POL_Extension_Write xls "Microsoft Office Excel 2007"
POL_Extension_Write xlsx "Microsoft Office Excel 2007"
POL_Extension_Write ppt "Microsoft Office Powerpoint 2007"
POL_Extension_Write pptx "Microsoft Office Powerpoint 2007"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
