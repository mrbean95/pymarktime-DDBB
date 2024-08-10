-- Agregar los permisos.
INSERT INTO permissions(
	id, 
	description)
VALUES
	(1,'Puede marcar'),
	(2,'Puede registrar a un empleado'),
	(3, 'Puede inhabilitar a un empleado'),
	(4, 'Puede habilitar a un empleado');

-- Crear al usuario root.
INSERT INTO employees(
	dni, 
	first_name, 
	second_name, 
	last_name, 
	second_last_name, 
	pass)
VALUES(
	'00000000',
	'Root',
	'Root',
	'Root',
	'Root',
	SHA2('1234', 256));
	
-- Dar permisos al usuario root.
INSERT INTO employee_permission(
	dni, 
	permission)
VALUES
	('00000000', 2),
	('00000000', 3),
	('00000000', 4);
