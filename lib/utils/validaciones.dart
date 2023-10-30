/*
 * Función que se encarga de validar que sea un nombre
 * @param:
 * string value: Recibe el nombre y apellidos
 * return
 * Devuelve un String
 */

String? validateNombre(String value){
  Pattern pattern = r'(^[a-zA-Z0-9 ]*$)';
  RegExp regexp = RegExp(pattern.toString());
  if(regexp.hasMatch(value)){
    return 'true';
  }else{
    return 'false';
  }
}


/*
 * Función que se encarga de validar que sea un correo electrónico
 * @param:
 * string value: Recibe el correo
 * return
 * Devuelve un String
 */

String? validateEmail(String value){
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regexp = RegExp(pattern.toString());
  if(regexp.hasMatch(value)){
    return 'true';
  }else{
    return 'false';
  }
}