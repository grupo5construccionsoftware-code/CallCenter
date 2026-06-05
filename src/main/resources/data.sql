-- ── TIPIFICACION ──────────────────────────────────────────────────────────────
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES (1, 'Consulta', 'ACTIVO');
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES (2, 'Reclamo',  'ACTIVO');
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES (3, 'Venta',    'ACTIVO');
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES (4, 'Soporte',  'ACTIVO');
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES (5, 'Otros',    'ACTIVO');

-- ── EMPRESA ───────────────────────────────────────────────────────────────────
INSERT INTO empresa (id_empresa, nombre_empresa, telefono_empresa, correo_empresa, usuario_empresa, contrasenia_empresa, estado_empresa)
VALUES (1, 'Empresa Demo', '900000001', 'demo@empresa.com', 'Emp1', 'Emp1', 'ACTIVO');

-- ── EMPRESA_TIPO (tipificaciones base asignadas a Empresa Demo) ───────────────
INSERT INTO empresa_tipo (id_empresa, id_tipo, estado_asignacion) VALUES (1, 1, 'ACTIVO');
INSERT INTO empresa_tipo (id_empresa, id_tipo, estado_asignacion) VALUES (1, 2, 'ACTIVO');
INSERT INTO empresa_tipo (id_empresa, id_tipo, estado_asignacion) VALUES (1, 3, 'ACTIVO');
INSERT INTO empresa_tipo (id_empresa, id_tipo, estado_asignacion) VALUES (1, 4, 'ACTIVO');
INSERT INTO empresa_tipo (id_empresa, id_tipo, estado_asignacion) VALUES (1, 5, 'ACTIVO');

-- ── AGENTE ────────────────────────────────────────────────────────────────────
INSERT INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, id_empresa, estado_agente)
VALUES (1, 'Carlos García',  '987654321', 'Age1E1', 'Age1E1', 1, 'ACTIVO');
INSERT INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, id_empresa, estado_agente)
VALUES (2, 'Ana Mendoza',    '912345678', 'Age2E1', 'Age2E1', 1, 'ACTIVO');
INSERT INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, id_empresa, estado_agente)
VALUES (3, 'Luis Quispe',    '923456789', 'Age3E1', 'Age3E1', 1, 'ACTIVO');
INSERT INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, id_empresa, estado_agente)
VALUES (4, 'María Flores',   '934567890', 'Age4E1', 'Age4E1', 1, 'ACTIVO');
INSERT INTO agente (id_agente, nombre_agente, telefono_agente, usuario_agente, contrasenia_agente, id_empresa, estado_agente)
VALUES (5, 'Roberto Vargas', '945678901', 'Age5E1', 'Age5E1', 1, 'ACTIVO');

-- ── LLAMADA ───────────────────────────────────────────────────────────────────
INSERT INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo)
VALUES (1, 'Maria Lopez',   '987654321', '2026-05-01', '09:10', '09:20', '10 min', 'El cliente consulta sobre su factura',    1, 1, 'Activo', 'Consulta');
INSERT INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo)
VALUES (2, 'Carlos Perez',  '923456781', '2026-05-02', '10:25', '10:40', '15 min', 'El cliente presenta una queja por cobro',  1, 2, 'Activo', 'Reclamo');
INSERT INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo)
VALUES (3, 'Ana Torres',    '934567812', '2026-05-03', '11:40', '11:55', '15 min', 'El cliente adquiere el plan básico',       1, 3, 'Activo', 'Venta');
INSERT INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo)
VALUES (4, 'Luis Ramirez',  '945678123', '2026-05-04', '13:15', '13:30', '15 min', 'El cliente necesita ayuda con la app',     1, 4, 'Activo', 'Soporte');
INSERT INTO llamada (id_llamada, nombre_cliente, telefono_cliente, fecha_llamada, hora_inicio, hora_fin, duracion, descripcion_tipo, id_agente, id_tipo, estado_llamada, motivo_tipo)
VALUES (5, 'Rosa Garcia',   '956781234', '2026-05-05', '15:05', '15:12', '7 min',  'Consulta general',                        1, 5, 'Activo', 'Otros');
-- ── REINICIAR SECUENCIAS ──────────────────────────────────────────────────────
ALTER TABLE tipificacion ALTER COLUMN id_tipo RESTART WITH 6;
ALTER TABLE empresa ALTER COLUMN id_empresa RESTART WITH 2;
ALTER TABLE agente ALTER COLUMN id_agente RESTART WITH 6;
ALTER TABLE llamada ALTER COLUMN id_llamada RESTART WITH 6;
ALTER TABLE empresa_tipo ALTER COLUMN id RESTART WITH 6;