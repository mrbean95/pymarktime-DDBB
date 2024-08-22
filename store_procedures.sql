USE pymarktime;

-- Retorna al empleado para un inicio de sesíon.
DROP PROCEDURE IF EXISTS get_employee;
CREATE PROCEDURE get_employee(
    IN dni CHAR(8),
    IN pass CHAR(64)
)
BEGIN
    SELECT
		t1.dni,
		t1.first_name,
        t1.last_name,
		t2.permission
	FROM
		employees AS t1
	INNER JOIN
		employee_permission AS t2
	USING
		(dni)
    WHERE
    	t1.dni = dni AND 
        t1.pass = pass AND
       	t1.is_enabled = 1;
END;

-- Crea la marcación de un empleado.
DROP PROCEDURE IF EXISTS create_marktime;
CREATE PROCEDURE create_marktime(
    IN dni CHAR(8),
    IN marked_by CHAR(8)
)
BEGIN
    DECLARE marktime DATETIME;
    DECLARE time_elapsed INTEGER;

    SET marktime = last_marktime(dni);
    SET time_elapsed = (TIMESTAMPDIFF(MINUTE, marktime, NOW()));

    IF time_elapsed IS NULL OR time_elapsed >= 30 THEN
	   INSERT INTO markings(DNI, marked_by, mark_time)
	   VALUES (dni, marked_by, NOW());
    ELSE
        SIGNAL SQLSTATE '45000';
    END IF;
END;

-- Crea a un empleado.
DROP PROCEDURE IF_EXISTS create_employee;
CREATE PROCEDURE create_employee(
	IN dni CHAR(8),
	IN first_name VARCHAR(30),
	IN second_name VARCHAR(30),
	IN last_name VARCHAR(30),
	IN second_last_name VARCHAR(30)
)
BEGIN
	-- Por defecto crea la contraseña 1234 al empleado recien creado.
	DECLARE pass CHAR(64);
	SELECT SHA2('1234', 256) INTO pass;

    -- Crea a un empleado.
    INSERT INTO
        employees (
            dni, first_name, second_name, last_name, second_last_name, pass
        )
    VALUES (dni, first_name, second_name, last_name, second_last_name, pass);
	
    -- Otorga el permiso para marcar al empleado recien creado.
	INSERT INTO employee_permission(dni, permission)
	VALUES(dni, 1);
END;

-- Deshabilita a un empleado.
DROP PROCEDURE IF EXISTS disable_employee;
CREATE PROCEDURE disable_employee(
	IN dni CHAR(8),
	IN disabled_by CHAR(8)
)
BEGIN
	UPDATE employees AS t1
	SET t1.is_enabled = 0, t1.disabled_by = disabled_by
	WHERE t1.dni = dni;
END;

-- Retorna la información de un empleado.
DROP PROCEDURE IF EXISTS employee_information;
CREATE PROCEDURE employee_information(
	IN dni CHAR(8)
)
BEGIN
	SELECT
		t1.first_name,
        t1.last_name,
		t1.is_enabled
	FROM
		employees AS t1
	WHERE
		t1.dni = dni;
END;

-- Cambia la contraseña de un empleado.
DROP PROCEDURE IF EXISTS change_pass;
CREATE PROCEDURE change_pass(
	IN dni CHAR(8),
	IN pass CHAR(4)
)
BEGIN
	DECLARE new_pass CHAR(64);
	SELECT SHA2(pass, 256) INTO new_pass;
	UPDATE employees AS t1
	SET t1.pass = new_pass
	WHERE t1.dni = dni;
END;

-- SP para habilitar empleado.
CREATE PROCEDURE enable_employee(
	IN dni CHAR(8),
	IN enabled_by CHAR(8)
)
BEGIN	
	UPDATE employees AS t1
	SET t1.is_enabled = 1, t1.enabled_by = enabled_by 
	WHERE t1.dni = dni;
END;
