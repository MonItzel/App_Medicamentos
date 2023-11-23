import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';
import '../../models/user_model.dart';
import 'package:app_medicamentos/utils/validaciones.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';

class NameRegister extends StatefulWidget {
  const NameRegister({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NameRegister();
  }
}

class _NameRegister extends State <NameRegister> {

  final User user = User();

  //Declaración de variables para validar las entradas ingresadas por el usuario
  late bool _validateU = false;
  late bool _validateApp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro de paciente',
              style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => StartPage()
                ),
                    (route) => false,
              );
            },
          ),
          actions: const [],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Nombre(s)',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nombreController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validateU ? 'Debe ingresar su nombre(s) \ncorrectamente' : null,

                    errorStyle: TextStyle(fontSize: 20, color: Color(0xFFFF1744), fontWeight: FontWeight.bold),

                    contentPadding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                  ),
                  style: const TextStyle(height: 1.5),
                  onChanged: (text) {
                    setState(() {
                      convertoUpperCase(text, nombreController, _validateU);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Apellido paterno',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: apellidoPController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid

                        )
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validateApp ? 'Debe ingresar su apellido paterno \ncorrectamente' : null,
                    errorStyle: TextStyle(fontSize: 20, color: Color(0xFFFF1744), fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(height: 1.5),
                  onChanged: (text) {
                    setState(() {
                      convertoUpperCase(text, apellidoPController, _validateApp);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Apellido materno',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    /*fontWeight: FontWeight.bold,*/
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextFormField(
                controller: apellidoMController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid

                      )
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(height: 1.5),
                onChanged: (text) {
                  setState(() {
                    convertoUpperCase(text, apellidoMController, 0);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                width: 193,
                height: 77,
                child: ElevatedButton(
                  onPressed: () {
                    SetUser();
                    setState(() {
                      //Verificar que el nombre completo cumpla las características de la expresión regular
                      String? nombreError = validateUser(nombreController.text);
                      _validateU = nombreError != null;

                      //Verificar que el nombre completo cumpla las características de la expresión regular
                      String? appaternoError = validateUser(apellidoPController.text);
                      _validateApp = appaternoError != null;

                      if(!_validateU && !_validateApp ){
                        print(nombreController.text);
                        print(apellidoPController.text);
                        print(apellidoMController.text);
                        Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                              builder: (BuildContext context) => BirthDateRegister(user: user,),
                            ),
                                (route) => false);
                      }
                      //  );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0063C9),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  child: Text("Siguiente",
                    style: TextStyle(
                        fontSize: 26
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void SetUser(){
    nombreController.text = nombreController.text.trim();
    apellidoMController.text = apellidoMController.text.trim();
    apellidoMController.text = apellidoMController.text.trim();


    user.nombre = nombreController.text;
    user.apellidoP = apellidoPController.text;
    user.apellidoM = apellidoMController.text;
  }
}

TextEditingController nombreController = TextEditingController();
TextEditingController apellidoPController = TextEditingController();
TextEditingController apellidoMController = TextEditingController();

