# WebApp Manager (Bash CLI)

Create Linux web apps from any URL using `.desktop` files.
Creación de aplicaciones web por url usando archivos `.desktop`.

## Features

- Create web apps instantly
- Custom icons (auto download)
- Optional isolated browser profiles
- Multi-browser support (Brave, Chrome, Firefox)
- CLI interface

- Crea aplicaciones web al instante
- Iconos personalizados (descarga automática)
- Perfiles de navegador independientes opcionales
- Compatibilidad con múltiples navegadores (Brave, Chrome, Firefox)
- Interfaz de línea de comandos

## Installation

Clone the repository

Clona el repositorio

```bash
git clone git@github.com:raulhongo3132/webapp-manager.git
cd webapp-manager
```

```bash
chmod +x webapp
sudo ln -s $(pwd)/webapp /usr/local/bin/webapp
```

## Usage

```bash
webapp create
webapp remove
webapp list
```

## Example

Create a Whatsapp app:

```bash
webapp create
```

## Requirements

- bash
- curl

