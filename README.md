# csv-to-sql-script

Script en Bash para generar sentencias SQL `INSERT` a partir de archivos CSV.

## Uso

Ejecuta el script pasando los siguientes flags obligatorios:

- `--FILE` Ruta al archivo CSV de entrada.
- `--OUT` Ruta al archivo SQL de salida.
- `--TABLE` Nombre de la tabla destino en la base de datos.
- `--DELIMITER` (opcional) Delimitador de columnas en el CSV (por defecto `,`).

### Ejemplo

```sh
bash genSQLInsertQueriesFromCSV.sh --FILE datos.csv --OUT inserts.sql --TABLE usuarios --DELIMITER ','
```

## Hacer disponible el script globalmente

Para poder ejecutar el script desde cualquier lugar de la terminal, sigue uno de estos métodos:

### Opción 1: Mover el script a `/usr/local/bin`

1. Da permisos de ejecución:
   ```sh
   chmod +x /ruta/al/script/genSQLInsertQueriesFromCSV.sh
   ```
2. Mueve el script:
   ```sh
   sudo mv /ruta/al/script/genSQLInsertQueriesFromCSV.sh /usr/local/bin/genSQLInsertQueriesFromCSV
   ```
3. Ahora puedes ejecutarlo desde cualquier carpeta con:
   ```sh
   genSQLInsertQueriesFromCSV --FILE ... --OUT ... --TABLE ...
   ```

### Opción 2: Agregar el directorio al PATH

1. Edita tu archivo `~/.zshrc` (o `~/.bash_profile` si usas bash):
   ```sh
   nano ~/.zshrc
   ```
2. Agrega la siguiente línea al final:
   ```sh
   export PATH="$PATH:/ruta/al/script"
   ```
3. Guarda y recarga la configuración:
   ```sh
   source ~/.zshrc
   ```
4. Da permisos de ejecución al script:
   ```sh
   chmod +x /ruta/al/script/genSQLInsertQueriesFromCSV.sh
   ```
5. Ahora puedes ejecutarlo desde cualquier carpeta con:
   ```sh
   genSQLInsertQueriesFromCSV.sh --FILE ... --OUT ... --TABLE ...
   ```

# DISCLAIMER

El uso de este script es responsabilidad exclusiva del usuario. El desarrollador no asume ninguna responsabilidad por daños, pérdidas de información, errores en la base de datos, ni cualquier otro inconveniente derivado del uso de este software. Utilízalo bajo tu propio riesgo y revisa siempre los resultados antes de aplicarlos en entornos de producción.