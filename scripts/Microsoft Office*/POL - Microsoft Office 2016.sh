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
# Reference:
#  https://appdb.winehq.org/objectManager.php?sClass=application&iId=31

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variable
Title="Microsoft Office 2016"
Prefix="MS-Office-2016"
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

# Perform some validations!
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

#Validation of 32Bits
if [ ! "$(file $SetupIs | grep 'x86-64')" = "" ]; then
    POL_Debug_Fatal "$(eval_gettext "The 64bits version is not compatible! Sorry!")";
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$Prefix"
POL_Wine_PrefixCreate "$WineVersion"
Set_OS "$SystemVersion"

# Dependencies
# Microsoft Fonts
POL_Call POL_Install_corefonts

# Microsoft .Net Framework 2.0 SP1 32bits
POL_Download_Resource "https://download.microsoft.com/download/0/8/c/08c19fa4-4c4f-4ffb-9d6c-150906578c9e/NetFx20SP1_x86.exe" "c61111d7d62306b997ce7dd04898b1ca" "dotnet20"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet20/NetFx20SP1_x86.exe" /q /norestart
POL_Wine_WaitExit "Microsoft .Net Framework 2.0 SP1 32bits"

# Microsoft .Net Framework 3.0 SP1 32bits
# POL_Download_Resource "https://web.archive.org/web/20061130220825if_/http://download.microsoft.com/download/3/F/0/3F0A922C-F239-4B9B-9CB0-DF53621C57D9/dotnetfx3.exe" "7b26435437e8d779ff0084d4ea96d15a" "dotnet30"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet30/dotnetfx3.exe" /q /norestart
# POL_Wine_WaitExit "Microsoft .Net Framework 3.0 SP1 32bits"

# Microsoft .Net Framework 3.5 SP1 32bits
# POL_Download_Resource "http://download.microsoft.com/download/6/0/f/60fc5854-3cb8-4892-b6db-bd4f42510f28/dotnetfx35.exe" "d1b341c1bc8b96e4898450c9881b1425" "dotnet35"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet35/dotnetfx35.exe" /q /norestart
# POL_Wine_WaitExit "Microsoft .Net Framework 3.5 SP1 32bits"

# Library Microsoft .Net Framework 4.0 SP3 32bits
# POL_Download_Resource "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe" "251743dfd3fda414570524bac9e55381" "dotnet40"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet40/dotNetFx40_Full_x86_x64.exe" /q /norestart
# POL_Wine_WaitExit "Microsoft .Net Framework 4.0 SP3 32bits"

# Library Microsoft .Net Framework 4.5 SP3 32bits
POL_Download_Resource "http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe" "d02dc8b69a702a47c083278938c4d2f1" "dotnet45"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet45/dotnetfx45_full_x86_x64.exe" /q /norestart
POL_Wine_WaitExit "Microsoft .Net Framework 4.5 SP3 32bits"

# Visual C++ 2005 Runtime SP1
# POL_Download_Resource "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE" "4f1611f2d0ae799507f60c10ff8654c5" "vcrun2005"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2005/vcredist_x86.EXE" /q
# POL_Wine_WaitExit "Visual C++ 2005 Runtime SP1"

# Visual C++ 2008 Runtime SP1
# POL_Download_Resource "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" "a92a4d8e784d8f859217f828fe879047" "vcrun2008"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2008/vcredist_x86.exe" /q
# POL_Wine_WaitExit "Visual C++ 2008 Runtime SP1"

# Visual C++ 2010 Runtime SP1
# POL_Download_Resource "http://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe" "bd2af26fccd52e01511ff3e088f4c8bb" "vcrun2010"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2010/vcredist_x86.exe" /q
# POL_Wine_WaitExit "Visual C++ 2010 Runtime SP1"

# Visual C++ 2012 Runtime SP1
POL_Download_Resource "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe" "7f52a19ecaf7db3c163dd164be3e592e" "vcrun2012"
POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2012/vcredist_x86.exe" /q
POL_Wine_WaitExit "Visual C++ 2012 Runtime SP1"

# Visual C++ Runtime 6.0
# POL_Download_Resource "http://download.microsoft.com/download/vc60pro/Update/2/W9XNT4/EN-US/VC6RedistSetup_deu.exe" "53a0925609b366daa17051e1e4be3b86" "vcrun6"
# POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun6/VC6RedistSetup_deu.exe" /q
# POL_Wine_WaitExit "Visual C++ Runtime 6.0"

