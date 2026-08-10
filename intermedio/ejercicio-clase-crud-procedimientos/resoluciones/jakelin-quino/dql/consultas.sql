USE campuslands_mysql;

-- 1. Listado de citas pendientes ordenadas por fecha más cercana
SELECT c.id, cl.nombre AS cliente, v.placa, c.fecha_programada, c.estado 
FROM citas_servicio c
JOIN vehiculos v ON c.vehiculo_id = v.id
JOIN clientes cl ON v.cliente_id = cl.id
WHERE c.estado = 'pendiente'
ORDER BY c.fecha_programada ASC;

-- 2. Total estimado/cobrado acumulado por estado de cita
SELECT estado, COUNT(*) AS cantidad_citas, SUM(precio_final) AS total_recaudado
FROM citas_servicio
GROUP BY estado;

-- 3. Ranking de mecánicos por cantidad de citas atendidas (completadas o en proceso)
SELECT m.nombre, m.especialidad, COUNT(c.id) AS total_atendidas
FROM mecanicos m
LEFT JOIN citas_servicio c ON m.id = c.mecanico_id AND c.estado IN ('en_proceso', 'completada')
GROUP BY m.id, m.nombre, m.especialidad
ORDER BY total_atendidas DESC;

-- 4. Vehículos con más de una cita registrada
SELECT v.placa, v.marca, v.modelo, COUNT(c.id) AS total_citas
FROM vehiculos v
JOIN citas_servicio c ON v.id = c.vehiculo_id
GROUP BY v.id, v.placa, v.marca, v.modelo
HAVING COUNT(c.id) > 1;

-- 5. Servicios más solicitados y promedio de precio final cobrado
SELECT 
    s.nombre, 
    COUNT(c.id) AS veces_solicitado, 
    AVG(c.precio_final) AS precio_promedio
FROM servicios s
JOIN citas_servicio c ON c.servicio_id = s.id
GROUP BY s.id, s.nombre
ORDER BY veces_solicitado DESC;