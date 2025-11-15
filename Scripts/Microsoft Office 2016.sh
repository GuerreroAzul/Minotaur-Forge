#!/usr/bin/env PlayOnLinux-Bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# License: Retail

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
    
# CHANGELOG

# [GuerreroAzul] 2025-11-14 09-03 (UTC -06-00) // Wine 9.0 x86 / Linux Mint 22 x86_64 xfce
#   Version Script: 1.0.8
#   - Update Scritpt for: https://www.youtube.com/watch?v=xGMbMZ_27dg&t=69s
#   - wine version: 9.0
#   - System version: Windows 7

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Microsoft Office 2016"
PREFIX="MSO2016"
CATEGORY="Office;"
WINEVERSION="9.0"
OSVERSION="win7"
ARCHITECTURE="x86"
EDITOR="Quentin Pâris, Eduardo Lucio and N0rbert, GuerreroAzul, Dingo35"
COMPANY="Microsoft Inc."
HOMEPAGE="ttp://www.microsoft.com"
LOGO="https://i.imgur.com/licFVuF.png"
BANNER="https://i.imgur.com/ff6PkEZ.png"


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
    
# NOTE: Samba support! By Quentin Pâris
if [ "$POL_OS" = "Mac" ]; then
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# Dependencies
# Luna Theme
POL_Call POL_Install_LunaTheme

# Microsoft Fonts
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Fonts/Fonts.zip" "a9669ee3387be9d3bc504eb799723799" "Fonts"
POL_System_unzip "$POL_USER_ROOT/ressources/Fonts/Fonts.zip" -d "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/"

# Microsoft XML Parser 3.0 
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20XML%20Core%20Services/3.0/msxml3.msi" "7049c6531837341363fe69d068d001b0" "msxml3"
if [ "$ARCHITECTURE" = "amd64" ]; then
  rm "$WINEPREFIX/drive_c/windows/syswow64/msxml3.dll"
else
  rm "$WINEPREFIX/drive_c/windows/system32/msxml3.dll"
fi
POL_Wine_OverrideDLL "native" "msxml3"
POL_Wine --ignore-errors msiexec /i "$POL_USER_ROOT/ressources/msxml3/msxml3.msi" /q
POL_Wine_WaitExit "Microsoft XML Parser 3.0"


# Microsoft XML Core Services 6.0
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_System_TmpCreate "Microsoft XML Core Services 6.0"
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20XML%20Core%20Services/6.0/msxml6_x64.zip" "118dc670ace3533efd5733ae41f32370" "msxml6"
  POL_System_unzip "$POL_USER_ROOT/ressources/msxml6/msxml6_x64.zip" -d "Z:$POL_System_TmpDir/msxml6"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msxml6.dll"
  POL_Wine_OverrideDLL "native" "msxml6"
  POL_Wine --ignore-errors msiexec /i "$POL_System_TmpDir/msxml6/msxml6_x64.msi" /q
  POL_Wine_WaitExit "Microsoft XML Core Services 6.0"
  POL_System_TmpDelete
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20XML%20Core%20Services/6.0/msxml6_x86.msi" "85a5571258de322458f288b94ee28cfb" "msxml6"
  rm "$WINEPREFIX/drive_c/windows/system32/msxml6.dll"
  POL_Wine_OverrideDLL "native" "msxml6"
  POL_Wine --ignore-errors msiexec /i "$POL_USER_ROOT/ressources/msxml6/msxml6_x86.msi" /q 
  POL_Wine_WaitExit "Microsoft XML Core Services 6.0"
fi

# Microsoft Visual C++ 2010 MFC100 Library
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/MFC100%20Library/vcredist_x86_28c54491be70c38c97849c3d8cfbfdd0d3c515cb.exe" "1801436936e64598bab5b87b37dc7f87" "mfc100"
POL_Wine "$POL_USER_ROOT/ressources/mfc100/vcredist_x86_28c54491be70c38c97849c3d8cfbfdd0d3c515cb.exe" /q
POL_Wine_WaitExit "Microsoft Visual C++ 2010 MFC100 Library"

