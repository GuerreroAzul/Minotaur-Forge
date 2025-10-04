# Minotauro-Forge

![PlayOnLinux](https://img.shields.io/badge/PlayOnLinux-4.3.4-yellow)
![Wine](https://img.shields.io/badge/Wine-9.0-red)

## :small_blue_diamond: Introducción

Este proyecto desarrolla scripts personalizados para **PlayOnLinux**, optimizando la instalación y configuración de software. Resuelve problemas comunes como:
- Gestión automática de dependencias.  
- Compatibilidad entre versiones de Wine.  
- Aplicación de parches específicos.  
Contribuye tanto a usuarios finales (simplificando procesos) como a la comunidad (con soluciones reutilizables).

## :small_blue_diamond: Configuración e Instalación de Wine

### Requisitos previos
- PlayOnLinux 4.3.4+ instalado.  
- Sistema Linux con arquitectura `i386` habilitada.  

### 1. Configurar Wine
Habilitar arquitectura de 32 bits:  
```
sudo dpkg --add-architecture i386
```

### 2. Identificar distribución
Busca la línea con cualquiera de `UBUNTU_CODENAME` o `VERSION_CODENAME`. Si ambos están presentes, use el nombre después `UBUNTU_CODENAME`.

```
cat /etc/os-release
```

### 3. Añadir clave del repositorio

```
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
```

### 4. Agregar el repositorio
Si su nombre de distribución no está en la lista, es más antiguo los paquetes pueden estar disponibles en el servidor de descargas. Añadir un repositorio.

|Distribución                              |Comando                                                                                                                 |
|:-----------------------------------------|:-----------------------------------------------------------------------------------------------------------------------|
|Plucky<br/>Ubuntu 25.04                   |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources`    |
|Oracular<br/>Ubuntu 24.10                 |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/oracular/winehq-oracular.sources`|
|Noble<br/>Ubuntu 24.04<br/>Linux Mint 22  |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources`      |
|Jammy<br/>Ubuntu 22.04<br/>Linux Mint 21.x|`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources`      |
|Focal<br/>Ubuntu 20.04<br/>Linux Mint 20.x|`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources`      |
|Trixie<br/>Debian Testing                 |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources`    |
|Bookworm<br/>Debian 12                    |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources`|
|Bullseye<br/>Debian 11                    |`sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources`|

### 5. Instalar Wine

```
sudo apt install --install-recommends winehq-stable
```

> [!NOTE]
> Para mas información visite.
> 
> [![WINE](https://gitlab.winehq.org/uploads/-/system/appearance/header_logo/1/winehq_logo_gitlab_small.png)](https://wiki.winehq.org/Download)

## :small_blue_diamond: Configuración e Instalación de PlayOnLinux

### 1. Instalar librerías pyasyncore
Corrige el problema de que PlayOnLinux no muestra correctamente.

```
sudo apt-get install -y python3-pyasyncore
```

### 2. Instalar librerías OpenGL de 32 bits.
Permite que aplicaciones y juegos antiguos (compilados para 32 bits) rendericen gráficos 3D correctamente en Linux.

```
sudo apt-get install -y libgl1:i386
```

### 3. Instalar PlayOnLinux

```
sudo apt-get install -y playonlinux
```

## :small_blue_diamond: Reactivar playonlinux-bash (Avanzado)

### Crear fichero de ejecucion en consola

```
sudo tee /usr/bin/playonlinux-bash > /dev/null << 'EOF'
#!/bin/sh
exec /usr/share/playonlinux/playonlinux-bash "$@"
exit 0
EOF

sudo chmod +x /usr/bin/playonlinux-bash
```

### Como usar playonlinux-bash
1. Abrir la consola en el directorio del script que desea ejecutar.
2. Ejecutar el comando seguido del nombre del script. Ejemplo:

```
playonlinux-bash script.sh
```
