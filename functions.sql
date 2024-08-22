-- Seleccionar la base de datos a usar.
USE pymarktime;

-- Retorna la ultima fecha y hora de marcación de un empleado.
DROP FUNCTION IF EXISTS last_marktime; 

DELIMITER //
CREATE FUNCTION last_marktime(dni CHAR(8))
RETURNS DATETIME NOT DETERMINISTIC
BEGIN
    DECLARE marktime DATETIME;
    SET marktime = (SELECT 
                        a.mark_time 
                    FROM 
                        markings AS a 
                    WHERE a.dni = dni 
                    ORDER BY a.mark_time DESC LIMIT 1);

    RETURN marktime;
END //
DELIMITER //