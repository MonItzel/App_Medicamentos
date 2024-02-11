/*
 * Función que se encarga de validar que sea un nombre
 * @param:
 * string value: Recibe el nombre y apellidos
 * return
 * Devuelve un String
 */

String? validateUser(String value){                                   //\s{0,1} Aceptar 1 o 0 espacios
  // Expresión regular que acepta hasta 40 caracteres y solo letras
  Pattern pattern = r'^[a-zA-ZáéíóúÁÉÍÓÚ ]{1,40}$';
  RegExp regexp = RegExp(pattern.toString());

  if(regexp.hasMatch(value)){
    print('acceso');
    return null;

  }else{
    print('acceso denegado');
    return 'false';
  }
}