# Microsoft Data Access Components 2.8 Service Pack 1 (mdac28)
Set_OS nt40
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Data%20Access%20Components/2.8%20SP1/MDAC_TYP.EXE" "6e914a7391c3b17380ce54fd3a7a133d" "mdac28"
POL_Wine_OverrideDLL "native, builtin" odbc32 odbccp32 oledb32 sqlsrv32
POL_Wine "$POL_USER_ROOT/ressources/mdac28/MDAC_TYP.EXE" /q /C:"setup /QNT"
POL_Wine_WaitExit "Microsoft Data Access Components 2.8 Service Pack 1"
Set_OS "$OSVERSION"

# Microsoft Windows Script Host 5.7 (wsh57)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Windows%20Script%20Host/5.7/scripten.exe" "65a8ebf870420316a939ac44fd4c731d" "wsh57"
cabextract -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/wsh57/scripten.exe"
POL_Wine_WaitExit "Microsoft Windows Script Host 5.7"
POL_Wine_OverrideDLL "native, builtin" jscript scrrun vbscript cscript.exe wscript.exe
POL_Wine regsvr32 /s dispex.dll jscript.dll scrobj.dll scrrun.dll vbscript.dll wshcon.dll wshext.dll

# Microsoft Jet 4.0 Service Pack 8 (jet40)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Jet/4.0%20SP8/Jet40SP8_9xNT.exe" "d1028c0f98b4ffe5ede854327b77fbb9" "jet40"
POL_Wine "$POL_USER_ROOT/ressources/jet40/Jet40SP8_9xNT.exe" /Q
POL_Wine_WaitExit "Microsoft Jet 4.0 Service Pack 8"

# Microsoft Windows Internet API
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Windows%20Internet%20API/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" "" "wininet"
if [ "$POL_ARCH" == "amd64" ]; then
  cabextract --single -F "wininet.dll" -d "$WINEPREFIX/drive_c/windows/syswow64" "$POL_USER_ROOT/ressources/wininet/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe""
else
  cabextract --single -F "wininet.dll" -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/wininet/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe""
fi
POL_Wine_OverrideDLL "native, builtin" wininet

# Microsoft GDI+ (gdiplus)
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20GDI%2B/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd" "gdiplus"
if [ "$POL_ARCH" == "amd64" ]; then
  cabextract --single -F "gdiplus.dll" -d "$WINEPREFIX/drive_c/windows/syswow64" "$POL_USER_ROOT/ressources/gdiplus/WindowsXP-KB975337-x86-ENU.exe"
else
  cabextract --single -F "gdiplus.dll" -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/gdiplus/WindowsXP-KB975337-x86-ENU.exe"
fi
POL_Wine_OverrideDLL "native, builtin" gdiplus

# Microsoft RichEdit Control 3.0 + Microsoft Line Services
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20RichEdit%20Control/3.0/instmsiA.exe" "22098231992c8c808543825e19dc9454" "riched30"
if [ "$ARCHITECTURE" = "amd64" ]; then
  cabextract --single -F "riched20.dll" -F "msls31.dll" -d "$WINEPREFIX/drive_c/windows/syswow64" "$POL_USER_ROOT/ressources/riched30/instmsiA.exe"
else
  cabextract --single -F "riched20.dll" -F "msls31.dll" -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/riched30/instmsiA.exe"
fi
POL_Wine_OverrideDLL "native,builtin" riched20 msls31

# Microsoft Visual Basic 6 Runtime Service Pack 6
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20Basic/6%20Runtime%20SP6/VB6.0-KB290887-X86.exe" "ef5b83c4cc60e246bf627d85f6d7397b" "vb6run"
cabextract --single -F "asycfilt.dll" -F "comcat.dll" -F "msvbvm60.dll" -F "oleaut32.dll" -F "olepro32.dll" -F "stdole2.tlb" -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/vb6run/VB6.0-KB290887-X86.exe"
POL_Wine_WaitExit "Microsoft Visual Basic 6 Runtime Service Pack 6"
POL_Wine_OverrideDLL "native,builtin" asycfilt comcat msvbvm60 oleaut32 stdole2

