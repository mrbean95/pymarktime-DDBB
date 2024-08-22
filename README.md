# pymarktime-DDBB

_Repositorio para crear la base de datos del programa [pymarktime](https://github.com/mrbean95/pymarktime)_

## Requisitos:
- MySQL 8.0.36 o superior.

**Las instrucciones a continuación son para sistemas GNU/Linux.**

## Pasos:
#### 1.- Abrir tu terminal favorita. Tambien puedes usar cualquier otro cliente de MySQl como MySQL Workbench, phpMyAdmin, etc. ####

#### 2.- Inicia sesión en mysql con el usuario root. ####

```sh
mysql -u root -p
```

#### 3.- Crea la base de datos. En mi caso nombraré a mi base de datos _pymarktime_. ####

```sh
CREATE DATABASE pymarktime;
```

Para validar que tu base de datos ha sido creada, ejecuta el siguiente comando:

```sh
SHOW DATABASES;
```

![SHOW DATABASES](https://i.ibb.co/6HVkPQC/show-databases.png)

#### 4.- Crear un usuario para la base de datos. Tambien es posible que uses el usuario root. Si has decidido usar el usuario root ve directamente al paso 7. Si decides crear otro usuario, debes de hacer lo siguiente: ####

Puedes colocar el nombre que tu desees asi como la contraseña. En el ejemplo usaré **_usr-dev_** y como contraseña **_EjemploDDBB2024_**.

```sh
CREATE USER 'usr-dev'@'%' IDENTIFIED BY 'EjemploDDBB2024**';
```

Para validar que tu usuario ha sido creado ejecuta el siguiente comando:

```sh
SELECT user, host FROM mysql.user;
```

![CREATE USER](https://i.ibb.co/BGWVgXh/select-user-host.png)

#### 5.- Otorgar permisos CRUD (create, read, update, delete) al usuario creado a la base de datos. ####

```sh
GRANT ALL PRIVILEGES ON pymarktime.* TO 'usr-dev'@'%';
```

Para que los cambios surtan efectos,ejecuta el siguiente comando:

```sh
FLUSH PRIVILEGES;
```

Valida que los privilegios se han otorgado:

![GRANT ALL PRIVILEGES](https://i.ibb.co/jyxt4D3/show-grants.png)

```sh
SHOW GRANTS FOR 'usr-dev'@'%';
```

#### 6.- Otorga permisos para ejecutar procedimiento almacenados. ####

```sh
GRANT EXECUTE ON pymarktime.* TO 'usr-dev'@'%';
```

Para que los cambios surtan efectos,ejecuta el siguiente comando:

```sh
FLUSH PRIVILEGES;
```

#### 7.- Cierra sesión de MySQl de la siguiente forma: ####

```sh
exit;
```

##### 8.- Importar el esquema de la base de datos. #####

Usando el usuario root, crearemos las tablas:

```sh
mysql -u root -p < tables.sql
```

Luego crearemos las funciones:

```sh
mysql -u root -p < functions.sql
```

Ahora creamos los procedimientos almacenados:

```sh
mysql -u root -p < store_procedures.sql
```

Por ultimo creamos los permisos disponibles y al superusuario del sistema.

```sh
mysql -u root -p < data.sql
```

**Para cada uno de estos anteriores 4 comandos, nos pedira nuestra contraseña de usuario root.**