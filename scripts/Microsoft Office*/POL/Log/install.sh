#!/bin/bash

# Create a new 32 bit prefix (or bottle)
# WINEPREFIX=[whatever route]
# WINEARCH=win32
#
# This will be MS Office 2016 bottle
# Set bottle to Windows 7
WINEPREFIX=~/.wineprefixes/office2016 WINEARCH=win32 winetricks win7

# Add a key in registry bottle
# ..../reg.exe ADD [registry path]
WINEPREFIX=~/.wineprefixes/office2016 WINEARCH=win32 wine ~/.wineprefixes/office2016/drive_c/windows/system32/reg.exe ADD HKEY_CURRENT_USER\\Software\\Wine\\Direct3D

# Add a DWORD value and set to 0x30002 in registry bottle
# ..../reg.exe ADD [registry path] /v [value name] /t [value type] /d [value content]
WINEPREFIX=~/.wineprefixes/office2016 WINEARCH=win32 wine ~/.wineprefixes/office2016/drive_c/windows/system32/reg.exe ADD HKEY_CURRENT_USER\\Software\\Wine\\Direct3D /v MaxVersionGL /t REG_DWORD /d 0x30002

# Install riched20 and msxml6 in bottle
WINEPREFIX=~/.wineprefixes/office2016 WINEARCH=win32 winetricks riched20 msxml6

#Run MS Office 2016 installer from DVD Backup (ISO)
WINEPREFIX=~/.wineprefixes/office2016 WINEARCH=win32 wine setup.exe