# Library Microsoft GDI+
POL_Download_Resource "https://archive.org/download/windows-xp-kb-975337-x-86-enu/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd"
POL_Wine WindowsXP-KB975337-x86-ENU.exe /extract:C:\\Tmp /q
cd "$WINEPREFIX/drive_c/Tmp"
mv "$WINEPREFIX/drive_c/Tmp/asms/10/msft/windows/gdiplus/gdiplus.dll" "$WINEPREFIX/drive_c/windows/system32"
POL_Wine_OverrideDLL "native,builtin" "gdiplus"

# Library Riched20
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# Library MSXML6
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "msxml6"

# Library sqdedev.DLL
POL_Download_Resource "https://archive.org/download/sqdedev/sqdedev.dll" "67c07960bb28f29ac77444e7801bc783" "sqdedev"
cp "$POL_USER_ROOT/ressources/sqdedev/sqdedev.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native,builtin" "sqdedev"

# Library SQLUNIRL.DLL
POL_Download_Resource "https://archive.org/download/sqlunirl/sqlunirl.dll" "0906da4d2a8dded03787b5b0701856b9" "sqlunirl"
cp "$POL_USER_ROOT/ressources/sqlunirl/sqlunirl.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native,builtin" "sqlunirl"

# Library MSPATCHA
POL_Call POL_Install_mspatcha
POL_Wine_OverrideDLL "native,builtin" "mspatcha"

# Fix black windows (added by N0rbert)
POL_Wine_Direct3D "MaxVersionGL" "30002"
cd "$POL_System_TmpDir"
echo -e 'REGEDIT4
   
[HKEY_CURRENT_USER\\Software\\Wine\\Direct2D]
"max_version_factory"=dword:00000000
 
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"MaxVersionGL"=dword:00000000
' > FixDirect3D.reg
POL_Wine regedit FixDirect3D.reg

# Library Microsoft Data Access Components MDAC28
POL_Download_Resource "https://archive.org/download/mdac28/MDAC_TYP.EXE" "6e914a7391c3b17380ce54fd3a7a133d" "mdac28"
Set_OS nt40
POL_Wine $POL_USER_ROOT/ressources/mdac28/MDAC_TYP.EXE /q /C:"setup /QNT"
POL_Wine_OverrideDLL "native,builtin" odbc32 odbccp32 oledb32

# Config.xml
# mkdir -p "$POL_USER_ROOT/ressources/$Prefix"
# cat > "$POL_USER_ROOT/ressources/$Prefix/config.xml" <<_EOF_
# <Configuration>
#   <Add OfficeClientEdition="32">
#     <Product ID="ProPlusRetail">
#       <Language ID="es-mx" />
#       <ExcludeApp ID="Groove" />
#       <ExcludeApp ID="Lync" />
#       <ExcludeApp ID="OneDrive" />
#       <ExcludeApp ID="OneNote" />
#       <ExcludeApp ID="Outlook" />
#       <ExcludeApp ID="Publisher" />
#    </Product>
#   </Add>
#   Property Name="SharedComputerLicensing" Value="0" />
#   <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
#   <Property Name="DeviceBasedLicensing" Value="0" />
#   <Property Name="SCLCacheOverride" Value="0" />
#   <Property Name="AUTOACTIVATE" Value="1" />
#   <Updates Enabled="FALSE" />
#   <RemoveMSI />
#   <Display Level="Full" AcceptEULA="TRUE" />
# </Configuration>
# _EOF_
# Config="z:\\home\\$USER\\.PlayOnLinux\\ressources\\$Prefix\\config.xml"

#By GuerreroAzul: Define the OS again. The libraries changed the configuration.
Set_OS "$SystemVersion"
Set_Managed "Off"

# Install Program
POL_Wine --ignore-errors start /unix $Installer
#POL_Wine start /unix $Installer /config $Config
POL_Wine_WaitExit "$Prefix"

# By GuerreroAzul: Pause to monitor the installation
POL_SetupWindow_message "Wait a moment while the installation begins, when the installation is finished press next." "$TITLE"

# Prepare resources for applications!  
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvSubsystems32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/C2R32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvStream32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"

# Shortcut
#POL_Shortcut "WINWORD.EXE" "Microsoft Office Word 2016" "" "" "Office;"
POL_Shortcut "EXCEL.EXE" "Microsoft Office Excel 2016" "" "" "Office;"
#POL_Shortcut "POWERPNT.EXE" "Microsoft Office Powerpoint 2016" "" "" "Office;"

# Extension
#POL_Extension_Write doc "Microsoft Office Word 2016"
#POL_Extension_Write docx "Microsoft Office Word 2016"
#POL_Extension_Write xls "Microsoft Office Excel 2016"
#POL_Extension_Write xlsx "Microsoft Office Excel 2016"
#POL_Extension_Write ppt "Microsoft Office Powerpoint 2016"
#POL_Extension_Write pptx "Microsoft Office Powerpoint 2016"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
