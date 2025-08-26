#!/usr/bin/python3
'''
╔════════════════════════════════════════════════════════════════════════════════════════════════════╗
║ Copyright (C) 2008 Pâris Quentin                                                                   ║
║ Copyright (C) 2007-2057 PlayOnLinux team                                                           ║
║                                                                                                    ║
║ This program is free software; you can redistribute it and/or modify it under the terms of the GNU ║
║ General Public License as published by the Free Software Foundation; either version 2 of the       ║
║ License, or (at your option) any later version.                                                    ║
║                                                                                                    ║
║ This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without  ║
║ even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU      ║
║ General Public License for more details.                                                           ║
║                                                                                                    ║  
║ You should have received a copy of the GNU General Public License along with this program; if not, ║ 
║ write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA           ║
║ 02110-1301 USA.                                                                                    ║
╚════════════════════════════════════════════════════════════════════════════════════════════════════╝

╔════════════════════════════════════════════════════════════════════════════════════════════════════╗
║  Importing external libraries / Importación de bibliotecas externas                                ║
╠═════════════════════════╦══════════════════════════════════════════════════════════════════════════╣
║ Libraries / Bibliotecas ║ Description / Descripción                                                ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ collections           ║ EN: Contains advanced data types.                                        ║
║                         ║ ES: Contiene tipos de datos avanzados.                                   ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ gi.repository (Glib)  ║ EN: It is a base library for GNOME/GTK applications.                     ║
║                         ║ ES: Es una biblioteca base para aplicaciones GNOME/GTK.                  ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ os                    ║ EN: Library that interacts with the system.                              ║
║                         ║ ES: Libreria que interactua con el sistema.                              ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ shlex                 ║ EN: Split text strings into "Tokens".                                    ║
║                         ║ ES: Dividir cadenas de texto en "Tokens".                                ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ signal                ║ EN: Manage operating system signals (Ctrl + C).                          ║
║                         ║ ES: Gestionar señales del sistema operativo (Ctrl + C).                  ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ subprocess            ║ EN: Execute external processes and commands.                             ║
║                         ║ ES: Ejecutar procesos y comandos externos.                               ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ sys                   ║ EN: Allows you to interact directly with the Python interpreter.         ║
║                         ║ ES: Permite interactuar directamente con el intérprete de Python.        ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ time                  ║ EN: Working with dates, times and time delays.                           ║
║                         ║ ES: Trabajar con fechas, horas y retrasos temporales.                    ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ threading             ║ EN: Allows you to create and manage "threads" of execution.              ║
║                         ║ ES: Permite crear y manejar "hilos" de ejecución.                        ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ urllib.parse          ║ EN: Analyze, create, manipulate and decompose URLs (web addresses).      ║
║                         ║ ES: Analizar, crear, manipular y descomponer URLs (direcciones web).     ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ webbrowser            ║ EN: Allows you to automatically open web pages (URLs).                   ║
║                         ║ ES: Permite abrir automáticamente páginas web (URLs).                    ║
╠═════════════════════════╬══════════════════════════════════════════════════════════════════════════╣
║ ❖ wx                    ║ EN: It is a “wrapper” of the C++ wxWidgets library.                      ║
║                         ║ ES: Es un “wrapper” (envoltorio) de la librería C++ wxWidgets.           ║
╚═════════════════════════╩══════════════════════════════════════════════════════════════════════════╝

╔════════════════════════════════════════════════════════════════════════════════════════════════════╗
║ Importing internal libraries / Importación de librerias internas                                   ║
╠════════════════════════════════════╦═══════════════════════════════════════════════════════════════╣
║ Libraries / Bibliotecas            ║ Alias                                                         ║
╠════════════════════════════════════╬═══════════════════════════════════════════════════════════════╣
║ ❖ configurewindow.ConfigureWindow  ║ ConfigureWindow                                               ║
║ ❖ debug                            ║ Debug                                                         ║
║ ❖ install.InstallWindow            ║ InstallWindow                                                 ║
║ ❖ lib.lng                          ║ Lng                                                           ║
║ ❖ lib.playonlinux                  ║ PlayOnLinux                                                   ║
║ ❖ lib.Variables                    ║ Variables                                                     ║
║ ❖ options                          ║ Options                                                       ║
║ ❖ setupwindow.gui_server           ║ GuiServer                                                     ║
║ ❖ wine_versions.WineVersionsWindow ║ WineVersions                                                  ║
╚════════════════════════════════════╩═══════════════════════════════════════════════════════════════╝
'''
encoding = 'UTF-8'
import os

# Check if the operating system is valid. / Verificar si el sistema operativo es valido.
try:
    os.environ["POL_OS"]
except:
    print("ERROR ! Please define POL_OS os.environment var first.")
    os._exit(1)

# Importing external libraries / Importación de bibliotecas externas 
import collections
import shlex
import signal
import subprocess
import sys
import time
import threading
import urllib.parse
import webbrowser
import wx, wx.aui, wx.adv

# Importing internal libraries / Importación de librerias internas 
import configurewindow.ConfigureWindow as ConfigureWindow
import debug as Debug
import install.InstallWindow as InstallWindow
import lib.lng as Lng
import lib.playonlinux as PlayOnLinux
import lib.Variables as Variables
import options as Options
import setupwindow.gui_server as GuiServer
import wine_versions.WineVersionsWindow as WineVersions
from gi.repository import GLib
from gettext import gettext as _

# Set the program name / Establecer el nombre del programa
GLib.set_prgname(os.environ["APPLICATION_TITLE"])

