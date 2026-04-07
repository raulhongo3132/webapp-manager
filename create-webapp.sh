#!/bin/bash

set -e

# =========================
# CONFIG
# =========================
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
PROFILE_BASE="$HOME/.config/webapps"

# =========================
# UTILS
# =========================

normalize_name() {
    echo "$1" | tr ' ' '_' | tr 'A-Z' 'a-z'
}

command_exists() {
    command -v "$1" &> /dev/null
}

validate_url() {
    [[ "$1" =~ ^https?:// ]]
}

# =========================
# CORE FUNCTIONS
# =========================

create_app() {
    echo "=== Crear WebApp ==="

    read -p "Nombre: " app_name
    read -p "URL: " app_url
    read -p "Navegador (brave/chrome/firefox): " browser
    read -p "¿Perfil separado? (y/n): " use_profile
    read -p "URL del icono (opcional): " icon_url

    browser=$(echo "$browser" | tr 'A-Z' 'a-z')
    app_id=$(normalize_name "$app_name")

    desktop_file="$DESKTOP_DIR/$app_id.desktop"
    icon_path="$ICON_DIR/$app_id.png"
    profile_dir="$PROFILE_BASE/$app_id"

    # Validaciones
    if ! validate_url "$app_url"; then
        echo "URL inválida"
        exit 1
    fi

    mkdir -p "$DESKTOP_DIR" "$ICON_DIR" "$PROFILE_BASE"

    # Icono
    if [ -n "$icon_url" ]; then
        echo "Descargando icono..."
        if ! curl -L "$icon_url" -o "$icon_path"; then
            echo "Error descargando icono"
            exit 1
        fi
    else
        icon_path="web-browser"
    fi

    # Perfil
    if [[ "$use_profile" =~ ^[Yy]$ ]]; then
        mkdir -p "$profile_dir"
        profile_flag="--user-data-dir=$profile_dir"
    else
        profile_flag=""
    fi

    # Navegador
    case "$browser" in
        brave)
            exec_cmd="brave $profile_flag --app=\"$app_url\""
            ;;
        chrome)
            exec_cmd="google-chrome $profile_flag --app=\"$app_url\""
            ;;
        firefox)
            exec_cmd="firefox --new-window \"$app_url\""
            ;;
        *)
            echo "Navegador no soportado"
            exit 1
            ;;
    esac

    # Sobrescritura
    if [ -f "$desktop_file" ]; then
        read -p "Ya existe. ¿Sobrescribir? (y/n): " confirm
        [[ ! "$confirm" =~ ^[Yy]$ ]] && exit 0
    fi

    # Crear .desktop
    cat > "$desktop_file" <<EOL
[Desktop Entry]
Name=$app_name
Exec=$exec_cmd
Terminal=false
Type=Application
Icon=$icon_path
Categories=Network;
EOL

    chmod +x "$desktop_file"

    echo "WebApp creada: $app_name"
}

remove_app() {
    echo "=== Eliminar WebApp ==="

    read -p "Nombre: " app_name
    app_id=$(normalize_name "$app_name")

    rm -f "$DESKTOP_DIR/$app_id.desktop"
    rm -f "$ICON_DIR/$app_id.png"
    rm -rf "$PROFILE_BASE/$app_id"

    echo "Eliminada: $app_name"
}

list_apps() {
    echo "=== WebApps instaladas ==="
    ls "$DESKTOP_DIR" | grep ".desktop" || echo "No hay apps"
}

help_menu() {
    echo "Uso:"
    echo "  webapp create   Crear nueva app"
    echo "  webapp remove   Eliminar app"
    echo "  webapp list     Listar apps"
}

# =========================
# ENTRYPOINT
# =========================

case "$1" in
    create) create_app ;;
    remove) remove_app ;;
    list) list_apps ;;
    *) help_menu ;;
esac