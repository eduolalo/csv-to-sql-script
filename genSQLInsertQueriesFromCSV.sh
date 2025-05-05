#!/bin/bash

# --- Configuración por flags ---
DELIMITER=',' # Establecer el delimitador por defecto
while [[ $# -gt 0 ]]; do
    case "$1" in
        --FILE)
            FILE="$2"
            shift 2
            ;;
        --OUT)
            OUT="$2"
            shift 2
            ;;
        --TABLE)
            TABLE="$2"
            shift 2
            ;;
        --DELIMITER)
            DELIMITER="$2"
            shift 2
            ;;
        *)
            echo "Flag desconocida: $1"
            exit 1
            ;;
    esac
done

# Validar que las variables requeridas estén definidas
if [[ -z "$FILE" || -z "$OUT" || -z "$TABLE" ]]; then
    echo "Uso: $0 --FILE archivo.csv --OUT archivo.sql --TABLE nombre_tabla [--DELIMITER ',']"
    exit 1
fi

# --- Fin Configuración por flags ---

# Leer la cabecera (primera línea)
header_line=$(head -n 1 "$FILE")

# Construir la parte de las columnas para la sentencia INSERT
# Reemplaza el delimitador por ", " para la lista de columnas SQL
# y envuélvelo entre paréntesis.
# Se usan comillas dobles por si los nombres de columna contienen espacios o son palabras reservadas.
IFS="$DELIMITER" read -r -a headers <<< "$header_line"
column_names_sql=$(printf ', %s' "${headers[@]}")
column_names_sql="(${column_names_sql:2})" # Elimina la coma y espacio iniciales

# Crear/Vaciar el archivo SQL de salida y añadir un comentario inicial
echo "-- Script SQL generado desde $FILE el $(date)" > "$OUT"

# Procesar las líneas de datos (desde la segunda línea en adelante)
tail -n +2 "$FILE" | while IFS= read -r line || [[ -n "$line" ]]; do
    # Saltar líneas vacías
    if [[ -z "$line" ]]; then
        continue
    fi

    values_sql=""
    # Dividir la línea en valores usando el delimitador
    IFS="$DELIMITER" read -r -a values <<< "$line"

    # Construir la parte VALUES de la sentencia INSERT
    for val in "${values[@]}"; do
        # Escapar comillas simples dentro del valor (' -> '')
        escaped_val=$(echo "$val" | sed "s/'/''/g")
        # Añadir el valor entre comillas simples a la lista
        values_sql+=", '$escaped_val'"
    done
    values_sql="(${values_sql:2})" # Elimina la coma y espacio iniciales

    # Escribir la sentencia INSERT completa en el archivo SQL
    echo "INSERT INTO $TABLE $column_names_sql VALUES $values_sql;" >> "$OUT"

done

echo "Script SQL generado exitosamente en '$OUT'."

exit 0