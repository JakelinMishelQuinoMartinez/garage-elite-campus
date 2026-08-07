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