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
Title="Microsoft Office 2024"
Prefix="MS-Office-2024"
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
POL_SetupWindow_SetID 3064

# Welcome message
POL_SetupWindow_presentation "$Title" "$Company" "$OfficialSite" "$Edithor" "$Prefix"
POL_Debug_Init 

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
  POL_SetupWindow_check_cdrom "Office/Setup32.exe"
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

#Dependencies
# Install Fonts
POL_Call POL_Install_corefonts

# Library Microsoft GDI+
POL_Call POL_Install_gdiplus
POL_Wine_OverrideDLL "native,builtin" "gdiplus"

# Library Riched20
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# Library MSXML
POL_Call POL_Install_msxml6

# MSLS31
POL_Call POL_Install_msls31

# Config.xml
mkdir -p "$POL_USER_ROOT/ressources/$Prefix"
cat > "$POL_USER_ROOT/ressources/$Prefix/config.xml" <<_EOF_
<Configuration ID="77df6bb1-2d68-4480-a38e-2b1306a9a409">
  <Add OfficeClientEdition="32" Channel="PerpetualVL2024">
    <Product ID="ProPlus2024Volume" PIDKEY="XJ2XN-FW8RK-P4HMP-DKDBV-GCVGB">
      <Language ID="es-mx" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="Publisher" />
    </Product>
  </Add>
  <Property Name="SharedComputerLicensing" Value="0" />
  <Property Name="FORCEAPPSHUTDOWN" Value="TRUE" />
  <Property Name="DeviceBasedLicensing" Value="0" />
  <Property Name="SCLCacheOverride" Value="0" />
  <Property Name="AUTOACTIVATE" Value="1" />
  <Updates Enabled="FALSE" />
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration>
_EOF_

Config="z:\\home\\$USER\\.PlayOnLinux\\ressources\\$Prefix\\config.xml"

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
cd "$HOME"

# Install Program
POL_Wine start /unix $Installer
POL_Wine_WaitExit "$Prefix"

#POL_Wine start /unix $Installer /config $Config
#POL_Wine_WaitExit "$Prefix"

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
