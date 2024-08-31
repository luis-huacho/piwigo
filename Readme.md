Ejecutar:

```
chromium-browser --explicitly-allowed-ports=10080 http://localhost:10080
```

Si hay problemas, revisar la IP de la red porque conecta a la base de datos de forma externa
Descargar Piwigo y renombrar la carpeta como app

- Funciona bien pero no tiene soporte de video, no logramos hacerlo funcionar.
- Para sobreescribir configuraciones se debe copiar include/config_default.php a local/config.php y modificar las configuraciones.

```
$conf['picture_ext'] = array('jpg','jpeg','png','gif','webp','mp4');
$conf['file_ext'] = array_merge(
  $conf['picture_ext'],
  array('tiff', 'tif', 'mpg','zip','avi','mp3','ogg','pdf','svg', 'heic', 'mp4')
);
```

```
$conf['ffmpeg_dir'] = '/ruta/completa/a/ffmpeg/';
```

```
$conf['upload_form_all_types'] = false; // Esto permitirá solo los tipos definidos en $conf['picture_ext']
```

```
$conf['upload_form_max_file_size'] = 1000; // 1000 MB de tamaño máximo
```