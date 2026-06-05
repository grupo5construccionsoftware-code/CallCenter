-- === EMPRESAS (Integrante 2) ===

-- === AGENTES (Integrante 3) ===

-- === TIPIFICACIONES (Integrante 4) ===
INSERT INTO tipificacion (id_tipo, motivo_tipo, estado_tipo) VALUES
  (1, 'Consulta', 'ACTIVO'),
  (2, 'Reclamo', 'ACTIVO'),
  (3, 'Venta', 'ACTIVO'),
  (4, 'Soporte', 'ACTIVO'),
  (5, 'Otros', 'ACTIVO');

INSERT INTO empresa_tipo (id, id_empresa, id_tipo, estado_asignacion) VALUES
  (1, 1, 1, 'ACTIVO'),
  (2, 1, 2, 'ACTIVO'),
  (3, 1, 3, 'ACTIVO'),
  (4, 1, 4, 'ACTIVO'),
  (5, 1, 5, 'ACTIVO');

-- === LLAMADAS (Integrante 5) ===
