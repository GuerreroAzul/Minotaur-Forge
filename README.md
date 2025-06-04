# Minotauro-Forge

![PlayOnLinux](https://img.shields.io/badge/PlayOnLinux-4.3.4-green)

## Introducción

<p style="text-align: justify;">
El objetivo de este proyecto es contribuir con el desarrollo de una serie de scripts personalizados para <b>PlayOnLinux</b>. Estos scripts permitirán a los usuarios instalar y configurar de manera más eficiente, abordando problemas comunes como la configuración de dependencias, la gestión de versiones, y la aplicación de parches específicos.<br><br>
La implementación de estos scripts tiene como finalidad no solo simplificar la vida de los usuarios finales, sino también contribuir a la comunidad de <b>PlayOnLinux</b> con soluciones reutilizables y personalizadas.
</p>

## Configuramiento e Instalación

<p style="text-align: justify;">
Wine es una capa de compatibilidad que permite ejecutar aplicaciones de Windows en sistemas operativos como Linux, macOS, BSD y Solaris.<br>
</p>

### Wine

<b>1. habilitar la arquitectura de 32 bits:</b>

```console
sudo dpkg --add-architecture i386
```

<b>2. Identificar distribución:</b>
<p style="text-align: justify;">
Busca la línea con cualquiera de `UBUNTU_CODENAME` o `VERSION_CODENAME`. Si ambos están presentes, use el nombre después `UBUNTU_CODENAME`.
</p>

```console
cat /etc/os-release
```

<b>3. Añadir clave del repositorio:</b>

```console
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
```
<b>4. Agregar el repositorio:</b>
<p style="text-align: justify;">
Si su nombre de distribución no está en la lista, es más antiguo los paquetes pueden estar disponibles en el servidor de descargas. Añadir un repositorio.
</p>
|Distribución             |Comando                                                                                                               |
|:------------------------|:---------------------------------------------------------------------------------------------------------------------|
|Plucky&#10;Ubuntu 25.04                   |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources`    |
|Oracular&#10;Ubuntu 24.10                 |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/oracular/winehq-oracular.sources`|
|Noble&#10;Ubuntu 24.04&#10;Linux Mint 22  |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources`      |
|Jammy&#10;Ubuntu 22.04&#10;Linux Mint 21.x|`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources`      |
|Focal&#10;Ubuntu 20.04&#10;Linux Mint 20.x|`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources`      |
|Trixie&#10;Debian Testing                 |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources`    |
|Bookworm&#10;Debian 12                    |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources`|
|Bullseye&#10;Debian 11                    |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources`|

<b>5. Instalar Wine:</b>

```console
sudo apt install --install-recommends winehq-stable
```

> [!NOTE]
> Para mas información visite.
> 
> [![WINE](https://gitlab.winehq.org/uploads/-/system/appearance/header_logo/1/winehq_logo_gitlab_small.png)](https://wiki.winehq.org/Download)