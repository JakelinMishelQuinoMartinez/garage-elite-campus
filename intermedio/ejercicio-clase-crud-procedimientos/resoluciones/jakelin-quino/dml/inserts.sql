USE garage_elite_campus;

-- Insertar Clientes
INSERT INTO clientes (nombre, telefono, email) VALUES
('Carlos Sainz', '34600112', 'carlos.sainz@gmail.com'),
('Valentino Rossi', '39066987', 'vale46@gmail.com'),
('Lewis Hamilton', '44207946', 'lewis44@gmail.com'),
('Marc Márquez', '34611223', 'marc93@gmail.com'),
('Charles Lopéz', '77931528', 'charles16@gmail.com');

-- Insertar Vehículos
INSERT INTO vehiculos (cliente_id, tipo, marca, modelo, placa, anio) VALUES
(1, 'auto_lujo', 'Ferrari', 'SF90 Stradale', 'P-345BTR', 2024),
(2, 'moto', 'Yamaha', 'YZF-R1M', 'M-046MOT', 2023),
(3, 'hiperdeportivo', 'Mercedes-AMG', 'ONE', 'P-444AMG', 2025),
(4, 'moto', 'Ducati', 'Panigale V4 R', 'M-093MOT', 2024),
(5, 'auto_lujo', 'Ferrari', 'Purosangue', 'P-516FRR', 2024),
(1, 'hiperdeportivo', 'McLaren', 'Senna', 'P-777MCL', 2023),
(2, 'moto', 'BMW', 'M 1000 RR', 'M-100RRR', 2024);

-- Insertar Mecánicos
INSERT INTO mecanicos (nombre, especialidad, activo) VALUES
('Mateo Rossi', 'Motos de Alta Cilindrada', 1),
('Andrés Gómez', 'Autos de Lujo y Motores V12', 1),
('Sofia Chen', 'Telemetría e Hiperdeportivos', 1),
('Lucas Silva', 'Suspensiones y Frenos Pista', 0);

-- Insertar Servicios
INSERT INTO servicios (nombre, categoria, precio_base, duracion_min) VALUES
('Mantenimiento Preventivo Básico', 'General', 150.00, 60),
('Calibración Telemetría Pista', 'Alto Rendimiento', 850.00, 120),
('Revisión y Aseo Carbocerámico', 'Frenos', 450.00, 90),
('Ajuste Fino Motor V12 / V10', 'Motor', 1200.00, 240),
('Service Oficial Superbike', 'Moto GP/Track', 500.00, 180);

-- Insertar Citas Iniciales
INSERT INTO citas_servicio (vehiculo_id, servicio_id, mecanico_id, fecha_programada, estado, precio_final, notas) VALUES
(1, 2, 3, '2026-08-07 15:30:00', 'pendiente', 850.00, 'Revisión previa a carrera'),
(2, 5, 1, '2026-08-07 16:00:00', 'pendiente', 500.00, 'Ajuste de suspensión de pista'),
(3, 4, 2, '2026-08-08 10:00:00', 'en_proceso', 1200.00, 'Ruido en bajas revoluciones'),
(4, 5, 1, '2026-08-08 11:30:00', 'completada', 550.00, 'Cambio de neumáticos slicks'),
(5, 1, 2, '2026-08-09 08:00:00', 'cancelada', 150.00, 'Cliente viajó de emergencia'),
(6, 2, 3, '2026-08-10 14:00:00', 'pendiente', 850.00, 'Poner a punto mapas de motor'),
(7, 3, 1, '2026-08-10 16:30:00', 'en_proceso', 450.00, 'Cambio de líquido de frenos de alta ebullición'),
(1, 3, 2, '2026-08-11 09:00:00', 'completada', 480.00, 'Chequeo de discos traseros'),
(2, 1, 1, '2026-08-11 11:00:00', 'completada', 150.00, 'Cambio de aceite sintético'),
(3, 2, 3, '2026-08-12 15:00:00', 'pendiente', 850.00, 'Verificación de alerón activo');