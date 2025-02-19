#!/bin/bash
# Last revision : (2019-11-02)
# Tested : Debian 6.0, Mac OSX
# Author : Tinou
# Script licence : GPLv3
#
# This script is designed for PlayOnLinux and PlayOnMac.
#
 
 
# CHANGELOG
# [Tinou] (2011-08-22 20-00)
#   Update for POL/POM 4
# [SuperPlumus] (2013-06-08 17-31)
#   gettext
# [Dadu042] (2019-11-02)
#   POL_RequiredVersion because Wine is not avaiable before POL 4.3.4
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Microsoft Office 2007"
PREFIXNAME="Office2007"
 
POL_Debug_Init
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com/" "Tinou" "$PREFIXNAME"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_System_SetArch "x86"
 
#Preparation de Wine
POL_Wine_SelectPrefix "$PREFIXNAME"
POL_Wine_PrefixCreate "4.0"
#[rbelo] Let's try Wine 1.6.2
# I never did manage to install any Service Pack with Wine 1.2.3
#POL_Wine_PrefixCreate "1.2.3"
 
cd "$POL_USER_ROOT/tmp"
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "DVD" ]; then
       POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        SetupIs="$CDROM_SETUP"
        cd "$CDROM"
else
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SetupIs="$APP_ANSWER"
fi
 
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"
 
POL_Wine_OverrideDLL native,builtin riched20
 
#CREATION LANCEUR
POL_Shortcut "WINWORD.EXE" "Microsoft Word 2007" "" "" "Office;WordProcessor;"
POL_Shortcut "EXCEL.EXE" "Microsoft Excel 2007" "" "" "Office;Spreadsheet;"
POL_Shortcut "POWERPNT.EXE" "Microsoft Powerpoint 2007" "" "" "Office;Presentation;"
 
POL_Extension_Write doc "Microsoft Word 2007"
POL_Extension_Write docx "Microsoft Word 2007"
POL_Extension_Write xls "Microsoft Excel 2007"
POL_Extension_Write xlsx "Microsoft Excel 2007"
POL_Extension_Write ppt "Microsoft Powerpoint 2007"
POL_Extension_Write pptx "Microsoft Powerpoint 2007"
 
POL_Call POL_Install_riched30
 
POL_SetupWindow_Close
exit