# Microsoft Visual C++ Redistributable 2005 Service Pack 1
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2005%20SP1/vcredist_x64.EXE"  "e231fbcce2c2cb16dcc299d36c734df3" "vcrun2005"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp80.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2005/vcredist_x64.EXE" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2005 Service Pack 1"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2005%20SP1/vcredist_x86.EXE"  "4f1611f2d0ae799507f60c10ff8654c5" "vcrun2005"
  rm "$WINEPREFIX/drive_c/windows/system32/msvcp80.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2005/vcredist_x86.EXE" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2005 Service Pack 1"
fi
POL_Wine_OverrideDLL "native,builtin" msvcp80

# Microsoft Visual C++ Redistributable 2008 Service Pack 1
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2008%20SP1/vcredist_x64.exe"  "472c10efa75a30deb2a15ec8b777227b" "vcrun2008"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp90.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2008/vcredist_x64.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2008 Service Pack 1"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2008%20SP1/vcredist_x86.exe"  "a92a4d8e784d8f859217f828fe879047" "vcrun2008"
  rm "$WINEPREFIX/drive_c/windows/system32/msvcp90.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2008/vcredist_x86.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2008 Service Pack 1"
fi
POL_Wine_OverrideDLL "native,builtin" msvcp90 msvcr90 vcomp90 atl90
                
# Microsoft Visual C++ Redistributable 2010 Service Pack 1
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2010%20SP1/vcredist_x64.exe"  "be79543624f806ced4c7dff25751a3e4" "vcrun2010"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp100.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2010/vcredist_x64.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2010 Service Pack 1"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2010%20SP1/vcredist_x86.exe"  "5faedf5ae484adcb842bec6aa14ae8d9" "vcrun2010"
  rm "$WINEPREFIX/drive_c/windows/system32/msvcp100.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2010/vcredist_x86.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2010 Service Pack 1"
fi
POL_Wine_OverrideDLL "native,builtin" msvcp100 msvcr100 vcomp100 atl100

# Microsoft Visual C++ Redistributable 2012 Service Pack 1
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2012%20SP1/vcredist_x64.exe"  "3c03562b5af9ed347614053d459d7778" "vcrun2012"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp110.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2012/vcredist_x64.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2012 Service Pack 1"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2012%20SP1/vcredist_x86.exe"  "7f52a19ecaf7db3c163dd164be3e592e" "vcrun2012"
  rm "$WINEPREFIX/drive_c/windows/system32/msvcp110.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2012/vcredist_x86.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2012 Service Pack 1"
fi
POL_Wine_OverrideDLL "native,builtin" msvcp110 msvcr110 vcomp110 atl110 mfc110 mfc110u mfcm110 mfcm110u vccorlib110 vcamp110

# Microsoft Visual C++ Redistributable 2013 Service Pack 1
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2013%20SP1/vcredist_x64.exe"  "96b61b8e069832e6b809f24ea74567ba" "vcrun2013"
  rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp120.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2013/vcredist_x64.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2013 Service Pack 1"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/2013%20SP1/vcredist_x86.exe"  "0fc525b6b7b96a87523daa7a0013c69d" "vcrun2013"
  rm "$WINEPREFIX/drive_c/windows/system32/msvcp120.dll"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2013/vcredist_x86.exe" /q
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable 2013 Service Pack 1"
fi
POL_Wine_OverrideDLL "native,builtin" msvcp120 msvcr120 vcomp120 atl120 mfc120 mfc120u mfcm120 mfcm120u vccorlib120 vcamp120

# Microsoft Visual C++ Redistributable (2015-2022)
if [ "$ARCHITECTURE" = "amd64" ]; then
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/Visual%20Studio%202015-2022/VC_redist.x86.exe"  "99f52708b06b9c695a8d64a44740bf08" "vcrun2022"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2022/vc_redist.x86.exe" /quiet
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable (2015-2022)"
else
  POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Visual%20C%2B%2B%20Redistributable/Visual%20Studio%202015-2022/VC_redist.x64.exe" "486f81facf798678c3244c7cf35a557f" "vcrun2022"
  POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2022/vc_redist.x64.exe" /quiet
  POL_Wine_WaitExit "Microsoft Visual C++ Redistributable (2015-2022)"
