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
#   System version: win11
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
Title="Microsoft Office 2010"
Prefix="MS-Office-2010"
Category="Office;"
WineVersion="9.0"
SystemVersion="win10"
Edithor="Quentin PÂRIS, Dadu042 And GuerreroAzul"
Company="Microsoft"
OfficialSite="https://www.microsoft.com"
  
# Setup Image
POL_GetSetupImages "$Logo" "$Banner" "$Title"
 
# Starting the script
POL_SetupWindow_Init
POL_SetupWindow_SetID 801
 
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
# Library Microsoft .Net Framework 2.0 SP1 32bits
# POL_Call POL_Install_dotnet20
POL_Download_Resource "https://download.microsoft.com/download/0/8/c/08c19fa4-4c4f-4ffb-9d6c-150906578c9e/NetFx20SP1_x86.exe" "c61111d7d62306b997ce7dd04898b1ca" "dotnet20"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet20/NetFx20SP1_x86.exe" /q /norestart 
POL_Wine_WaitExit "Microsoft .Net Framework 2.0 SP1 32bits"

# Library Microsoft .Net Framework 4.0 SP3 32bits
# POL_Call POL_Install_dotnet40
#POL_Download_Resource "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe" "251743dfd3fda414570524bac9e55381" "dotnet40"
#POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet40/dotNetFx40_Full_x86_x64.exe" /q /norestart 
#POL_Wine_WaitExit "Microsoft .Net Framework 4.0 SP3 32bits"

# Library Visual C++ 2005
POL_Call POL_Install_vcrun2005
POL_Wine_OverrideDLL "native,builtin" "mfc100"
POL_Wine_OverrideDLL "native,builtin" "mfc100u"

# Library Visual C++ 2008
#POL_Call POL_Install_vcrun2008

# Library Visual C++ 2010
#POL_Call POL_Install_vcrun2010

# Library Gecko
# POL_Call POL_Install_gecko

# Install Fonts
POL_Call POL_Install_corefonts

# Library Microsoft GDI+
POL_Call POL_Install_gdiplus
POL_Wine_OverrideDLL "native,builtin" "gdiplus"

# Library Riched20
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# Library Riched30
POL_Call POL_Install_riched30
POL_Wine_OverrideDLL "native,builtin" "riched30"

# Library MSLS31
# POL_Call POL_Install_msls31

# Library MSXML
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6

# Library MSPATCHA
POL_Call POL_Install_mspatcha

# Config.xml
mkdir -p "$POL_USER_ROOT/ressources/$Prefix"
cat > "$POL_USER_ROOT/ressources/$Prefix/config.xml" <<_EOF_
<Configuration Product="ProPlus">
<Display Level="none" CompletionNotice="no" SuppressModal="yes" AcceptEula="yes" />
</Configuration>
_EOF_

Config="z:\\home\\$USER\\.PlayOnLinux\\ressources\\$Prefix\\config.xml"

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
#POL_Wine start /unix $Installer /config $Config
POL_Wine start /unix $Installer
POL_Wine_WaitExit "$Prefix"

# Shortcut
#POL_Shortcut "WINWORD.EXE" "Microsoft Office Word 2010" "" "" "Office;"
POL_Shortcut "EXCEL.EXE" "Microsoft Office Excel 2010" "" "" "Office;"
#POL_Shortcut "POWERPNT.EXE" "Microsoft Office Powerpoint 2010" "" "" "Office;"

# Extension
#POL_Extension_Write doc "Microsoft Office Word 2010"
#POL_Extension_Write docx "Microsoft Office Word 2010"
#POL_Extension_Write xls "Microsoft Office Excel 2010"
#POL_Extension_Write xlsx "Microsoft Office Excel 2010"
#POL_Extension_Write ppt "Microsoft Office Powerpoint 2010"
#POL_Extension_Write pptx "Microsoft Office Powerpoint 2010"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
