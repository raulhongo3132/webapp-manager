# WebApp Manager (Bash CLI)

Create Linux web apps from any URL using `.desktop` files.



Creación de aplicaciones web por url usando archivos `.desktop`.

## Features | Características

- Create web apps instantly
- Custom icons (auto download)
- Optional isolated browser profiles
- Multi-browser support (Brave, Chrome, Firefox)
- CLI interface
- 
- Crea aplicaciones web al instante
- Iconos personalizados (descarga automática)
- Perfiles de navegador independientes opcionales
- Compatibilidad con múltiples navegadores (Brave, Chrome, Firefox)
- Interfaz de línea de comandos

# Instructions | Instrucciones
## Installation

Clone the repository:



Clona el repositorio:

```bash
git clone git@github.com:raulhongo3132/webapp-manager.git
cd webapp-manager
```

Make the script executable:



Hazlo ejecutable:

```bash
chmod +x create-webapp.sh
```

## Option 1: Use directly | Usalo directamente

```bash
./create-webapp.sh create   # Create | Creala
./create-webapp.sh remove   # Remove | Borrala
./create-webapp.sh list     # List | Ve las instaladas
```

The script will prompt you for app details.



El script te pedirá los detalles de la aplicación.

## Option 2: Make it available globally | Hagalo disponible a nivel global

(Optional) Create a global command called webapp:



(Opcional) Cree un comando global llamado webapp:

```bash
sudo ln -s $(pwd)/create-webapp.sh /usr/local/bin/webapp
```

Then you can run:



Entonces puedes correr:

```bash
webapp create
webapp remove
webapp list
webapp       # Shows help menu | Muestra el menú
```
