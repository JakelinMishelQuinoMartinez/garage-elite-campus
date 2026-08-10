USE campuslands_mysql;

-- 1. Listado de citas pendientes ordenadas por fecha más cercana
SELECT c.id, cl.nombre AS cliente, v.placa, c.fecha_programada, c.estado 
FROM citas_servicio c
JOIN vehiculos v ON c.vehiculo_id = v.id
JOIN clientes cl ON v.cliente_id = cl.id
WHERE c.estado = 'pendiente'
ORDER BY c.fecha_programada ASC;