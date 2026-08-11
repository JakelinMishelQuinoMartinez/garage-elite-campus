# Requerimiento

## Requerimientos técnicos
- Base de datos sugerida: campuslands_mysql.
- Motor: InnoDB en todas las tablas.
- Usar INT AUTO_INCREMENT o identificadores consistentes para llaves primarias.
- Usar FOREIGN KEY para relacionar clientes, vehiculos, mecanicos, servicios y citas.
- Usar tipos correctos: DECIMAL para precios, DATE o DATETIME para fechas, VARCHAR con limites razonables.
- Evitar nombres ambiguos como dato1, info, tabla1 o valor.
- Incluir al menos 5 clientes, 7 vehiculos, 5 servicios, 4 mecanicos y 10 citas.
- Crear minimo 5 consultas de reporte en dql/consultas.sql.

## Tablas mínimas esperadas
- clientes
- vehiculos
- mecanicos
- servicios
- cita_servicios

## Normativa para procedimientos almacenados
- Los procedimientos deben empezar con prefijo sp_.
- Usa nombres claros: sp_crear_cita_servicio, no sp_insertar.
- Los parametros de entrada deben iniciar con p_, por ejemplo p_vehiculo_id.
- Cuando devuelvas un id creado, usa parametro OUT p_cita_id o retorna un SELECT claro.
- Valida existencia de registros relacionados antes de crear o actualizar una cita.
- Valida que el precio no sea negativo y que la fecha programada no sea nula.
- Usa estados controlados: pendiente, en_proceso, completada, cancelada.
- Para cancelacion, no borres la cita fisicamente: cambia el estado a cancelada.
- Usa SIGNAL SQLSTATE '45000' para errores de negocio.
- Incluye comentarios SQL breves en partes importantes.

## Procedimientos que debes crear
1. **Crear cita:** sp_crear_cita_servicio debe recibir vehiculo, servicio, mecanico, fecha, precio final y notas. Debe validar que los ids existan y que el mecanico este activo. Si todo esta bien, crea la cita en estado pendiente.
2. **Consultar citas:** sp_listar_citas_servicio debe permitir filtrar por estado. Si el estado viene NULL, debe listar todas. El resultado debe mostrar datos entendibles: cliente, vehiculo, servicio, mecanico, fecha, estado y precio.
3. **Actualizar cita:** sp_actualizar_cita_servicio debe permitir cambiar mecanico, fecha, estado, precio final y notas. Debe validar estados permitidos y evitar actualizar una cita cancelada.
4. **Cancelar cita:** sp_cancelar_cita_servicio debe cambiar el estado a cancelada y agregar una nota de cancelacion. No debe usar DELETE fisico.
5. **Eliminar controlado opcional:** Si quieres demostrar DELETE, crea sp_eliminar_cita_borrador que solo elimine citas en estado pendiente y sin trabajo iniciado. Debe explicar por que no se permite borrar citas completadas.