-- ── TIPIFICACION ──────────────────────────────────────────────────────────────
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (1, 'Consulta', 'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (2, 'Reclamo',  'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (3, 'Venta',    'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (4, 'Soporte',  'ACTIVO');
MERGE INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) KEY(id_tipo) VALUES (5, 'Otros',    'ACTIVO');

-- ── EMPRESA ───────────────────────────────────────────────────────────────────
MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (1, 'Empresa Demo', '900000001', 'demo@empresa.com', 'Emp1', 'Emp1', 'ACTIVO');
MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (2, 'Andes Telecom', '900000002', 'contacto@andestelecom.com', 'Emp2', 'Emp2', 'ACTIVO');
MERGE INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
KEY(id_empresa) VALUES (3, 'Servicios Norte', '900000003', 'soporte@serviciosnorte.com', 'Emp3', 'Emp3', 'ACTIVO');

-- ── EMPRESA_TIPO (tipificaciones base asignadas a Empresa Demo) ───────────────
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

-- ── AGENTE ────────────────────────────────────────────────────────────────────
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

-- ── LLAMADA ───────────────────────────────────────────────────────────────────
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
-- ── REINICIAR SECUENCIAS ──────────────────────────────────────────────────────
ALTER TABLE tipificacion ALTER COLUMN id_tipo RESTART WITH 6;
ALTER TABLE empresa ALTER COLUMN id_empresa RESTART WITH 4;
ALTER TABLE agente ALTER COLUMN id_agente RESTART WITH 6;
ALTER TABLE llamada ALTER COLUMN id_llamada RESTART WITH 6;
ALTER TABLE empresa_tipo ALTER COLUMN id RESTART WITH 16;
