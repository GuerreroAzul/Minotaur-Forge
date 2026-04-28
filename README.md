# Minotauro-Forge

![PlayOnLinux](https://img.shields.io/badge/PlayOnLinux-4.3.4-orange)
![Wine](https://img.shields.io/badge/Wine-9.0-7F181B)

## :small_blue_diamond: Introducción

Este proyecto tiene como objetivo desarrollar scripts personalizados para **PlayOnLinux**, optimizando la instalación y configuración de software. Resuelve problemas comunes como:
- Gestión automática de dependencias.
- Compatibilidad entre versiones de Wine.
- Aplicación de parches específicos.

Contribuye tanto a usuarios finales (simplificando procesos) como a la comunidad (con soluciones reutilizables).

## 🔹 Requisitos previos

### Instalación y configuración de WineHQ

- Habilitar arquitectura de 32 bits:
  ```
  sudo dpkg --add-architecture i386
  ```

- Visite el sitio web para los pasos para su instalación:
  > ![WINE](https://gitlab.winehq.org/uploads/-/system/appearance/header_logo/1/winehq_logo_gitlab_small.png)

## 🔹 Configuración e instalación de PlayOnLinux

- Instalar librerías pyasyncore
Corrige el problema de que PlayOnLinux no muestra correctamente.

  ```
  sudo apt-get install -y python3-pyasyncore
  ```

- Instalar librerías OpenGL de 32 bits.
Permite que aplicaciones y juegos antiguos (compilados para 32 bits) rendericen gráficos 3D correctamente en Linux.
  ```
  sudo apt-get install -y libgl1:i386
  ```

- Instalar PlayOnLinux
  ```
  sudo apt-get install -y playonlinux
  ```

## 🔹 Reactivar playonlinux-bash (Avanzado)

- Crear fichero de ejecucion en consola
  ```
  sudo tee /usr/bin/playonlinux-bash > /dev/null << 'EOF'
  #!/bin/sh
  exec /usr/share/playonlinux/playonlinux-bash "$@"
  exit 0
  EOF
  
  sudo chmod +x /usr/bin/playonlinux-bash
  ```

- Como usar playonlinux-bash
  * Abrir la consola en el directorio del script que desea ejecutar.
  * Ejecutar el comando seguido del nombre del script. Ejemplo:
    ```
    playonlinux-bash script.sh
    ```