fi

# Verification of digital signatures and Microsoft certificates. (Download dll: https://es.dll-files.com/)
# Crypto API32
POL_Download_Resource "https://archive.org/download/Resources-POL/Crypto%20API32/x86/10.0.19041.21/crypt32.dll" "26620d486c4892d15200149924be2cf8" "crypt32"
cp -f "$POL_USER_ROOT/ressources/crypt32/crypt32.dll" "$WINEPREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native, builtin" crypt32.dll

# Microsoft Abstract Syntax Notation 1
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Abstract%20Syntax%20Notation%201/x86/10.0.18362.1/msasn1.dll" "5e66a3ed8f267aa2ccea3ffcfe9ffecc" "msasn1"
cp -f "$POL_USER_ROOT/ressources/msasn1/msasn1.dll" "$WINEPREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native, builtin" msasn1.dll

# Microsoft Trust Verification APIs
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20Trust%20Verification%20APIs/x86/10.0.18362.387/wintrust.dll" "b403ccad0dda00a64bf49f975b7b5afd" "wintrust"
cp -f "$POL_USER_ROOT/ressources/wintrust/wintrust.dll" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native, builtin" wintrust.dll
POL_Wine regsvr32 /s wintrust.dll

# DirectX End-User Runtimes (June 2010)
POL_System_TmpCreate "directx_Jun2010_redist"
cd "$POL_System_TmpDir"
POL_Download_Resource "https://archive.org/download/Resources-POL/Microsoft%20DirectX%20End-User%20Runtime/29.9.1974.1%20%28June%202010%29/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4" "DirectX-2010.06"
POL_Wine start /unix "$POL_USER_ROOT/ressources/DirectX-2010.06/directx_Jun2010_redist.exe" /Q /T:"Z:$POL_System_TmpDir"
POL_Wine_WaitExit "DirectX End-User Runtimes (June 2010)"

# Microsoft .Net Framework 4.0

# Microsoft .Net Framework 4.8
POL_Download_Resource "https://download.microsoft.com/download/f/3/a/f3a6af84-da23-40a5-8d1c-49cc10c8e76f/NDP48-x86-x64-AllOS-ENU.exe" "74d56b9081a42f6315cea96c895cbbcc" "dotnet48"
# POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true
rm "$WINEPREFIX/drive_c/windows/system32/mscoree.dll"
POL_Wine_OverrideDLL "native, builtin" mscoree
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet48/NDP48-x86-x64-AllOS-ENU.exe" /q
POL_Wine_WaitExit "Microsoft .Net Framework 4.8"

# Fix MSI Install
POL_Wine reg add "HKLM\\Software\\Policies\\Microsoft\\Windows\\Installer" /v DisableMSI /t REG_DWORD /d 0 /f

# Fix Office Graphics
cat << EOF > fix_office_graphics.reg
[HKEY_CURRENT_USER\\Software\\Microsoft\\Office\\16.0\\Common\\Graphics]
"DisableHardwareAcceleration"=dword:00000001
EOF
POL_Wine regedit fix_office_graphics.reg

# Fix black windows (added by N0rbert)
POL_Wine_Direct3D "MaxVersionGL" "30002"

# Script start
# NOTE: Installs office! By Questor
# Set_Managed "Off"

POL_SetupWindow_InstallMethod "LOCAL, DVD"
# Install CD/DVD
if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "x86/setup.exe" "setup.exe"
    INSTALLER="$CDROM_SETUP"
# Install local
else
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
fi

# cat > "$WINEPREFIX/drive_c/config.xml" << 'EOF'
# <Configuration>
#     <Add SourcePath="." OfficeClientEdition="32">
#         <Product ID="ProPlusVolume">
#             <Language ID="es-mx" />
#         </Product>
#     </Add>
#     <Display Level="None" AcceptEULA="TRUE" />
#     <Property Name="AUTO_ACTIVATE" Value="0" />
# </Configuration>
# EOF

