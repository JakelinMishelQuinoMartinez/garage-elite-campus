USE garage_elite_campus;

DELIMITER //

-- 1. CREAR CITA
CREATE PROCEDURE sp_crear_cita_servicio(
    IN p_vehiculo_id INT,
    IN p_servicio_id INT,
    IN p_mecanico_id INT,
    IN p_fecha_programada DATETIME,
    IN p_precio_final DECIMAL(10,2),
    IN p_notas TEXT,
    OUT p_cita_id INT
)
BEGIN
    DECLARE v_mecanico_activo INT;
    DECLARE v_existe_vehiculo INT;

    -- Validar Precio
    IF p_precio_final < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El precio final no puede ser negativo.';
    END IF;
    -- Validar Fecha
    IF p_fecha_programada IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La fecha programada es obligatoria.';
    END IF;

    -- Validar si el mecánico existe y está activo
    SELECT COUNT(*), COALESCE(SUM(activo), 0) INTO v_existe_vehiculo, v_mecanico_activo 
    FROM mecanicos WHERE id = p_mecanico_id;

    IF v_existe_vehiculo = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El mecánico asignado no existe.';
    ELSEIF v_mecanico_activo = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El mecánico asignado se encuentra inactivo.';
    END IF;

    -- Insertar Cita
    INSERT INTO citas_servicio (
        vehiculo_id, servicio_id, mecanico_id, fecha_programada, estado, precio_final, notas
    ) VALUES (
        p_vehiculo_id, p_servicio_id, p_mecanico_id, p_fecha_programada, 'pendiente', p_precio_final, p_notas
    );

    SET p_cita_id = LAST_INSERT_ID();
END //

-- 2. CONSULTAR CITAS (Filtro Dinámico)
CREATE PROCEDURE sp_listar_citas_servicio(
    IN p_estado VARCHAR(20)
)
BEGIN
    SELECT 
        c.id AS cita_id,
        cl.nombre AS cliente,
        CONCAT(v.marca, ' ', v.modelo, ' (', v.placa, ')') AS vehiculo,
        s.nombre AS servicio,
        m.nombre AS mecanico,
        c.fecha_programada,
        c.estado,
        c.precio_final
    FROM citas_servicio c
    JOIN vehiculos v ON c.vehiculo_id = v.id
    JOIN clientes cl ON v.cliente_id = cl.id
    JOIN servicios s ON c.servicio_id = s.id
    JOIN mecanicos m ON c.mecanico_id = m.id
    WHERE p_estado IS NULL OR c.estado = p_estado
    ORDER BY c.fecha_programada ASC;
END //

-- 3. ACTUALIZAR CITA
CREATE PROCEDURE sp_actualizar_cita_servicio(
    IN p_cita_id INT,
    IN p_mecanico_id INT,
    IN p_fecha_programada DATETIME,
    IN p_estado VARCHAR(20),
    IN p_precio_final DECIMAL(10,2),
    IN p_notas TEXT
)
BEGIN
    DECLARE v_estado_actual VARCHAR(20);

    -- Obtener estado actual
    SELECT estado INTO v_estado_actual FROM citas_servicio WHERE id = p_cita_id;

    IF v_estado_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cita no existe.';
    END IF;

    IF v_estado_actual = 'cancelada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede modificar una cita cancelada.';
    END IF;

    IF p_estado NOT IN ('pendiente', 'en_proceso', 'completada', 'cancelada') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Estado no permitido.';
    END IF;

    UPDATE citas_servicio 
    SET mecanico_id = p_mecanico_id,
        fecha_programada = p_fecha_programada,
        estado = p_estado,
        precio_final = p_precio_final,
        notas = p_notas
    WHERE id = p_cita_id;
END //

-- 4. CANCELAR CITA (Soft Delete)
CREATE PROCEDURE sp_cancelar_cita_servicio(
    IN p_cita_id INT,
    IN p_motivo TEXT
)
BEGIN
    DECLARE v_estado_actual VARCHAR(20);

    SELECT estado INTO v_estado_actual FROM citas_servicio WHERE id = p_cita_id;

    IF v_estado_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cita inexistente.';
    END IF;

    IF v_estado_actual = 'completada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede cancelar una cita que ya fue completada.';
    END IF;

    UPDATE citas_servicio
    SET estado = 'cancelada',
        notas = CONCAT(COALESCE(notas, ''), ' | MOTIVO CANCELACIÓN: ', p_motivo)
    WHERE id = p_cita_id;
END //

DELIMITER ;