# This thread manage updates / Gestor de actualizaciones.
class POLWeb(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.SendToStatusBarStr = ""
        self.SendAlertStr = None
        self.Gauge = False
        self.WebVersion = ""
        self.Show = False
        self.Perc = -1
        self.Updating = True

    # Check indicator / Indicador de chequeos
    def Check(self):
        self.WantCheck = True

    # Check out the latest version of PlayOnLinux / Consulta la ultima versión de PlayOnLinux
    def LastVersion(self):
        if (os.environ["POL_OS"] == "Mac"):
            FichierOnline = "version_mac"
        elif (os.environ["POL_OS"] == "FreeBSD"):
            FichierOnline = "version_freebsd"
        else:
            FichierOnline = "version2"
        return os.popen(os.environ["POL_WGET"] + ' "' + os.environ["SITE"] + '/' + FichierOnline + '.php?v=' + os.environ[
                        "VERSION"] + '" -T 30 -O-', 'r').read()

    # Check and update the PlayOnLinux script list / Verifica y actualiza el listado de scripts de PlayOnLinux
    def RealCheck(self):
        self.WebVersion = self.LastVersion()

        if (self.WebVersion == ""):
            self.SendToStatusBar(
                _('{0} website is unavailable. Please check your connection').format(os.environ["APPLICATION_TITLE"]),
                False)
        else:
            self.SendToStatusBar(_("Refreshing {0}").format(os.environ["APPLICATION_TITLE"]), True)
            self.SendPercentage(0)
            self.Updating = True
            exe = ['bash', Variables.playonlinux_env + "/bash/pol_update_list"]

            x = subprocess.Popen(exe, stdout=subprocess.PIPE, bufsize=1, universal_newlines=True,
                preexec_fn=lambda: os.setpgid(os.getpid(), os.getpid()))

            for line in iter(x.stdout.readline, ''):
                try:
                    self.SendPercentage(int(line))
                except ValueError:
                    pass

            self.Updating = False
            if (PlayOnLinux.VersionLower(os.environ["VERSION"], self.WebVersion)):
                self.SendToStatusBar(_('An updated version of {0} is available').format(
                    os.environ["APPLICATION_TITLE"]) + " (" + self.WebVersion + ")", False)
                if (os.environ["DEBIAN_PACKAGE"] == "FALSE"):
                    self.SendAlert(_('An updated version of {0} is available').format(
                        os.environ["APPLICATION_TITLE"]) + " (" + self.WebVersion + ")")
                os.environ["POL_UPTODATE"] = "FALSE"
            else:
                self.Show = False
                self.Perc = -1
                os.environ["POL_UPTODATE"] = "TRUE"

        self.WantCheck = False

    # Background checks / Verificaciones en segundo plano
    def Run(self):
        self.check()
        while (1):
            if (self.WantCheck == True):
                self.RealCheck()
            time.sleep(1)

    # Displays an alert dialog. / Muestra un dialogo de alerta.
    def SendAlert(self, message):
        self.SendAlertStr = message

    # Displays the percentage of progress. / Muestra el porcentaje del progreso.
    def SendPercentage(self, n):
        self.Perc = n

    # Displays dialogs in the status bar. / Muestra dialogos en la barra de estados.
    def SendToStatusBar(self, message, gauge):
        self.SendToStatusBarStr = message
        self.Gauge = gauge
        self.Show = True

# Dynamic Panel Design / Diseño dinámico de paneles
class PanelManager(wx.aui.AuiManager):
    def __init__(self, frame):
        wx.aui.AuiManager.__init__(self, frame)
        self.StartPerspective = self.SavePerspective()

    # Allows adding an "coupling panel" / Permite agregar un "Panel Acoplable"
    def AddPane(self, data, settings):
        wx.aui.AuiManager.AddPane(self, data, settings)

    # Save the (layout) position of the panels before closing or destroying the window
    # Guarda la posición (layout) de los paneles antes de cerrar o destruir la ventana
    def Destroy(self):
        self.SavePosition()

    # Obtain the current layout and replace the name with a fixed marker.
    # Obtiene el layout actual y reemplaza el nombre por un marcador fijo.
    def GetPerspective(self):
        return self.SavePerspective().replace(self._GetPerspectiveName(), "PERSPECTIVE_NAME")

    # Extract the design name (perspective) / Extraer el nombre del diseño (perspectiva) 
    def _GetPerspectiveName(self):
        Name = self.SavePerspective().split("=")
        Name = Name[1].split(";")
        Name = Name[0]
        return Name

    # Restore the user interface design / Restaura el diseño de la interfaz de usuario 
    def RestorePosition(self):
        self.StartPerspective = self.SavePerspective()
        self.Update()
        
        try:
            Setting = PlayOnLinux.GetSettings("PANEL_PERSPECTIVE")
            if Setting:
                if (Setting.count("Actions") < 2 or Setting.count("dock_size") < 2 or not "PERSPECTIVE_NAME" in Setting):
                    self.LoadPerspective(self.StartPerspective)
                else:
                    Setting = Setting.replace("PERSPECTIVE_NAME", self._GetPerspectiveName())
                    self.LoadPerspective(Setting)
        except wx._core.PyAssertionError:
            self.LoadPerspective(self.StartPerspective)

    # Save the current interface design in the Playonlinux configuration, so that it can be restored later.
    # Guarda el diseño actual de la interfaz en la configuración de PlayOnLinux, para que pueda ser restaurado más adelante.
    def SavePosition(self):
        PlayOnLinux.SetSettings("PANEL_PERSPECTIVE", self.GetPerspective())

# Main window design / Diseño de ventana principal
class MainWindow(wx.Frame):
    def __init__(self, parent, id, title):
        # Creation of the main window / Creación de la ventana principal
        wx.Frame.__init__(self, parent, 1000, title, size=(515, 450))
        self.SetMinSize((400, 400))
        self.SetIcon(wx.Icon(Variables.playonlinux_env + "/etc/playonlinux.png", wx.BITMAP_TYPE_ANY))
        self.windowList = {}
        self.registeredPid = []
        self.windowOpened = 0

        # Manage updater / Administrador de actualizaciones
        self.Updater = POLWeb()
        self.Updater.start()

        # These lists contain the dock links and images / Estas listas contienen los enlaces y las imágenes del dock.
        self.menuElem = {}
        self.menuImage = {}

        # Catch CTRL+C / Capturar CTRL+C
        signal.signal(signal.SIGINT, self.ForceClose)

        # Window size / Tamaño de la ventana.
        try:
            self.windowWidth = int(PlayOnLinux.GetSettings("MAINWINDOW_WIDTH"))
            self.windowHeight = int(PlayOnLinux.GetSettings("MAINWINDOW_HEIGHT"))
            self.SetSize((self.windowWidth, self.windowHeight))
        except:
            self.windowWidth = 500
            self.windowHeight = 450

        # Window position / Posición de la ventana
        try:
            self.windowx = int(PlayOnLinux.GetSettings("MAINWINDOW_X"))
            self.windowy = int(PlayOnLinux.GetSettings("MAINWINDOW_Y"))
            self.screen_width = wx.Display().GetGeometry()[2]
            self.screen_height = wx.Display().GetGeometry()[3]

            if (self.screen_width >= self.windowx and self.screen_height >= self.windowy):
                self.SetPosition((self.windowx, self.windowy))
            else:
                self.Center(wx.BOTH)
        except:
            self.Center(wx.BOTH)

        try:
            self.iconSize = int(PlayOnLinux.GetSettings("ICON_SIZE"))
        except:
            self.iconSize = 32

        self.images = wx.ImageList(self.iconSize, self.iconSize)
        self.imagesEmpty = wx.ImageList(1, 1)

        self.SendAlertStr = None

        # Implementation of fonts / Implementación de fuentes
        if (os.environ["POL_OS"] == "Mac"):
            self.fontTitre = wx.Font(14, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD, False, "", wx.FONTENCODING_DEFAULT)
            self.fontText  = wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, "", wx.FONTENCODING_DEFAULT)
        else:
            self.fontTitre = wx.Font(10, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD, False, "", wx.FONTENCODING_DEFAULT)
            self.fontText  = wx.Font( 8, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, "", wx.FONTENCODING_DEFAULT)

        # Central Panel (Programs) / Panel central (Programas)
        self.ProgramsPanel = wx.ScrolledWindow(self, 105, style=wx.VSCROLL | wx.HSCROLL)
        self.ProgramsPanel.SetScrollRate(10, 10)
        self.ProgramsPanelSizer = wx.WrapSizer(wx.HORIZONTAL)
        self.ProgramsPanel.SetSizer(self.ProgramsPanelSizer)
        
        # Right Panel (Personalization) / Panel Derecho (Personalización)
        self.PersonalizationPanel = wx.ScrolledWindow(self, -1, style=wx.VSCROLL)
        self.PersonalizationPanel.SetScrollRate(10, 10)
        self.PersonalizationPanelSizer = wx.BoxSizer(wx.VERTICAL)       
        self.PersonalizationPanel.SetSizer(self.PersonalizationPanelSizer)

        # Left Panel (Categories) / Panel Izquierdo (Categorias)
        self.CategoryPanel = wx.ScrolledWindow(self, -1, style=wx.VSCROLL)
        self.CategoryPanel.SetScrollRate(10, 10)
        self.CategoryPanelSizer = wx.BoxSizer(wx.VERTICAL)
        self.CategoryPanel.SetSizer(self.CategoryPanelSizer)
        
        # Search bar in categories / Barra de búsqueda en categorias
        self.CategorySearchBox = wx.SearchCtrl(self.CategoryPanel, style=wx.TE_PROCESS_ENTER)
        self.CategorySearchBox.ShowSearchButton(True)
        self.CategorySearchBox.ShowCancelButton(True)
        self.CategorySearchBox.SetDescriptiveText(_("Search"))

        self.CategorySearchBox.Bind(wx.EVT_TEXT, self.OnSearch)
        self.CategorySearchBox.Bind(wx.EVT_TEXT_ENTER, self.OnSearch)
        self.CategorySearchBox.Bind(wx.EVT_SEARCHCTRL_CANCEL_BTN, self.OnCategoryClear)
        self.CategoryPanelSizer.Add(self.CategorySearchBox, 5, wx.EXPAND | wx.ALL, 5)
        

        # Panel assembly / Montaje de paneles
        self._mgr = PanelManager(self)
        self._mgr.AddPane(self.ProgramsPanel, wx.CENTER)
        self._mgr.AddPane(self.PersonalizationPanel,
            wx.aui.AuiPaneInfo().Name(_('Actions'))
                .Caption(_('Actions'))
                .Right()
                .BestSize((200, 450))
                .MinSize((200, -1))
                .Layer(1)
                .CaptionVisible(False)
                .Floatable(False)
                .Movable(False)
                .PaneBorder(False))
        self._mgr.AddPane(self.CategoryPanel,
            wx.aui.AuiPaneInfo()
                .Name(_('Categories'))
                .Caption(_('Categories'))
                .Left()
                .BestSize((150, 450))
                .MinSize((150, -1))
                .Layer(1)
                .CaptionVisible(False)
                .Floatable(False)
                .Movable(False)
                .PaneBorder(False))

        self.Bind(wx.EVT_SIZE, self.OnResize)
        self.GameCategories = self.LoadGameCategoriesFromFiles()
        self.SelectedProgram = None
        self.selected_category = "all"
        self.GenerateMenuCategory()
        self._mgr.Update()

        # Generates menus bar / Genera barra de menus
        # File menu / Menu de Archivos
        self.FileMenu = wx.Menu()
        if (os.environ["POL_OS"] == "Mac"):
            # On MacOS X, preference is always on the main menu
            # En MacOS X, la preferencia siempre está en el menú principal
            prefItem = self.FileMenu.Append(wx.ID_PREFERENCES, text="&Preferences")
            self.Bind(wx.EVT_MENU, self.Options, prefItem)

        self.FileMenu.Append(wx.ID_OPEN, _("Run"))
        self.FileMenu.Append(wx.ID_ADD, _("Install"))
        self.FileMenu.Append(wx.ID_DELETE, _("Remove"))
        self.FileMenu.AppendSeparator()
        #self.FileMenu.Append(216, _("Donate"))
        self.FileMenu.Append(wx.ID_EXIT, _("Exit"))

        # Display menu / Menu de Vista
        '''
        self.displaymenu = wx.Menu()
        self.icon16 = self.displaymenu.AppendRadioItem(501, _("Small icons"))
        self.icon24 = self.displaymenu.AppendRadioItem(502, _("Medium icons"))
        self.icon32 = self.displaymenu.AppendRadioItem(503, _("Large icons"))
        self.icon48 = self.displaymenu.AppendRadioItem(504, _("Very large icons"))
        if (self.iconSize == 16):
            self.icon16.Check(True)
        if (self.iconSize == 24):
            self.icon24.Check(True)
        if (self.iconSize == 32):
            self.icon32.Check(True)
        if (self.iconSize == 48):
            self.icon48.Check(True)
        '''

        # Expert menu / Menu avanzado
        self.ExpertMenu = wx.Menu()

        # Manager Wine Version / Manejador de versiones de Wine
        self.OptionManagerWineVer = wx.MenuItem(self.ExpertMenu, 107, _("Manage Wine versions"))
        self.OptionManagerWineVer.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/wine.png"))
        self.ExpertMenu.Append(self.OptionManagerWineVer)

        # Read a PC CD-Rom
        if (os.environ["POL_OS"] == "Mac"):
            self.ExpertMenu.AppendSeparator()
            self.ExpertMenu.Append(113, _("Read a PC CD-Rom"))
        else:
            self.ExpertMenu.AppendSeparator()
        
        # Run a local script / Cargar un script local
        self.OptionRunLocalScript = wx.MenuItem(self.ExpertMenu, 108, _("Run a local script"))
        self.OptionRunLocalScript.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/media-playback-start.png"))
        self.ExpertMenu.Append(self.OptionRunLocalScript)

        # PlayOnLinux Console / Consola PlayOnLinux
        self.OptionConsole = wx.MenuItem(self.ExpertMenu, 109, _("Open Console"))
        self.OptionConsole.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/polshell.png"))
        self.ExpertMenu.Append(self.OptionConsole)

        # Close all PlayOnlinux software / Cerrar todas los programas PlayOnLinux
        self.OptionCloseSoftware = wx.MenuItem(self.ExpertMenu, 115, _("Close all software"))
        self.OptionCloseSoftware.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/window-close.png"))
        self.ExpertMenu.Append(self.OptionCloseSoftware)

        # Debugger / Depurador
        self.OptionDebugger = wx.MenuItem(self.ExpertMenu, 110, _("Debugger"))
        self.OptionDebugger.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/bug.png"))
        self.ExpertMenu.Append(self.OptionDebugger)

        # Option Menu / Menu de opciones
        self.SettingMenu = wx.Menu()

        # Internet
        self.OptionInternet = wx.MenuItem(self.SettingMenu, 211, _("Internet"))
        self.OptionInternet.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/internet.png"))
        self.SettingMenu.Append(self.OptionInternet)

        # File Associations / Asociacion de Archivos
        self.OptionFileAssociation = wx.MenuItem(self.SettingMenu, 212, _("File associations"))
        self.OptionFileAssociation.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/extensions.png"))       
        self.SettingMenu.Append(self.OptionFileAssociation)

        # Plugin Manager / Manejador de extensiones
        self.OptionPluginManager = wx.MenuItem(self.SettingMenu, 214, _("Plugin manager"))
        self.OptionPluginManager.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/package-x-generic.png"))
        self.SettingMenu.Append(self.OptionPluginManager)

        # Social Menu / Menu de Redes Sociales
        self.SocialMenu = wx.Menu()

        # Twitter
        self.OptionTwitter = wx.MenuItem(self.SocialMenu, 405, _("Twitter"))
        self.OptionTwitter.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/internet-web-browser.png"))
        self.SocialMenu.Append(self.OptionTwitter)

        # Github
        self.OptionGithub = wx.MenuItem(self.SocialMenu, 406, _("Github"))
        self.OptionGithub.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/preferences-desktop-theme.png"))
        self.SocialMenu.Append(self.OptionGithub)
    
        # Facebook
        self.OptionFacebook = wx.MenuItem(self.SocialMenu, 407, _("Facebook"))
        self.OptionFacebook.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/internet-group-chat.png"))
        self.SocialMenu.Append(self.OptionFacebook)


        # Support Menu / Menu de Soporte
        self.SupportMenu = wx.Menu()

        # Supported software / Soporte Programas
        self.OptionSupportedSoftware = wx.MenuItem(self.SupportMenu, 400, _("Supported software"))
        self.OptionSupportedSoftware.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/call-start.png"))       
        self.SupportMenu.Append(self.OptionSupportedSoftware)

        # News / Noticias
        self.OptionNews = wx.MenuItem(self.SupportMenu, 401, _("News"))
        self.OptionNews.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/icones/document-new.png"))       
        self.SupportMenu.Append(self.OptionNews)

        # Documentation / Documentación
        self.OptionDocumentation = wx.MenuItem(self.SupportMenu, 402, _("Documentation"))
        self.OptionDocumentation.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/setups/about.png"))       
        self.SupportMenu.Append(self.OptionDocumentation)

        # Forums / Foros
        self.OptionForums = wx.MenuItem(self.SupportMenu, 403, _("Forums"))
        self.OptionForums.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/people.png"))       
        self.SupportMenu.Append(self.OptionForums)

        # Bugs / Errores
        self.OptionBugs = wx.MenuItem(self.SupportMenu, 404, _("Bugs"))
        self.OptionBugs.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/bug.png"))       
        self.SupportMenu.Append(self.OptionBugs)

        # Help Menu / Submenu de Ayuda
        self.HelpMenu = wx.Menu()
        self.HelpMenu.Append(wx.ID_ABOUT, _('About {0}').format(os.environ["APPLICATION_TITLE"]))

        # Plugins Menu / Menu de Plugins
        self.PluginsMenu = wx.Menu()
        files = os.listdir(Variables.playonlinux_rep + "/plugins")
        files.sort()
        self.PluginList = []
        self.i = 0
        self.j = 0

        # Plugins
        while (self.i < len(files)):
            if (os.path.exists(Variables.playonlinux_rep + "/plugins/" + files[self.i] + "/scripts/menu")):
                if (os.path.exists(Variables.playonlinux_rep + "/plugins/" + files[self.i] + "/enabled")):
                    self.OptionPlugin = wx.MenuItem(self.ExpertMenu, 300 + self.j, files[self.i])
                    self.OptionPluginIcon = Variables.playonlinux_rep + "/plugins/" + files[self.i] + "/icon"

                    if (os.path.exists(self.OptionPluginIcon)):
                        self.bitmap = wx.Bitmap(self.OptionPluginIcon)
                    else:
                        self.bitmap = wx.Bitmap(Variables.playonlinux_env + "/etc/playonlinux16.png")

                    self.OptionPlugin.SetBitmap(self.bitmap)
                    self.PluginsMenu.Append(self.OptionPlugin)
                    self.Bind(wx.EVT_MENU, self.run_plugin, id=300 + self.j)
                    self.PluginList.append(files[self.i])
                    self.j += 1
            self.i += 1

        if (self.j > 0):
            self.PluginsMenu.AppendSeparator()

        # Plugin Manager / Manejador de Plugin
        self.OptionPluginManager = wx.MenuItem(self.PluginsMenu, 214, _("Plugin manager"))
        self.OptionPluginManager.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/etc/onglet/package-x-generic.png"))

        self.PluginsMenu.Append(self.OptionPluginManager)

        self.last_string = ""

        # Barra de estado
        self.sb = wx.StatusBar(self, -1)
        self.sb.SetFieldsCount(2)
        self.sb.SetStatusWidths([self.GetSize()[0], -1])
        self.sb.SetStatusText("", 0)

        if (os.environ["POL_OS"] == "Mac"):
            hauteur = 2
        else:
            hauteur = 6
        self.jauge_update = wx.Gauge(self.sb, -1, 100, (self.GetSize()[0] - 100, hauteur), size=(100, 16))
        self.jauge_update.Pulse()
        self.jauge_update.Hide()
        self.SetStatusBar(self.sb)

        # Menus bar / Barra de menu
        self.MenuBar = wx.MenuBar()
        self.MenuBar.Append(self.FileMenu, _("File"))
        self.MenuBar.Append(self.ExpertMenu, ("Tools"))
        self.MenuBar.Append(self.SettingMenu, ("Settings"))
        self.MenuBar.Append(self.PluginsMenu, _("Plugins"))
        self.MenuBar.Append(self.SupportMenu, _("Support"))
        self.MenuBar.Append(self.SocialMenu, _("Social"))
        self.MenuBar.Append(self.HelpMenu, _("Help"))
        # self.MenuBar.Append(self.displaymenu, _("Display"))
        # self.MenuBar.Append(self.HelpMenu, _("About"))

        self.SetMenuBar(self.MenuBar)
        iconSize = (32, 32)

        # Tool bar / Barra de herramientas
        self.ToolBar = self.CreateToolBar(wx.TB_TEXT)
        self.ToolBar.SetToolBitmapSize(iconSize)
        #self.searchbox = wx.SearchCtrl(self.ToolBar, 124, style=wx.RAISED_BORDER)
        self.playTool = self.ToolBar.AddTool(wx.ID_OPEN, _("Run"), 
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/play.png"))
        self.stopTool = self.ToolBar.AddTool(123, _("Close"), 
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/stop.png"))
        self.ToolBar.AddSeparator()
        self.ToolBar.AddTool(wx.ID_ADD, _("Install"), 
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/install.png"))
        self.removeTool = self.ToolBar_remove = self.ToolBar.AddTool(wx.ID_DELETE, _("Remove"), 
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/delete.png"))
        self.ToolBar.AddSeparator()
        self.ToolBar.AddTool(121, _("Configure"), 
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/configure.png"))
        self.ToolBar.AddTool(125, _("Extras"),
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/toolbar/emblem-downloads.png"))
        
        try:
            self.ToolBar.AddStretchableSpace()
            self.SpaceHack = False
        except:
            #  wxpython 2.8 does not support AddStretchableSpace(). This is a dirty workaround for this.
            #  wxpython 2.8 no admite AddStretchableSpace(). Esta es una solución sucia para esto.
            self.dirtyHack = wx.StaticText(self.ToolBar)
            self.SpaceHack = True
            self.ToolBar.AddControl(self.dirtyHack)
            self.UpdateSearchHackSize()

        # Search box / Caja de busqueda
        '''
        try:
            self.ToolBar.AddControl(self.searchbox, _("Search"))
        except:
            self.ToolBar.AddControl(self.searchbox)
            self.searchbox.SetDescriptiveText(_("Search"))
        '''

        # Event control / Control de eventos
        self.ToolBar.Realize()
        self.Reload(self)
        self.Bind(wx.EVT_MENU, self.Run, id=wx.ID_OPEN)
        self.Bind(wx.EVT_MENU, self.RKill, id=123)

        self.Bind(wx.EVT_MENU, self.InstallMenu, id=wx.ID_ADD)
        self.Bind(wx.EVT_MENU, self.About, id=wx.ID_ABOUT)
        self.Bind(wx.EVT_MENU, self.ClosePol, id=wx.ID_EXIT)
        self.Bind(wx.EVT_MENU, self.UninstallGame, id=wx.ID_DELETE)

        # Display / Eventos del menu de vista
        self.Bind(wx.EVT_MENU, self.iconDisplay, id=501)
        self.Bind(wx.EVT_MENU, self.iconDisplay, id=502)
        self.Bind(wx.EVT_MENU, self.iconDisplay, id=503)
        self.Bind(wx.EVT_MENU, self.iconDisplay, id=504)

        # Expert / Eventos del menu avanzado
        self.Bind(wx.EVT_MENU, self.Reload, id=101)
        self.Bind(wx.EVT_MENU, self.WineVersion, id=107)
        self.Bind(wx.EVT_MENU, self.Executer, id=108)
        self.Bind(wx.EVT_MENU, self.PolShell, id=109)
        self.Bind(wx.EVT_MENU, self.BugReport, id=110)
        self.Bind(wx.EVT_MENU, self.POLOnline, id=112)
        self.Bind(wx.EVT_MENU, self.PCCd, id=113)
        self.Bind(wx.EVT_MENU, self.killall, id=115)
        self.Bind(wx.EVT_MENU, self.Configure, id=121)
        self.Bind(wx.EVT_MENU, self.Package, id=122)
        self.Bind(wx.EVT_TEXT, self.Reload, id=124)

        # Options / Eventos del menu de opciones
        self.Bind(wx.EVT_MENU, self.Options, id=210)
        self.Bind(wx.EVT_MENU, self.Options, id=211)
        self.Bind(wx.EVT_MENU, self.Options, id=212)
        self.Bind(wx.EVT_MENU, self.Options, id=213)
        self.Bind(wx.EVT_MENU, self.Options, id=214)
        self.Bind(wx.EVT_MENU, self.Options, id=215)

        self.Bind(wx.EVT_MENU, self.Donate, id=216)

        self.Bind(wx.EVT_CLOSE, self.ClosePol)
        self.Bind(wx.EVT_TREE_ITEM_ACTIVATED, self.Run, id=105)
        self.Bind(wx.EVT_TREE_SEL_CHANGED, self.Select, id=105)

        # Social / Eventos del menu de redes sociales
        self.Bind(wx.EVT_MENU, self.runSupport, id=405)
        self.Bind(wx.EVT_MENU, self.runSupport, id=406)
        self.Bind(wx.EVT_MENU, self.runSupport, id=407)

        # Support / Eventos del menu de soporte
        self.Bind(wx.EVT_MENU, self.runSupport, id=400)
        self.Bind(wx.EVT_MENU, self.runSupport, id=401)
        self.Bind(wx.EVT_MENU, self.runSupport, id=402)
        self.Bind(wx.EVT_MENU, self.runSupport, id=403)
        self.Bind(wx.EVT_MENU, self.runSupport, id=404)

        # PlayOnLinux main timer / Temporizador principal de PlayOnlinux
        self.timer = wx.Timer(self, 1)
        self.Bind(wx.EVT_TIMER, self.TimerAction, self.timer)
        self.timer.Start(1000)
        self.Timer_LastShortcutList = None
        self.Timer_LastIconList = None

        # SetupWindow timer. The server is in another thread and GUI must be run from the main thread
        # SetupWindow Timer. El servidor está en otro hilo y la GUI debe ejecutarse desde el hilo principal.
        self.SetupWindowTimer = wx.Timer(self, 2)
        self.Bind(wx.EVT_TIMER, self.SetupWindowAction, self.SetupWindowTimer)
        self.SetupWindowTimer_action = None
        self.SetupWindowTimer.Start(100)
        self.SetupWindowTimer_delay = 100

        # Pop-up menu for game list: beginning
        # Menú emergente para la lista de juegos: comienzo
        self.Bind(wx.EVT_TREE_ITEM_MENU, self.RMBInGameList, id=105)
        self.Bind(wx.EVT_MENU, self.RWineConfigurator, id=230)
        self.Bind(wx.EVT_MENU, self.RRegistryEditor, id=231)
        self.Bind(wx.EVT_MENU, self.GoToAppDir, id=232)
        self.Bind(wx.EVT_MENU, self.ChangeIcon, id=233)
        self.Bind(wx.EVT_MENU, self.UninstallGame, id=234)
        self.Bind(wx.EVT_MENU, self.RKill, id=235)
        self.Bind(wx.EVT_MENU, self.ReadMe, id=236)
        self.Bind(wx.EVT_SIZE, self.ResizeWindow)

        self._mgr.RestorePosition()
        self.PersonalizationPanel.SetAutoLayout(True)
    def GenerateMenuCategory(self):
        # Limpia el panel izquierdo
        self.CategoryPanel.Freeze()
        for child in self.CategoryPanel.GetChildren():
            child.Destroy()
        self.menuElem = {}

        # Obtén el listado de categorías posibles
        icons_dir = "/usr/share/playonlinux/resources/images/install/32/"
        Categories = [
            ("all", _("All"), "view-refresh.png"),
            ("games", _("Games"), "applications-games.png"),
            ("utilities", _("Utilities"), "applications-accessories.png"),
            ("productivity", _("Productivity"), "applications-office.png"),
            ("multimedia", _("Multimedia"), "applications-multimedia.png"),
            # ...agrega más si quieres...
        ]

        # Cuenta los juegos por categoría
        catCounts = collections.Counter(self.GameCategories.get(game, "other") for game in self.games)
        # Solo muestra categorías activas
        ActiveCategories = [
            (key, label, icon) for key, label, icon in Categories
            if key == "all" or catCounts.get(key, 0) > 0
        ]

        # Sizer vertical
        sizer = wx.BoxSizer(wx.VERTICAL)
        side_margin = 2

        # Barra de búsqueda (si la quieres)
        if hasattr(self, "CategorySearchBox"):
            sizer.Add(self.CategorySearchBox, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.TOP, side_margin)
            sizer.Add((0, 6))

        # Botones de categorías activas
        for i, (key, label, icon_file) in enumerate(ActiveCategories):
            icon_path = os.path.join(icons_dir, icon_file)
            btn_panel = self.MenuGaucheAddSimpleButton(
                f"cat_{i}", label, i, icon_path,
                lambda evt, c=key: self.OnCategorySelected(c),
                parent=self.CategoryPanel
            )
            sizer.Add(btn_panel, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, side_margin)

        self.CategoryPanel.SetSizer(sizer)
        self.CategoryPanel.Layout()
        self.CategoryPanel.Thaw()

    def ConfigureGame(self):
        if self.SelectedProgram:
            print(f"Configurar: {self.SelectedProgram}")
            # Aquí iría el código real para abrir la configuración

    def LaunchGame(self, event):
        widget = event.GetEventObject()
        game_name = widget.GetName()
        if game_name:
            self.SelectedProgram = game_name  # <--- guardar la selección
            shortcut_path = os.path.expanduser(f'~/.PlayOnLinux/shortcuts/\"{game_name}\"')
            os.system(f'{shortcut_path} &')

    def LoadGameCategoriesFromFiles(self):
        dataDir = os.path.expanduser("~/.PlayOnLinux/icones/data/")
        GameCategories = {}
        if os.path.exists(dataDir):
            for fname in os.listdir(dataDir):
                if fname.endswith(".csv"):
                    gameName = fname[:-4]
                    with open(os.path.join(dataDir, fname), encoding="utf-8") as f:
                        category = f.read().strip().lower()
                    GameCategories[gameName] = category
        return GameCategories

    def OnCategoryClear(self, event):
        self.CategorySearchBox.SetValue("")
        self.OnSearch(None)

    def OnGameRightClick(self, event):
        widget = event.GetEventObject()
        game_name = widget.GetName()

        # Guardamos el juego como seleccionado (sirve para otros botones)
        self.SelectedProgram = game_name

        # Creamos el menú contextual
        menu = wx.Menu()
        item_run = menu.Append(wx.ID_ANY, f"Ejecutar {game_name}")
        item_config = menu.Append(wx.ID_ANY, "Configurar")
        item_remove = menu.Append(wx.ID_ANY, "Quitar")

        # Asignamos funciones a las opciones del menú
        self.Bind(wx.EVT_MENU, lambda evt: self.LaunchGame(event), item_run)
        self.Bind(wx.EVT_MENU, lambda evt: self.ConfigureGame(), item_config)
        self.Bind(wx.EVT_MENU, lambda evt: self.RemoveGame(), item_remove)

        # Mostramos el menú
        self.PopupMenu(menu)
        menu.Destroy()

    def OnHover(self, event):
        event.GetEventObject().SetCursor(wx.Cursor(wx.CURSOR_HAND))
        event.Skip()

    def OnLeave(self, event):
        event.GetEventObject().SetCursor(wx.Cursor(wx.CURSOR_ARROW))
        event.Skip()

    def OnResize(self, event):
        event.Skip()
        
        # Ajustar tamaño del panel derecho
        pane_info = self._mgr.GetPane(self.PersonalizationPanel)
        pane_info.BestSize((270, self.GetSize().height - 50))
        self._mgr.Update()
        
        # Forzar redibujado del contenido
        if hasattr(self, 'menuElem'):
            for item in self.menuElem.values():
                item.Wrap(250)  # Reajustar texto al nuevo ancho
        
        self.ProgramsPanel.Layout()
        self.ProgramsPanel.FitInside()
        event.Skip()



    def RemoveGame(self):
        if self.SelectedProgram:
            print(f"Quitar: {self.SelectedProgram}")
            # Aquí iría el código real para eliminar el juego

    def RMBInGameList(self, event):
        self.GameListPopUpMenu = wx.Menu()

        self.ConfigureWine = wx.MenuItem(self.GameListPopUpMenu, 230, _("Configure Wine"))
        self.ConfigureWine.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/run.png"))
        self.GameListPopUpMenu.AppendItem(self.ConfigureWine)

        self.RegistryEditor = wx.MenuItem(self.GameListPopUpMenu, 231, _("Registry Editor"))
        self.RegistryEditor.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/regedit.png"))
        self.GameListPopUpMenu.AppendItem(self.RegistryEditor)

        self.GotoAppDir = wx.MenuItem(self.GameListPopUpMenu, 232, _("Open the application's directory"))
        self.GotoAppDir.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/folder-wine.png"))
        self.GameListPopUpMenu.AppendItem(self.GotoAppDir)

        self.ChangeIcon = wx.MenuItem(self.GameListPopUpMenu, 236, _("Read the manual"))
        self.ChangeIcon.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/manual.png"))
        self.GameListPopUpMenu.AppendItem(self.ChangeIcon)

        self.ChangeIcon = wx.MenuItem(self.GameListPopUpMenu, 233, _("Set the icon"))
        self.ChangeIcon.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/change_icon.png"))
        self.GameListPopUpMenu.AppendItem(self.ChangeIcon)

        self.ChangeIcon = wx.MenuItem(self.GameListPopUpMenu, 234, _("Remove"))
        self.ChangeIcon.SetBitmap(wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/delete.png"))
        self.GameListPopUpMenu.AppendItem(self.ChangeIcon)

        self.ChangeIcon = wx.MenuItem(self.GameListPopUpMenu, 235, _("Close this application"))
        self.ChangeIcon.SetBitmap(
            wx.Bitmap(Variables.playonlinux_env + "/resources/images/menu/media-playback-stop.png"))
        self.GameListPopUpMenu.AppendItem(self.ChangeIcon)

        self.PopupMenu(self.GameListPopUpMenu, event.GetPoint())

    def RWineConfigurator(self, event):
        self.RConfigure("winecfg")

    def ResizeWindow(self, e):
        self.UpdateGaugePos()
        self.UpdateSearchHackSize()

    def SetupWindowAction(self, event):
        if (self.windowOpened == 0):
            self.SetupWindow_TimerRestart(100)
        else:
            self.SetupWindow_TimerRestart(10)

        if (self.SetupWindowTimer_action != None):
            return GuiServer.readAction(self)

    def SetupWindowTimer_SendToGui(self, recvData):
        recvData = recvData.split("\t")
        while (self.SetupWindowTimer_action != None):
            time.sleep(0.1)
        self.SetupWindowTimer_action = recvData

    def SetupWindow_TimerRestart(self, time):
        if (time != self.SetupWindowTimer_delay):
            self.SetupWindowTimer.Stop()
            self.SetupWindowTimer.Start(time)
            self.SetupWindowTimer_delay = time

    def StatusRead(self):
        self.sb.SetStatusText(self.Updater.SendToStatusBarStr, 0)
        if (self.Updater.Gauge == True):
            Perc = self.Updater.Perc
            if (Perc == -1):
                self.jauge_update.Pulse()
            else:
                try:
                    self.installFrame.percentageText.SetLabel(str(Perc) + " %")
                except:
                    pass
                self.jauge_update.SetValue(Perc)
            self.jauge_update.Show()
        else:
            self.jauge_update.Hide()

        try:
            if (self.Updater.updating == True):
                self.sb.Show()
                ## TODO: Refactor
                self.installFrame.setWaitState(True)
            else:
                self.sb.Hide()
                self.installFrame.setWaitState(False)
                self.installFrame.Refresh()
        except RuntimeError:
            pass
        except AttributeError:  # FIXME: Install Frame is not opened
            pass

        if (self.Updater.SendAlertStr != self.SendAlertStr):
            wx.MessageBox(self.Updater.SendAlertStr, os.environ["APPLICATION_TITLE"], wx.OK | wx.CENTER, self)
            self.SendAlertStr = self.Updater.SendAlertStr

    def TimerAction(self, event):
        self.StatusRead()

        # We read shortcut folder to see if it has to be rescanned
        currentShortcuts = os.path.getmtime(Variables.playonlinux_rep + "/shortcuts")
        currentIcons = os.path.getmtime(Variables.playonlinux_rep + "/icones/32")
        if (currentShortcuts != self.Timer_LastShortcutList or currentIcons != self.Timer_LastIconList):
            self.Reload(self)
            self.Timer_LastShortcutList = currentShortcuts
            self.Timer_LastIconList = currentIcons

    def UpdateSearchHackSize(self):
        if (self.SpaceHack == True):
            self.dirtyHack.SetLabel("")
            self.dirtyHack.SetSize((50, 1))

    def UpdateGaugePos(self):
        if (os.environ["POL_OS"] == "Mac"):
            hauteur = 2
        else:
            hauteur = 6
        self.jauge_update.SetPosition((self.GetSize()[0] - 100, hauteur))






    def RKill(self, event):
        self.RConfigure("kprocess")

    def ReadMe(self, event):
        game_exec = self.GetSelectedProgram()
        if (os.path.exists(os.environ["POL_USER_ROOT"] + "/configurations/manuals/" + game_exec)):
            PlayOnLinux.POL_Open(os.environ["POL_USER_ROOT"] + "/configurations/manuals/" + game_exec)
        else:
            wx.MessageBox(_("No manual found for {0}").format(game_exec), os.environ["APPLICATION_TITLE"])

    def RRegistryEditor(self, event):
        self.RConfigure("regedit")

    def run_plugin(self, event):
        game_exec = self.GetSelectedProgram()
        plugin = self.PluginList[event.GetId() - 300]
        try:
            subprocess.Popen(["bash", Variables.playonlinux_rep + "/plugins/" + plugin + "/scripts/menu", game_exec])
        except:
            pass

    # Gestion de Menu de soporte
    def runSupport(self, event):
        urlId = event.GetId() - 400
        urlPrefix = "http://www." + os.environ["POL_DNS"] + "/en"
        if (urlId == 0):
            url = urlPrefix + "/supported_apps.html"
        if (urlId == 1):
            url = urlPrefix + "/news.html"
        if (urlId == 2):
            url = urlPrefix + "/documentation.html"
        if (urlId == 3):
            url = urlPrefix + "/forums.html"
        if (urlId == 4):
            url = urlPrefix + "/bugs.html"

        if (urlId == 5):
            if (os.environ["POL_OS"] == "Mac"):
                url = "https://x.com/PlayOnMac"
            else:
                url = "https://x.com/PlayOnLinux"

        if (urlId == 6):
            if (os.environ["POL_OS"] == "Mac"):
                url = "https://github.com/PhoenicisOrg"
            else:
                url = "https://github.com/PhoenicisOrg"

        if (urlId == 7):
            if (os.environ["POL_OS"] == "Mac"):
                url = "https://www.facebook.com/playonmac"
            else:
                url = "https://www.facebook.com/playonlinux"

        PlayOnLinux.POL_Open(url)

    def iconDisplay(self, event):
        iconEvent = event.GetId()

        if (iconEvent == 501):
            self.iconSize = 16
        if (iconEvent == 502):
            self.iconSize = 24
        if (iconEvent == 503):
            self.iconSize = 32
        if (iconEvent == 504):
            self.iconSize = 48

        PlayOnLinux.SetSettings("ICON_SIZE", str(self.iconSize))
        self.ProgramsPanel.SetImageList(self.imagesEmpty)
        self.images.Destroy()
        self.images = wx.ImageList(self.iconSize, self.iconSize)
        self.ProgramsPanel.SetImageList(self.images)

        self.Reload(self)

    def UpdateInstructions(self, event):
        if (os.environ["POL_OS"] == "Mac"):
            webbrowser.open("http://www.playonmac.com/en/download.html")
        else:
            webbrowser.open("http://www.playonlinux.com/en/download.html")

    def UpdateGIT(self, event):
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/update_git"])

    def GoToAppDir(self, event):
        self.game_exec = self.GetSelectedProgram()
        if not PlayOnLinux.GetSettings("OPEN_IN", PlayOnLinux.getPrefix(self.game_exec)):
            PlayOnLinux.open_folder(self.game_exec)
        else:
            PlayOnLinux.open_folder(self.game_exec,
                                    PlayOnLinux.GetSettings("OPEN_IN", PlayOnLinux.getPrefix(self.game_exec)))

    def ChangeIcon(self, event):
        self.IconDir = Variables.homedir + "/.local/share/icons/"
        self.SupprotedIconExt = r"All|*.xpm;*.XPM;*.png;*.PNG;*.ico;*.ICO;*.jpg;*.JPG;*.jpeg;*.JPEG;*.bmp;*.BMP\
        \|XPM (*.xpm)|*.xpm;*.XPM\
        \|PNG (*.png)|*.png;*.PNG\
        \|ICO (*.ico)|*.ico;*.ICO\
        \|JPG (*.jpg)|*.jpg;*.JPG\
        \|BMP (*.bmp)|*.bmp;*.BMP\
        \|JPEG (*.jpeg)|*.jpeg;*JPEG"
        self.IconDialog = wx.FileDialog(self, "Choose a icon file", self.IconDir, "", self.SupprotedIconExt,
                                        wx.OPEN | wx.FD_PREVIEW)
        if self.IconDialog.ShowModal() == wx.ID_OK:
            self.IconFilename = self.IconDialog.GetFilename()
            self.IconDirname = self.IconDialog.GetDirectory()
            IconFile = os.path.join(self.IconDirname, self.IconFilename)
            self.RConfigure("changeicon", IconFile)
            self.IconDialog.Destroy()
            # Pop-up menu for game list: ending

    def Select(self, event):
        game_exec = self.GetSelectedProgram()
        self.read = open(Variables.playonlinux_rep + "shortcuts/" + game_exec, "r").readlines()
        self.i = 0
        self.wine_present = False
        while (self.i < len(self.read)):
            if ("wine " in self.read[self.i]):
                self.wine_present = True
            self.i += 1

        self.GenerateMenuPanel(game_exec)
        self.playTool.Enable(True)
        self.stopTool.Enable(True)
        self.removeTool.Enable(True)

    # Genera el menu del panel izquierdo
    def GenerateMenuCategory(self):
        self.CategoryPanel.Freeze()
        for child in self.CategoryPanel.GetChildren():
            child.Destroy()
        self.menuElem = {}

        self.CategoryPanel.SetBackgroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_BTNFACE))
        sizer = wx.BoxSizer(wx.VERTICAL)

        # Barra de búsqueda
        self.CategorySearchBox = wx.SearchCtrl(self.CategoryPanel, style=wx.TE_PROCESS_ENTER)
        self.CategorySearchBox.SetDescriptiveText(_("Search"))
        self.CategorySearchBox.Bind(wx.EVT_TEXT, self.OnSearch)
        sizer.Add(self.CategorySearchBox, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.TOP, 2)
        sizer.Add((0, 6))  # Espaciador opcional

        icons_dir = "/usr/share/playonlinux/resources/images/install/32/"
        Categories = [
            ("all", _("All"), "view-refresh.png"),
            ("games", _("Games"), "applications-games.png"),
            ("utilities", _("Utilities"), "applications-accessories.png"),
            ("productivity", _("Productivity"), "applications-office.png"),
            ("multimedia", _("Multimedia"), "applications-multimedia.png"),
            ("internet", _("Internet"), "applications-internet.png"),
            ("graphics", _("Graphics"), "applications-graphics.png"),
            ("development", _("Development"), "applications-development.png"),
            ("science", _("Science"), "applications-science.png"),
            ("system", _("System"), "applications-system.png"),
            ("other", _("Other"), "applications-other.png"),
        ]

        # Obtener lista de juegos
        self.Games = os.listdir(Variables.playonlinux_rep + "shortcuts/")
        self.Games.sort(key=str.upper)

        # Contar juegos por categoría
        CatCounts = collections.Counter(self.GameCategories.get(game, "other") for game in self.Games)

        # Solo categorías con juegos
        ActiveCategories = [
            (key, label, icon)
            for key, label, icon in Categories
            if key == "all" or CatCounts.get(key, 0) > 0
        ]

        for i, (key, label, icon_file) in enumerate(Categories):
            icon_path = os.path.join(icons_dir, icon_file)
            btn_panel = self.MenuGaucheAddSimpleButton(
                f"cat_{i}", label, i, icon_path,
                lambda evt, c=key: self.OnCategorySelected(c),  # key, no label
                parent=self.CategoryPanel
            )
            sizer.Add(btn_panel, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 2)

        self.CategoryPanel.SetSizer(sizer)
        self.CategoryPanel.Layout()
        self.CategoryPanel.Thaw()

    # Genera el menu del panel derecho
    def GenerateMenuPanel(self, shortcut=None):
        self.PersonalizationPanel.Freeze()
        for child in self.PersonalizationPanel.GetChildren():
            child.Destroy()
        self.menuElem = {}

        self.PersonalizationPanel.SetBackgroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_BTNFACE))
        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add((0, 12))

        # Título principal
        self.MenuGaucheAddTitle("main_title", "PlayOnLinux", 0, parent=self.PersonalizationPanel, sizer=sizer)
        sizer.Add((0, 12))

        # Botón para instalar programa
        btn_install = self.MenuGaucheAddSimpleButton(
            "install_btn",
            _("Install a program"),
            1,
            "/usr/share/playonlinux/resources/images/menu/add.png",
            self.InstallMenu,
            parent=self.PersonalizationPanel
        )
        sizer.Add(btn_install, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 2)

        # Botón de preferencias
        btn_prefs = self.MenuGaucheAddSimpleButton(
            "prefs_btn",
            _("Settings"),
            2,
            "/usr/share/playonlinux/resources/images/menu/settings.png",
            self.Configure,
            parent=self.PersonalizationPanel
        )
        sizer.Add(btn_prefs, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 2)

        # Si hay acceso directo seleccionado, muestra icono y acciones
        if shortcut:
            self.MenuGaucheAddTitle("game_title", shortcut, 3, parent=self.PersonalizationPanel, sizer=sizer)
            sizer.Add((0, 8))

            icon_path = os.path.join(Variables.playonlinux_rep, "icones/full_size", shortcut)
            if os.path.exists(icon_path):
                img = wx.Image(icon_path)
                img.Rescale(64, 64)
                icon_bitmap = wx.StaticBitmap(self.PersonalizationPanel, bitmap=img.ConvertToBitmap())
                sizer.Add(icon_bitmap, 0, wx.ALIGN_CENTER | wx.BOTTOM, 2)

            actions = [
                (_("Run"), "media-playback-start.png", self.Run),
                (_("Configure"), "run.png", self.Configure),
                (_("Uninstall"), "window-close.png", self.UninstallGame)
            ]
            for i, (text, icon, handler) in enumerate(actions):
                btn_action = self.MenuGaucheAddSimpleButton(
                    f"action_{i}",
                    text,
                    4 + i,
                    os.path.join(Variables.playonlinux_env, "resources/images/menu", icon),
                    handler,
                    parent=self.PersonalizationPanel
                )
                sizer.Add(btn_action, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 2)

        self.PersonalizationPanel.SetSizer(sizer)
        self.PersonalizationPanel.Layout()
        self.PersonalizationPanel.Thaw()

    # Buscar Juegos
    def OnSearch(self, event):
        self.filtered_query = self.CategorySearchBox.GetValue().lower()
        self.Reload()

    # Filtrar por categorias
    def OnCategorySelected(self, category):
        self.selected_category = category
        self.Reload()

    # Boton de los paneles
    def MenuGaucheAddSimpleButton(self, id, text, pos, icon_path, handler, parent=None):
        if parent is None:
            parent = self.PersonalizationPanel

        btn_panel = wx.Panel(parent)
        btn_panel.SetBackgroundColour(wx.NullColour)

        h_sizer = wx.BoxSizer(wx.HORIZONTAL)
        v_sizer = wx.BoxSizer(wx.VERTICAL)

        # Icono
        icon_bitmap = None
        if icon_path and os.path.exists(icon_path):
            img = wx.Image(icon_path)
            img.Rescale(20, 20)
            icon_bitmap = wx.StaticBitmap(btn_panel, bitmap=img.ConvertToBitmap())
            h_sizer.Add(icon_bitmap, 0, wx.ALIGN_CENTER_VERTICAL | wx.LEFT, 6)

        # Texto
        btn_text = wx.StaticText(btn_panel, label=text)
        btn_text.SetForegroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_WINDOWTEXT))
        font = btn_text.GetFont()
        font.SetPointSize(11)
        btn_text.SetFont(font)
        h_sizer.Add(btn_text, 1, wx.ALIGN_CENTER_VERTICAL | wx.LEFT, 6)
        v_sizer.Add(h_sizer, 1, wx.EXPAND | wx.ALL, 6) 

        btn_panel.SetSizer(v_sizer)

        # Eventos hover/click
        btn_panel.Bind(wx.EVT_ENTER_WINDOW, self.onButtonHover)
        btn_panel.Bind(wx.EVT_LEAVE_WINDOW, self.onButtonLeave)
        if handler:
            btn_panel.Bind(wx.EVT_LEFT_DOWN, lambda e: handler(e))

        btn_panel.text_component = btn_text
        btn_panel.icon_component = icon_bitmap
        self.menuElem[id] = btn_panel

        return btn_panel  # ¡NO lo agregues aquí al sizer del parent!

    def onButtonHover(self, event):
        panel = event.GetEventObject()
        panel.SetBackgroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_HIGHLIGHT))  # Azul muy suave con transparencia
        if hasattr(panel, 'text_component'):
            panel.text_component.SetForegroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_HIGHLIGHTTEXT))
        if hasattr(panel, 'icon_component') and panel.icon_component:
            # Opcional: cambiar ligeramente el icono
            pass
        panel.Refresh()

    def onButtonLeave(self, event):
        panel = event.GetEventObject()
        panel.SetBackgroundColour(wx.NullColour)
        if hasattr(panel, 'text_component'):
            panel.text_component.SetForegroundColour(
                wx.SystemSettings.GetColour(wx.SYS_COLOUR_WINDOWTEXT)
            )
        panel.Refresh()

    def MenuGaucheAddButton(self, id, text, pos, icon_path, handler, small=False):
        btn_panel = wx.Panel(self.PersonalizationPanel, pos=(0, 20 + pos * 40), size=(270, 40))
        btn_panel.SetBackgroundColour(wx.Colour(250, 250, 250))
        
        # Icono
        if os.path.exists(icon_path):
            img = wx.Image(icon_path, wx.BITMAP_TYPE_ANY)
            img.Rescale(24, 24, wx.IMAGE_QUALITY_HIGH)
            bmp = wx.StaticBitmap(btn_panel, bitmap=img.ConvertToBitmap(), pos=(15, 8))
        
        # Texto
        btn = wx.Button(
            btn_panel,
            label=text,
            pos=(50, 5),
            size=(200, 30) if not small else (180, 25),
            style=wx.BORDER_NONE
        )
        btn.SetForegroundColour(wx.Colour(70, 70, 70))
        btn.SetFont(wx.Font(10 if not small else 9, wx.FONTFAMILY_DEFAULT, 
                        wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL))
        btn.Bind(wx.EVT_BUTTON, handler)
        
        # Efecto hover
        btn_panel.Bind(wx.EVT_ENTER_WINDOW, lambda e: btn_panel.SetBackgroundColour(wx.Colour(230, 240, 255)))
        btn_panel.Bind(wx.EVT_LEAVE_WINDOW, lambda e: btn_panel.SetBackgroundColour(wx.Colour(250, 250, 250)))
        
        self.menuElem[id] = btn_panel
        return btn_panel

    def MenuGaucheAddSeparator(self, pos):
        sep = wx.StaticLine(
            self.PersonalizationPanel,
            pos=(15, 20 + pos * 40),
            size=(240, 1),
            style=wx.LI_HORIZONTAL
        )
        sep.SetBackgroundColour(wx.Colour(220, 220, 220))
        self.menuElem[f"separator_{pos}"] = sep
        return sep

    def MenuGaucheAddInfoPanel(self, id, info_items, start_pos):
        panel = wx.Panel(self.PersonalizationPanel, pos=(0, 20 + start_pos * 40), size=(270, len(info_items) * 25 + 10))
        panel.SetBackgroundColour(wx.Colour(245, 245, 245))
        
        for i, (key, value) in enumerate(info_items.items()):
            wx.StaticText(panel, label=f"{key}:", pos=(15, 5 + i * 25)).SetFont(
                wx.Font(9, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD))
            wx.StaticText(panel, label=value, pos=(120, 5 + i * 25)).SetFont(
                wx.Font(9, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL))
        
        self.menuElem[id] = panel
        return panel

    def getGameDetails(self, game_name):
        details = {}
        try:
            # Ejemplo de información que puedes obtener
            prefix = PlayOnLinux.getPrefix(game_name)
            details[_("Prefix")] = prefix
            details[_("Wine version")] = self.getWineVersion(game_name)
            details[_("Install date")] = time.ctime(os.path.getctime(
                os.path.join(Variables.playonlinux_rep, "shortcuts", game_name)))
            details[_("Size")] = self.getFolderSize(
                os.path.join(os.environ["POL_USER_ROOT"], "wineprefix", prefix))
        except:
            pass
        return details

    # Agregar Titulo para el panel para la derecha
    def MenuGaucheAddTitle(self, id, text, pos, parent=None, sizer=None):
        if parent is None:
            parent = self.PersonalizationPanel
        if sizer is None:
            sizer = parent.GetSizer() if parent.GetSizer() else wx.BoxSizer(wx.VERTICAL)
            parent.SetSizer(sizer)

        title = wx.StaticText(parent, label=text)
        font = title.GetFont()
        font.SetPointSize(13)
        font.SetWeight(wx.FONTWEIGHT_BOLD)
        title.SetFont(font)
        title.SetForegroundColour(wx.WHITE)
        sizer.Add(title, 0, wx.ALL | wx.ALIGN_LEFT, 8)
        self.menuElem[id] = title
        return title

    # Efectos Hover para los titulos
    def onTitleHover(self, panel, is_hover):
        if is_hover:
            panel.SetBackgroundColour(wx.Colour(*[min(255, c+20) for c in panel.GetBackgroundColour().Get()]))
        else:
            panel.SetBackgroundColour(wx.SystemSettings.GetColour(wx.SYS_COLOUR_ACTIVECAPTION))
        panel.Refresh()

    def MenuGaucheAddLink(self, id, text, pos, image, evt, url=None):
        if (os.path.exists(image)):
            menu_icone = image
        else:
            menu_icone = Variables.playonlinux_env + "/etc/playonlinux.png"

        try:
            self.bitmap = wx.Image(menu_icone)
            self.bitmap.Rescale(16, 16, wx.IMAGE_QUALITY_HIGH)
            self.bitmap = self.bitmap.ConvertToBitmap()
            self.menuImage[id] = wx.StaticBitmap(self.PersonalizationPanel, id=-1, bitmap=self.bitmap, pos=(10, 15 + pos * 20))

        except:
            pass

        if (url == None):
            self.menuElem[id] = wx.lib.agw.hyperlink.HyperLinkCtrl(self.PersonalizationPanel, 10000 + pos, text,
                                                               pos=(35, 15 + pos * 20))
            self.menuElem[id].AutoBrowse(False)
        else:
            self.menuElem[id] = wx.lib.agw.hyperlink.HyperLinkCtrl(self.PersonalizationPanel, 10000 + pos, text,
                                                               pos=(35, 15 + pos * 20))
            self.menuElem[id].setURL(url)

        self.menuElem[id].SetColours(wx.Colour(0, 0, 0), wx.Colour(0, 0, 0), wx.Colour(0, 0, 0))
        self.menuElem[id].UpdateLink(True)
        # self.menuElem[id].SetVisited(False)
        # self.menuElem[id].SetNormalColour(wx.Colour(0,0,0))
        # self.menuElem[id].SetVisitedColour(wx.Colour(0,0,0))
        # self.menuElem[id].SetHoverColour(wx.Colour(100,100,100))

        if (evt != None):
            self.Bind(wx.lib.agw.hyperlink.EVT_HYPERLINK_LEFT, evt, id=10000 + pos)

    def Donate(self, event):
        if (os.environ["POL_OS"] == "Mac"):
            webbrowser.open("http://www.playonmac.com/en/Donate.html")
        else:
            webbrowser.open("http://www.playonlinux.com/en/Donate.html")

    # Actualizar ventana
    def Reload(self, event=None):
        # Lista de softwares
        DirListSoftware = os.path.join(Variables.playonlinux_rep, "shortcuts")
        try:
            self.games = sorted(os.listdir(DirListSoftware), key=str.upper)
        except Exception as e:
            print(f"Error cargando accesos directos: {e}")
            self.games = []

        # Limpiar lista de software
        for Panel in self.ProgramsPanel.GetChildren():
            Panel.Destroy()
        self.ProgramsPanelSizer.Clear(True)

        # Elimina archivos ocultos de macOS si existen
        if ".DS_Store" in self.games:
            self.games.remove(".DS_Store")

        # Establece el tamaño del cover
        display_size = (240, 120)

        search_query = self.CategorySearchBox.GetValue().lower() if hasattr(self, "CategorySearchBox") else ""
        selected_cat = getattr(self, "selected_category", "all")

        for game in self.games:
            # Filtrado por búsqueda
            if search_query and search_query not in game.lower():
                continue
            # Filtrado por categoría real
            cat = self.GameCategories.get(game, "other")
            if selected_cat != "all" and cat != selected_cat:
                continue
            # Saltar si es carpeta
            if os.path.isdir(os.path.join(DirListSoftware, game)):
                continue

            item_panel = wx.Panel(self.ProgramsPanel)
            box = wx.BoxSizer(wx.VERTICAL)

            paths = [
                (os.path.join(Variables.playonlinux_rep, "icones/covers", game + ".png"), "cover"),
                (os.path.join(Variables.playonlinux_rep, "icones/full_size", game), "full"),
                (os.path.join(Variables.playonlinux_rep, "icones/32", game), "small"),
                (os.path.join(Variables.playonlinux_env, "etc/playonlinux.png"), "fallback")
            ]

            image_path = None
            image_type = None
            for path, typ in paths:
                if os.path.exists(path):
                    image_path = path
                    image_type = typ
                    break

            try:
                bg = wx.Panel(item_panel)
                bg.SetMinSize(display_size)
                bg.SetSize(display_size)

                img = wx.Image(image_path)
                iw, ih = img.GetWidth(), img.GetHeight()
                dw, dh = display_size

                # Escalar si es cover o si es más grande que display
                if image_type == "cover" or iw > dw or ih > dh:
                    scale = min(dw / iw, dh / ih)
                    img.Rescale(int(iw * scale), int(ih * scale))
                # Si es más pequeño, lo dejamos como está

                bmp = wx.StaticBitmap(bg, bitmap=img.ConvertToBitmap())
                bmp.SetName(game)
                bmp.SetToolTip(game)
                bmp.Bind(wx.EVT_LEFT_DOWN, self.LaunchGame)
                bmp.Bind(wx.EVT_ENTER_WINDOW, self.OnHover)
                bmp.Bind(wx.EVT_LEAVE_WINDOW, self.OnLeave)

                # Centrado con BoxSizer vertical
                center = wx.BoxSizer(wx.VERTICAL)
                center.AddStretchSpacer()
                center.Add(bmp, 0, wx.ALIGN_CENTER)
                center.AddStretchSpacer()
                bg.SetSizer(center)

                # CENTRAR bg dentro del item_panel
                box.Add(bg, 0, wx.ALIGN_CENTER | wx.ALL, 4)
            except Exception as e:
                print(f"Error cargando ícono para {game}: {e}")
                continue

            label = wx.StaticText(item_panel, label=game)
            box.Add(label, 0, wx.ALIGN_CENTER | wx.TOP, 0)

            item_panel.SetSizer(box)
            self.ProgramsPanelSizer.Add(item_panel, 0, wx.ALIGN_CENTER | wx.ALL, 0)

        self.ProgramsPanel.Layout()
        self.ProgramsPanel.FitInside()
        self.GenerateMenuPanel(None)

    def RConfigure(self, function_to_run, *args):
        game_exec = self.GetSelectedProgram()
        if game_exec != "":
            subprocess.Popen(
                ["bash", Variables.playonlinux_env + "/bash/polconfigurator", game_exec, function_to_run] + list(args))
        else:
            wx.MessageBox(_("Please select a program."), os.environ["APPLICATION_TITLE"])

    def Options(self, event):
        onglet = event.GetId()
        try:
            self.optionFrame.SetFocus()
        except:
            self.optionFrame = Options.MainWindow(self, -1, _("{0} settings").format(os.environ["APPLICATION_TITLE"]),
                                                  2)
            if (onglet == 211):
                self.optionFrame = Options.MainWindow(self, -1,
                                                      _("{0} settings").format(os.environ["APPLICATION_TITLE"]), 0)
            if (onglet == 214):
                self.optionFrame = Options.MainWindow(self, -1,
                                                      _("{0} settings").format(os.environ["APPLICATION_TITLE"]), 1)
            self.optionFrame.Center(wx.BOTH)
            self.optionFrame.Show(True)

    def killall(self, event):
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/killall"])

    def Executer(self, event):
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/expert/Executer"])

    def BugReport(self, event):
        try:
            self.debugFrame.Show()
            self.debugFrame.SetFocus()
        except:
            self.debugFrame = Debug.MainWindow(None, -1, _("{0} debugger").format(os.environ["APPLICATION_TITLE"]))
            self.debugFrame.Center(wx.BOTH)
            self.debugFrame.Show()

    def POLOnline(self, event):
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/playonlinux_online"])

    def PCCd(self, event):
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/read_pc_cd"])

    def PolShell(self, event):
        # Variables.run_x_server()
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/expert/PolShell"])

    def Configure(self, event):
        game_exec = self.GetSelectedProgram()
        try:
            self.configureFrame.Show(True)
            self.configureFrame.SetFocus()
            if (game_exec != ""):
                self.configureFrame.change_program(game_exec, False)

        except:
            if (game_exec == ""):
                self.configureFrame = ConfigureWindow.ConfigureWindow(self, -1, _("{0} configuration").format(
                    os.environ["APPLICATION_TITLE"]), "default", True)
            else:
                self.configureFrame = ConfigureWindow.ConfigureWindow(self, -1, _("{0} configuration").format(
                    os.environ["APPLICATION_TITLE"]), game_exec, False)

            self.configureFrame.Center(wx.BOTH)
            self.configureFrame.Show(True)

        # subprocess.Popen(["bash", Variables.playonlinux_env+"/bash/polconfigurator", game_exec])

    def Package(self, event):
        game_exec = self.GetSelectedProgram()
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/make_shortcut", game_exec])

    def UninstallGame(self, event):
        game_exec = self.GetSelectedProgram()
        if game_exec != "":
            subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/uninstall", game_exec])
        else:
            wx.MessageBox(_("Please select a program."), os.environ["APPLICATION_TITLE"])

    def PolVaultSaveGame(self, event):
        game_exec = self.GetSelectedProgram()
        if game_exec != "":
            subprocess.Popen(
                ["bash", Variables.playonlinux_rep + "plugins/PlayOnLinux Vault/scripts/menu", "--app", game_exec])
        else:
            wx.MessageBox(_("Please select a program."), os.environ["APPLICATION_TITLE"])

    def InstallMenu(self, event):
        try:
            self.installFrame.Show(True)
            self.installFrame.SetFocus()
        except:
            self.installFrame = InstallWindow(self, -1, _('{0} install menu').format(os.environ["APPLICATION_TITLE"]))
            self.installFrame.Center(wx.BOTH)
            self.installFrame.Show(True)

    def WineVersion(self, event):
        try:
            self.wversion.Show()
            self.wversion.SetFocus()
        except:
            self.wversion = WineVersions.WineVersionsWindow(None, -1,
                                                    _('{0} wine versions manager').format(os.environ["APPLICATION_TITLE"]))
            self.wversion.Center(wx.BOTH)
            self.wversion.Show(True)

    def GetSelectedProgram(self):
        return self.SelectedProgram
        #return self.ProgramsPanel

    def Run(self, event, s_debug=False):

        game_exec = self.GetSelectedProgram()
        game_prefix = PlayOnLinux.getPrefix(game_exec)

        if (s_debug == False):
            PlayOnLinux.SetDebugState(game_exec, game_prefix, False)

        if (os.path.exists(os.environ["POL_USER_ROOT"] + "/wineprefix/" + game_prefix)):
            if (game_exec != ""):
                if (PlayOnLinux.GetDebugState(game_exec)):
                    try:
                        self.debugFrame.analyseReal(0, game_prefix)
                        self.debugFrame.Show()
                        self.debugFrame.SetFocus()
                    except:
                        self.debugFrame = Debug.MainWindow(None, -1,
                                                           _("{0} debugger").format(os.environ["APPLICATION_TITLE"]),
                                                           game_prefix, 0)
                        self.debugFrame.Center(wx.BOTH)
                        self.debugFrame.Show()

                subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/run_app", game_exec])
            else:
                wx.MessageBox(_("Please select a program."), os.environ["APPLICATION_TITLE"])
        else:
            wx.MessageBox(
                _("The virtual drive associated with {0} ({1}) does no longer os.path.exists.").format(game_exec, game_prefix),
                os.environ["APPLICATION_TITLE"])

    def RunDebug(self, event):
        game_exec = self.GetSelectedProgram()
        game_prefix = PlayOnLinux.getPrefix(game_exec)
        PlayOnLinux.SetDebugState(game_exec, game_prefix, True)
        self.Run(self, True)

    def sendfeedback(self, event):
        game_exec = self.GetSelectedProgram()
        game_log = str(PlayOnLinux.getLog(game_exec))
        if game_log:
            PlayOnLinux.POL_Open(
                "http://www." + os.environ["POL_DNS"] + "/repository/feedback.php?script=" + urllib.parse.quote_plus(
                    game_log))

    def POLDie(self):
        for pid in self.registeredPid:
            try:
                os.kill(-pid, signal.SIGKILL)
            except OSError:
                pass
            try:
                os.kill(pid, signal.SIGKILL)
            except OSError:
                pass
        app.POLServer.closeServer()
        os._exit(0)

    def POLRestart(self):
        for pid in self.registeredPid:
            try:
                os.kill(-pid, signal.SIGKILL)
            except OSError:
                pass
            try:
                os.kill(pid, signal.SIGKILL)
            except OSError:
                pass
        app.POLServer.closeServer()
        os._exit(63)  # Restart code

    def ForceClose(self, signal, frame):  # Catch SIGINT
        print("\nCtrl+C pressed. Killing all processes...")
        self.POLDie()

    def ClosePol(self, event):
        pids = []
        for pid in self.registeredPid:
            try:
                os.kill(pid, 0)
                pid_exists = True
                pids.append(pid)
            except OSError:
                pid_exists = False
            print("Registered PID: %d (%s)" % (pid, 'Present' if pid_exists else 'Missing'))
        self.registeredPid = pids

        if (PlayOnLinux.GetSettings(
                "DONT_ASK_BEFORE_CLOSING") == "TRUE" or self.registeredPid == [] or wx.YES == wx.MessageBox(
                _('Are you sure you want to close all {0} windows?').format(os.environ["APPLICATION_TITLE"]), os.environ["APPLICATION_TITLE"], style=wx.YES_NO | wx.ICON_QUESTION)):
            self.SizeToSave = self.GetSize()
            self.PositionToSave = self.GetPosition()
            # Save size and position
            PlayOnLinux.SetSettings("MAINWINDOW_WIDTH", str(self.SizeToSave[0]))
            PlayOnLinux.SetSettings("MAINWINDOW_HEIGHT", str(self.SizeToSave[1] - Variables.windows_add_playonmac * 56))
            PlayOnLinux.SetSettings("MAINWINDOW_X", str(self.PositionToSave[0]))
            PlayOnLinux.SetSettings("MAINWINDOW_Y", str(self.PositionToSave[1]))

            self._mgr.Destroy()

            self.POLDie()
        return None

    def About(self, event):
        self.aboutBox = wx.adv.AboutDialogInfo()
        if (os.environ["POL_OS"] != "Mac"):
            self.aboutBox.SetIcon(wx.Icon(Variables.playonlinux_env + "/etc/playonlinux.png", wx.BITMAP_TYPE_ANY))

        self.aboutBox.SetName(os.environ["APPLICATION_TITLE"])
        self.aboutBox.SetVersion(Variables.version)
        self.aboutBox.SetDescription(_("Run your Windows programs on " + os.environ["POL_OS"] + " !"))
        self.aboutBox.SetCopyright("© 2007-2018 " + _("PlayOnLinux and PlayOnMac team\nUnder GPL licence version 3"))
        self.aboutBox.AddDeveloper(_("Developer and Website: ") + "Tinou (Pâris Quentin), MulX (Petit Aymeric)")
        self.aboutBox.AddDeveloper(_("Scriptors: ") + "GNU_Raziel")
        self.aboutBox.AddDeveloper(_("Packager: ") + "MulX (Petit Aymeric), Tinou (Pâris Quentin)")
        self.aboutBox.AddDeveloper(_("Icons:") + "Faenza-Icons http://tiheum.deviantart.com/art/Faenza-Icons-173323228")
        self.aboutBox.AddDeveloper(
            _("The following people contributed to this program: ") + "kiplantt, Salvatos, Minchul")
        self.aboutBox.AddTranslator(_("Translations:"))
        self.aboutBox.AddTranslator(_("Read TRANSLATORS file"))

        if (os.environ["POL_OS"] == "Mac"):
            self.aboutBox.SetWebSite("http://www.playonmac.com")
        else:
            self.aboutBox.SetWebSite("http://www.playonlinux.com")
        wx.adv.AboutBox(self.aboutBox)

    def Destroy(self):
        self.timer.Stop()
        self.SetupWindowTimer.Stop()
        return super().Destroy()