# cd "$HOME"
# POL_Wine start /unix "$INSTALLER" /config "C:\\config.xml"
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"



# By GuerreroAzul: Pause to monitor the installation
# POL_SetupWindow_message "$(eval_gettext 'Wait a moment while the installation begins, when the installation is finished press next.')" "$TITLE"
    
# ---------------------------------------------------------------------------------------------------------
# Prepare resources for applications!
# cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvSubsystems32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
# cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/C2R32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
# cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Microsoft Shared/ClickToRun/AppvIsvStream32.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/root/Office16/"
    
# Fix a crash when loading a file
# NOTE: Fix "move and change the window size (maximize/minimize/restore/resize
# etc...) bugs"! By Questor
# [Ref.: https://bugs.winehq.org/show_bug.cgi?id=44552]
#Set_Managed "Off"
 
# ---------------------------------------------------------------------------------------------------------
# Create shortcuts, entries to extensions and finalize!
    
# NOTE: Create shortcuts! By Questor
# POL_Shortcut "WINWORD.EXE" "Microsoft Word 2016" "" "" "Office;WordProcessor;" || true
# POL_Shortcut "EXCEL.EXE" "Microsoft Excel 2016" "" "" "Office;Spreadsheet;" || true
# POL_Shortcut "POWERPNT.EXE" "Microsoft Powerpoint 2016" "" "" "Office;Presentation;" || true
    
# NOTE: No category for collaborative work? By Quentin Pâris
# POL_Shortcut "ONENOTE.EXE" "Microsoft OneNote 2016" "" "" "Network;InstantMessaging;" || true
    
# NOTE: "Calendar;ContactManagement;"? By Quentin Pâris
# POL_Shortcut "OUTLOOK.EXE" "Microsoft Outlook 2016" "" "" "Network;Email;" || true
    
# NOTE: Add an entry to PlayOnLinux's extension file. If the entry already
# exists, it will replace it! By Questor
# [Ref.: https://github.com/PlayOnLinux/POL-POM-4/blob/master/lib/playonlinux.lib]
# POL_Extension_Write doc "Microsoft Word 2016"
# POL_Extension_Write docx "Microsoft Word 2016"
# POL_Extension_Write xls "Microsoft Excel 2016"
# POL_Extension_Write xlsx "Microsoft Excel 2016"
# POL_Extension_Write ppt "Microsoft Powerpoint 2016"
# POL_Extension_Write pptx "Microsoft Powerpoint 2016"
    
# if [ "$POL_OS" = "Mac" ]; then
#     POL_Shortcut_InsertBeforeWine "Microsoft Word 2016" "source "$POL_USER_ROOT/tools/samba3/init""
#     POL_Shortcut_InsertBeforeWine "Microsoft Excel 2016" "source "$POL_USER_ROOT/tools/samba3/init""
#     POL_Shortcut_InsertBeforeWine "Microsoft Powerpoint 2016" "source "$POL_USER_ROOT/tools/samba3/init""
#     POL_Shortcut_InsertBeforeWine "Microsoft OneNote 2016" "source "$POL_USER_ROOT/tools/samba3/init""
#     POL_Shortcut_InsertBeforeWine "Microsoft Outlook 2016" "source "$POL_USER_ROOT/tools/samba3/init""
# fi
   
# ---------------------------------------------------------------------------------------------------------
#we get stuck with the Office window that doesn't close....
# cd "$POL_USER_ROOT/wineprefix"
# POL_SetupWindow_wait_next_signal  "$(eval_gettext 'Killing big white window that is stuck, please wait...')" "$APPLICATION_TITLE"
# for prefix in *
# do
#     export WINEPREFIX="$POL_USER_ROOT/wineprefix/$prefix"
#                (POL_Wine_AutoSetVersionEnv
#     wineserver -k)
#     POL_Debug_Message "Killed $prefix"
# done
 
# ---------------------------------------------------------------------------------------------------------
POL_SetupWindow_Close
exit 0