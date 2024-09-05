# Winbox

![Version](https://img.shields.io/badge/Version-3.41-blue)
![License](https://img.shields.io/badge/License-Free%20%E2%80%A2Proprietary-green)
![Category](https://img.shields.io/badge/Category-Network-blue)
![Company](https://img.shields.io/badge/Company-Mikrotik%20%C2%A9-blue)

![Script](https://img.shields.io/badge/Script-1.6.2-blue)
![Distribution](https://img.shields.io/badge/Distribution-Linux%20Mint%2022%20x64-green?logo=Linux)
![System](https://img.shields.io/badge/System-Windows%2011-blue?logo=Windows)

## Introducción

**Winbox** es una aplicación de Mikrotik RouterOS que permite administrar equipos mediante una interfaz gráfica. Esta aplicación permite administrar Mikrotik RouterOS de forma sencilla e intuitiva.

[![SITIO OFICIAL](https://img.shields.io/badge/SITIO%20OFICIAL-blue?style=for-the-badge)](https://mikrotik.com/)
[![DESCARGAR SOFTWARE](https://img.shields.io/badge/DESCARGAR%20SOFTWARE-yellow?style=for-the-badge)](https://mikrotik.com/download)

## Pasos de instalacion

1. Selecciona el menu de **Herramientas** >> **Ejecutar un script local**

   ![001](Images/001.png)

3. Seleccionar el script de instalación:

   ![002](Images/002.png)

5. Seguir los pasos de instalación

   ![003](Images/003.png)

   ![004](Images/004.png)

   ![005](Images/005.png)

   ![006](Images/006.png)

   ![007](Images/007.png)
7. ¡Instalación Finalizada!

> [!NOTE]
> El banner y el icono es posible que no sean visible en tu instalación.

> [!IMPORTANT]
> Si tienes el firewall activado, establece la siguiente regla:
> 
> ![010](Images/010.png)
>
> O a través de la terminal:
> ```
> sudo ufw allow proto udp from any to any port 5678 comment 'WinBox'
> ```

## Capturas

![008](Images/008.png)

![009](Images/009.png)

###### Referencia: [PlayOnLinux](https://www.playonlinux.com/en/app-3035-Winbox.html)
