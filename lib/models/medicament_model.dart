//Clase para los medicamentos. Contiene atributos con el mismo nombre que en las tablas de la base de datos.
class Medicament{
  int? id_medicamento;
  String? nombre;
  String? descripcion;
  String? dosis;
  String? inicioToma;
  String? finToma;
  String? frecuenciaTipo;
  int? frecuenciaToma;

  Medicament({
    this.id_medicamento,
    this.nombre,
    this.descripcion,
    this.dosis,
    this.inicioToma,
    this.finToma,
    this.frecuenciaTipo,
    this.frecuenciaToma,
  });

  //Regresa la información del medicamento en forma de map, para facilitar su inserción, actualización o eliminación.
  Map<String, dynamic> toMap() {
    return {
      'id_medicamento': id_medicamento,
      'nombre': nombre,
      'descripcion': descripcion,
      'dosis': dosis,
      'inicioToma': inicioToma,
      'finToma': finToma,
      'frecuenciaTipo': frecuenciaTipo,
      'frecuenciaToma': frecuenciaToma
    };
  }
}