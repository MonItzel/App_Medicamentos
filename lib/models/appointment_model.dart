//Clase para las citas médicas. Contiene atributos con el mismo nombre que en las tablas de la base de datos.
class Appointment{
  int? id_cita;
  String? nombre_medico;
  String? especialidad_medico;
  String? motivo;
  String? ubicacion;
  String? telefono_medico;
  String? fecha;

  Appointment({
    this.id_cita,
    this.nombre_medico,
    this.especialidad_medico,
    this.ubicacion,
    this.motivo,
    this.telefono_medico,
    this.fecha,
  });

  //Regresa la información de la cita médica en forma de map, para facilitar su inserción, actualización o eliminación.
  Map<String, dynamic> toMap() {
    return {
      'id_cita': id_cita,
      'nombre_medico': nombre_medico,
      'especialidad_medico': especialidad_medico,
      'motivo': motivo,
      'ubicacion': ubicacion,
      'telefono_medico': telefono_medico,
      'fecha': fecha,
    };
  }
}