//Clase para el usuario. Contiene atributos con el mismo nombre que en las tablas de la base de datos.
class User{
   int? id_usuario;
   String? nombre;
   String? apellidoP;
   String? apellidoM;
   String? fechaNac;
   String? telefono;
   String? calle;
   String? club;
   String? numExterior;
   String? numInterior;
   bool? cuidador_activo;
   String? cuidador_nombre;
   String? cuidador_telefono;

  User({
    this.id_usuario,
    this.nombre,
    this.apellidoP,
    this.apellidoM,
    this.fechaNac,
    this.telefono,
    this.calle,
    this.numExterior,
    this.numInterior,
    this.club,
    this.cuidador_activo,
    this.cuidador_nombre,
    this.cuidador_telefono
  });

   //Regresa la información del usuario en forma de map, para facilitar su inserción, actualización o eliminación.
   Map<String, dynamic> toMap() {
    return {
      'id_usuario': id_usuario,
      'nombre': nombre,
      'apellidoP': apellidoP,
      'apellidoM': apellidoM,
      'telefono': telefono,
      'fechaNac': fechaNac,
      'calle' : calle,
      'numero_exterior' : numExterior,
      'numero_interior' : numInterior,
      'club': club,
      'cuidador_activo': cuidador_activo,
      'cuidador_nombre': cuidador_nombre,
      'cuidador_telefono': cuidador_telefono
    };
  }
}