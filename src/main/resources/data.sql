
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (1, 'Consulta', 'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (2, 'Reclamo',  'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (3, 'Venta',    'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (4, 'Soporte',  'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (5, 'Otros',    'ACTIVO');


MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (1, 'Empresa Demo', '900000001', 'demo@empresa.com', 'Emp1', 'Emp1', 'ACTIVO');
MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (2, 'Andes Telecom', '900000002', 'contacto@andestelecom.com', 'Emp2', 'Emp2', 'ACTIVO');
MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (3, 'Servicios Norte', '900000003', 'soporte@serviciosnorte.com', 'Emp3', 'Emp3', 'ACTIVO');


MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (1, 1, 1, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (2, 1, 2, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (3, 1, 3, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (4, 1, 4, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (5, 1, 5, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (6, 2, 1, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (7, 2, 2, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (8, 2, 3, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (9, 2, 4, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (10, 2, 5, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (11, 3, 1, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (12, 3, 2, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (13, 3, 3, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (14, 3, 4, 'ACTIVO');
MERGE INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) KEY(id) VALUES (15, 3, 5, 'ACTIVO');


MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (1, 'Carlos García',  '987654321', 'Age1E1', 'Age1E1', 'Age1E1', 1, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (2, 'Ana Mendoza',    '912345678', 'Age2E1', 'Age2E1', 'Age2E1', 1, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (3, 'Luis Quispe',    '923456789', 'Age3E1', 'Age3E1', 'Age3E1', 1, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (4, 'María Flores',   '934567890', 'Age4E1', 'Age4E1', 'Age4E1', 1, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (5, 'Roberto Vargas', '945678901', 'Age5E1', 'Age5E1', 'Age5E1', 1, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (6, 'Lucia Rojas', '956111222', 'Age1E2', 'Age1E2', 'Age1E2', 2, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (7, 'Diego Salas', '956333444', 'Age2E2', 'Age2E2', 'Age2E2', 2, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (8, 'Valeria Mena', '956555666', 'Age1E3', 'Age1E3', 'Age1E3', 3, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (9, 'Jorge Medina', '956777888', 'Age2E3', 'Age2E3', 'Age2E3', 3, 'ACTIVO');
MERGE INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, codigo_agente, id_empresa, estado_agente) KEY(id_agente)
VALUES (10, 'Paola Ruiz', '956999000', 'Age3E3', 'Age3E3', 'Age3E3', 3, 'ACTIVO');

MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (1, 1);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (2, 2);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (3, 3);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (4, 4);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (5, 5);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (6, 1);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (7, 2);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (8, 4);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (9, 1);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (10, 2);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (11, 3);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (12, 1);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (13, 4);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (14, 2);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (15, 1);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (16, 4);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (17, 5);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (18, 3);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (19, 6);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (20, 9);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (21, 6);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (22, 7);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (23, 10);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (24, 9);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (25, 8);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (26, 7);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (27, 11);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (28, 14);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (29, 11);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (30, 12);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (31, 15);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (32, 13);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (33, 11);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (34, 14);
MERGE INTO llamada_tipo (id_llamada, id_empresa_tipo) KEY(id_llamada) VALUES (35, 11);

MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (1, 'Maria Lopez',   '987654321', '2026-05-01', '09:10', '09:20', '10 min', 'El cliente consulta sobre su factura',    1, 1, 'Activo', 'Consulta', 'Lla1Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (2, 'Carlos Perez',  '923456781', '2026-05-02', '10:25', '10:40', '15 min', 'El cliente presenta una queja por cobro',  1, 2, 'Activo', 'Reclamo', 'Lla2Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (3, 'Ana Torres',    '934567812', '2026-05-03', '11:40', '11:55', '15 min', 'El cliente adquiere el plan básico',       1, 3, 'Activo', 'Venta', 'Lla3Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (4, 'Luis Ramirez',  '945678123', '2026-05-04', '13:15', '13:30', '15 min', 'El cliente necesita ayuda con la app',     1, 4, 'Activo', 'Soporte', 'Lla4Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (5, 'Rosa Garcia',   '956781234', '2026-05-05', '15:05', '15:12', '7 min',  'Consulta general',                        1, 5, 'Activo', 'Otros', 'Lla5Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (6, 'Elena Campos', '987111222', '2026-05-06', '08:05', '08:11', '6 min', 'Consulta sobre estado de servicio', 2, 1, 'Activo', 'Consulta', 'Lla6Age2E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (7, 'Miguel Castro', '987111333', '2026-05-06', '09:42', '09:53', '11 min', 'Reclamo por demora en atencion', 3, 2, 'Activo', 'Reclamo', 'Lla7Age3E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (8, 'Patricia Leon', '987111444', '2026-05-06', '10:02', '10:24', '22 min', 'Soporte por falla de acceso', 4, 4, 'Activo', 'Soporte', 'Lla8Age4E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (9, 'Hugo Vera', '987111555', '2026-05-06', '10:08', '10:17', '9 min', 'Consulta de plan disponible', 5, 1, 'Activo', 'Consulta', 'Lla9Age5E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (10, 'Sandra Molina', '987111666', '2026-05-06', '10:16', '10:45', '29 min', 'Reclamo por cobro duplicado', 1, 2, 'Activo', 'Reclamo', 'Lla10Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (11, 'Julio Paredes', '987111777', '2026-05-06', '10:27', '10:39', '12 min', 'Venta de paquete adicional', 2, 3, 'Activo', 'Venta', 'Lla11Age2E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (12, 'Carmen Soto', '987111888', '2026-05-06', '11:35', '11:42', '7 min', 'Consulta general de facturacion', 3, 1, 'Activo', 'Consulta', 'Lla12Age3E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (13, 'Marco Diaz', '987111999', '2026-05-06', '13:10', '13:18', '8 min', 'Soporte por configuracion', 4, 4, 'Activo', 'Soporte', 'Lla13Age4E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (14, 'Nadia Silva', '987222111', '2026-05-06', '15:01', '15:34', '33 min', 'Reclamo por interrupcion del servicio', 5, 2, 'Activo', 'Reclamo', 'Lla14Age5E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (15, 'Oscar Torres', '987222222', '2026-05-06', '15:09', '15:19', '10 min', 'Consulta de renovacion', 1, 1, 'Activo', 'Consulta', 'Lla15Age1E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (16, 'Rocio Arias', '987222333', '2026-05-06', '15:18', '15:43', '25 min', 'Soporte por caida de servicio', 2, 4, 'Activo', 'Soporte', 'Lla16Age2E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (17, 'Felipe Rios', '987222444', '2026-05-06', '16:50', '16:57', '7 min', 'Otros motivos de contacto', 3, 5, 'Activo', 'Otros', 'Lla17Age3E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (18, 'Teresa Navarro', '987222555', '2026-05-06', '18:20', '18:36', '16 min', 'Venta de servicio adicional', 4, 3, 'Activo', 'Venta', 'Lla18Age4E1');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (19, 'Raul Pena', '987333111', '2026-05-07', '08:18', '08:26', '8 min', 'Consulta sobre cobertura', 6, 1, 'Activo', 'Consulta', 'Lla19Age1E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (20, 'Isabel Flores', '987333222', '2026-05-07', '10:04', '10:31', '27 min', 'Soporte por lentitud', 7, 4, 'Activo', 'Soporte', 'Lla20Age2E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (21, 'Bruno Lazo', '987333333', '2026-05-07', '10:11', '10:22', '11 min', 'Consulta comercial', 6, 1, 'Activo', 'Consulta', 'Lla21Age1E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (22, 'Martha Ponce', '987333444', '2026-05-07', '10:21', '10:37', '16 min', 'Reclamo por facturacion', 7, 2, 'Activo', 'Reclamo', 'Lla22Age2E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (23, 'Pedro Nunez', '987333555', '2026-05-07', '12:45', '12:53', '8 min', 'Otros motivos de informacion', 6, 5, 'Activo', 'Otros', 'Lla23Age1E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (24, 'Diana Prado', '987333666', '2026-05-07', '14:12', '14:41', '29 min', 'Soporte avanzado de linea', 7, 4, 'Activo', 'Soporte', 'Lla24Age2E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (25, 'Sergio Vidal', '987333777', '2026-05-07', '15:03', '15:12', '9 min', 'Venta de paquete familiar', 6, 3, 'Activo', 'Venta', 'Lla25Age1E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (26, 'Lorena Caceres', '987333888', '2026-05-07', '15:15', '15:52', '37 min', 'Reclamo por servicio intermitente', 7, 2, 'Activo', 'Reclamo', 'Lla26Age2E2');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (27, 'Victor Mora', '987444111', '2026-05-08', '09:05', '09:12', '7 min', 'Consulta de disponibilidad', 8, 1, 'Activo', 'Consulta', 'Lla27Age1E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (28, 'Claudia Rey', '987444222', '2026-05-08', '10:06', '10:28', '22 min', 'Soporte por acceso bloqueado', 9, 4, 'Activo', 'Soporte', 'Lla28Age2E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (29, 'Manuel Fuentes', '987444333', '2026-05-08', '10:14', '10:25', '11 min', 'Consulta por recibo', 10, 1, 'Activo', 'Consulta', 'Lla29Age3E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (30, 'Gabriela Luna', '987444444', '2026-05-08', '10:26', '10:59', '33 min', 'Reclamo por baja velocidad', 8, 2, 'Activo', 'Reclamo', 'Lla30Age1E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (31, 'Alonso Vega', '987444555', '2026-05-08', '11:55', '12:05', '10 min', 'Otros datos de cuenta', 9, 5, 'Activo', 'Otros', 'Lla31Age2E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (32, 'Beatriz Palma', '987444666', '2026-05-08', '13:33', '13:51', '18 min', 'Venta de promocion vigente', 10, 3, 'Activo', 'Venta', 'Lla32Age3E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (33, 'Enrique Solis', '987444777', '2026-05-08', '15:02', '15:18', '16 min', 'Consulta por cambio de plan', 8, 1, 'Activo', 'Consulta', 'Lla33Age1E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (34, 'Silvia Roca', '987444888', '2026-05-08', '15:10', '15:47', '37 min', 'Soporte por corte de linea', 9, 4, 'Activo', 'Soporte', 'Lla34Age2E3');
MERGE INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo, codigo_llamada) KEY(id_llamada)
VALUES (35, 'Gustavo Herrera', '987444999', '2026-05-08', '18:40', '18:49', '9 min', 'Consulta final del dia', 10, 1, 'Activo', 'Consulta', 'Lla35Age3E3');
-- ── REINICIAR SECUENCIAS ──────────────────────────────────────────────────────


ALTER TABLE tipificacion ALTER COLUMN id_tipo RESTART WITH 6;
ALTER TABLE empresa ALTER COLUMN id_empresa RESTART WITH 4;
ALTER TABLE agente ALTER COLUMN id_agente RESTART WITH 11;
ALTER TABLE llamada ALTER COLUMN id_llamada RESTART WITH 36;
ALTER TABLE empresa_tipo ALTER COLUMN id RESTART WITH 16;