class PlayOnLinuxApp(wx.App):
    def OnInit(self):
        Lng.iLang()
        close = False
        exe_present = False

        subprocess.call(["bash", Variables.playonlinux_env + "/bash/startup"])
        self.systemCheck()

        for f in sys.argv[1:]:
            self.MacOpenFile(f)
            if (".exe" in f or ".EXE" in f):
                exe_present = True
            close = True

        if (close == True and exe_present == False):
            os._exit(0)

        self.SetClassName(os.environ["APPLICATION_TITLE"])
        self.SetAppName(os.environ["APPLICATION_TITLE"])

        self.frame = MainWindow(None, -1, os.environ["APPLICATION_TITLE"])
        # Gui Server
        self.POLServer = GuiServer.gui_server(self.frame)
        self.POLServer.start()

        i = 0
        while (os.environ["POL_PORT"] == "0"):
            time.sleep(0.01)
            if (i >= 300):
                wx.MessageBox(_("{0} is not able to start PlayOnLinux Setup Window server.").format(
                    os.environ["APPLICATION_TITLE"]), _("Error"))
                os._exit(0)
                break
            i += 1
        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/startup_after_server"])

        self.SetTopWindow(self.frame)
        self.frame.Show(True)

        return True

    def _executableFound(self, executable):
        devnull = open('/dev/null', 'wb')
        try:
            returncode = subprocess.call(["which", executable], stdout=devnull)
            return (returncode == 0)
        except:
            return False

    def _singleCheck(self, executable, package, fatal):
        if not self._executableFound(executable):
            message = _("{0} cannot find {1}")
            if package is not None:
                message += _(" (from {2})")

            if fatal:
                verdict = _("You need to install it to continue")
            else:
                verdict = _("You should install it to use {0}")

            wx.MessageBox(
                ("%s\n\n%s" % (message, verdict)).format(os.environ["APPLICATION_TITLE"], executable, package),
                _("Error"))

            if fatal:
                os._exit(0)

    def singleCheck(self, executable, package=None):
        self._singleCheck(executable, package, False)

    def singleCheckFatal(self, executable, package=None):
        self._singleCheck(executable, package, True)

    def systemCheck(self):
        #### Root uid check
        if (os.popen("id -u").read() == "0\n" or os.popen("id -u").read() == "0"):
            wx.MessageBox(_("{0} is not supposed to be run as root. Sorry").format(os.environ["APPLICATION_TITLE"]),
                          _("Error"))
            os._exit(0)

        #### 32 bits OpenGL check
        try:
            returncode = subprocess.call([Variables.playonlinux_env + "/bash/check_gl", "x86"])
        except:
            returncode = 255
        if (os.environ["POL_OS"] == "Linux" and returncode != 0):
            wx.MessageBox(_(
                "{0} is unable to find 32bits OpenGL libraries.\n\nYou might encounter problem with your games").format(
                os.environ["APPLICATION_TITLE"]), _("Error"))
            os.environ["OpenGL32"] = "0"
        else:
            os.environ["OpenGL32"] = "1"

        #### 64 bits OpenGL check
        if (os.environ["AMD64_COMPATIBLE"] == "True"):
            try:
                returncode = subprocess.call([Variables.playonlinux_env + "/bash/check_gl", "amd64"])
            except:
                returncode = 255
        if (os.environ["AMD64_COMPATIBLE"] == "True" and os.environ["POL_OS"] == "Linux" and returncode != 0):
            wx.MessageBox(_(
                "{0} is unable to find 64bits OpenGL libraries.\n\nYou might encounter problem with your games").format(
                os.environ["APPLICATION_TITLE"]), _("Error"))
            os.environ["OpenGL64"] = "0"
        else:
            os.environ["OpenGL64"] = "1"

        #### Filesystem check
        if (os.environ["POL_OS"] == "Linux"):
            try:
                returncode = subprocess.call([Variables.playonlinux_env + "/bash/check_fs"])
            except:
                returncode = 255
            if (os.environ["POL_OS"] == "Linux" and returncode != 0):
                wx.MessageBox(_(
                    "Your filesystem might prevent {0} from running correctly.\n\nPlease open {0} in a terminal to get more details").format(
                    os.environ["APPLICATION_TITLE"]), _("Error"))

        if (os.environ["DEBIAN_PACKAGE"] == "FALSE"):
            if (PlayOnLinux.GetSettings("SEND_REPORT") == ""):
                if (wx.YES == wx.MessageBox(_(
                        'Do you want to help {0} to make a compatibility database?\n\nIf you click yes, the following things will be sent to us anonymously the first time you run a Windows program:\n\n- Your graphic card model\n- Your OS version\n- If graphic drivers are installed or not.\n\n\nThese information will be very precious for us to help people.').format(
                        os.environ["APPLICATION_TITLE"]), os.environ["APPLICATION_TITLE"],
                                            style=wx.YES_NO | wx.ICON_QUESTION)):
                    PlayOnLinux.SetSettings("SEND_REPORT", "TRUE")
                else:
                    PlayOnLinux.SetSettings("SEND_REPORT", "FALSE")

        #### Other import checks
        self.singleCheckFatal("nc", package="Netcat")
        self.singleCheckFatal("tar")
        self.singleCheckFatal("cabextract")
        self.singleCheckFatal("convert", package="ImageMagick")
        self.singleCheckFatal("wget", package="Wget")
        self.singleCheckFatal("curl", package="cURL")

        self.singleCheckFatal("gpg", package="GnuPG")

        # FIXME: now that PoL can use a range of terminal emulators, xterm is no longer
        # a hard dependency
        if (os.environ["DEBIAN_PACKAGE"] == "FALSE" and os.environ["POL_OS"] != "Mac"):
            self.singleCheck("xterm")
        self.singleCheck("gettext.sh", package="gettext")  # gettext-base on Debian
        self.singleCheck("icotool", package="icoutils")
        self.singleCheck("wrestool", package="icoutils")
        self.singleCheck("wine", package="Wine")
        self.singleCheck("unzip", package="InfoZIP")
        self.singleCheck("jq", package="jq")
        self.singleCheck("7z", package="P7ZIP full")  # p7zip-full on Debian
        if (os.environ["POL_OS"] == "FreeBSD"):
            self.singleCheck("gsed", package="GNU Sed")

    def BringWindowToFront(self):
        try:  # it's possible for this event to come when the frame is closed
            self.GetTopWindow().Raise()
        except:
            pass

    def MacOpenFile(self, filename):
        file_extension = filename.split(".")
        file_extension = file_extension[len(file_extension) - 1]
        if (file_extension == "desktop"):  # Un raccourcis Linux
            content = open(filename, "r").readlines()
            i = 0
            while (i < len(content)):
                # wx.MessageBox(content[i], "PlayOnLinux", wx.OK)

                if ("Path=" in content[i]):
                    cd_app = content[i].replace("Path=", "").replace("\n", "")
                if ("Exec=" in content[i]):
                    exec_app = content[i].replace("Exec=", "").replace("\n", "")
                i += 1
            if (":\\\\\\\\" in exec_app):
                exec_app = exec_app.replace("\\\\", "\\")
            try:
                subprocess.Popen(shlex.split(exec_app), cwd=cd_app)
            except:
                pass

        elif (file_extension == "exe" or file_extension == "EXE"):
            subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/run_exe", filename])

        elif (file_extension == "pol" or file_extension == "POL"):
            if (wx.YES == wx.MessageBox(
                    _('Are you sure you want to  want to install {0} package?').format(filename),
                    os.environ["APPLICATION_TITLE"], style=wx.YES_NO | wx.ICON_QUESTION)):
                subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/playonlinux-pkg", "-i", filename])
        else:
            PlayOnLinux.open_document(filename, file_extension.lower())

    def MacOpenURL(self, url):
        if (os.environ["POL_OS"] == "Mac" and not "playonmac://" in url):
            wx.MessageBox(_("You are trying to open a script design for {0}! It might not work as expected").format(
                "PlayOnLinux or PlayOnBSD"), os.environ["APPLICATION_TITLE"])
        if (os.environ["POL_OS"] == "Linux" and not "playonlinux://" in url):
            wx.MessageBox(_("You are trying to open a script design for {0}! It might not work as expected").format(
                "PlayOnMac or PlayOnBSD"), os.environ["APPLICATION_TITLE"])
        if (os.environ["POL_OS"] == "FreeBSD" and not "playonbsd://" in url):
            wx.MessageBox(_("You are trying to open a script design for {0}! It might not work as expected").format(
                "PlayOnMac or PlayOnLinux"), os.environ["APPLICATION_TITLE"])

        subprocess.Popen(["bash", Variables.playonlinux_env + "/bash/playonlinux-url_handler", url])

    def MacReopenApp(self):
        # sys.exit()
        self.BringWindowToFront()

# Idea taken from flacon / # Idea tomada del flacon
def setSigchldHandler():
    signal.signal(signal.SIGCHLD, handleSigchld)
    if hasattr(signal, 'siginterrupt'):
        signal.siginterrupt(signal.SIGCHLD, False)

# Apparently some UNIX systems automatically resent the SIGCHLD handler to SIG_DFL.  Reset it just in case.
# Al parecer, algunos sistemas UNIX reenvían automáticamente el controlador SIGCHLD a SIG_DFL. Reinícielo por si acaso.
def handleSigchld(number, frame):
    setSigchldHandler()

setSigchldHandler()
Lng.Lang()

wx.Log.EnableLogging(False)

app = PlayOnLinuxApp(redirect=False)
app.MainLoop()