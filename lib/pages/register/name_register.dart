import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';
import '../../models/user_model.dart';
import 'package:app_medicamentos/utils/validaciones.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:app_medicamentos/utils/flashMessage.dart';

class NameRegister extends StatefulWidget {
  const NameRegister({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NameRegister();
  }
}

class _NameRegister extends State <NameRegister> {

  //Objeto usado para pasar la información a la siguiente pantalla.
  final User user = User();

  late bool _validateU = false;
  late bool _validateApp = false;
  late bool _validateApm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro',
              style: AppStyles.encabezado1
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
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
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                  style: AppStyles.texto1
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: AppStyles.contenedorTextForm,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: nombreController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: AppStyles.textFieldEstilo.copyWith(
                   // errorText: _validateU ? '' : null,
                  ),
                  style: AppStyles.texto1,
                  onChanged: (text) {
                    setState(() {
                      convertoUpperCase(text, nombreController, _validateU);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30.0),


            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Apellido paterno',
                  textAlign: TextAlign.left,
                  style: AppStyles.texto1
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: AppStyles.contenedorTextForm,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: apellidoPController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: AppStyles.textFieldEstilo.copyWith(
                    //errorText: _validateApp ? '' : null,
                  ),
                  style: AppStyles.texto1,
                  onChanged: (text) {
                    setState(() {
                      convertoUpperCase(text, apellidoPController, _validateApp);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30.0),


            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Apellido materno (opcional)',
                  textAlign: TextAlign.left,
                  style: AppStyles.texto1
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: AppStyles.contenedorTextForm,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: apellidoMController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: AppStyles.textFieldEstilo,
                  style: AppStyles.texto1,
                  onChanged: (text) {
                    setState(() {
                      convertoUpperCase(text, apellidoMController, 0);
                    });
                  },
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Container(
                width: AppStyles.anchoBoton,
                height: AppStyles.altoBoton,
                child: ElevatedButton(
                  onPressed: () {
                    //Al presionar le botón llena el objeto y lo pasa a la siguiente pantalla.
                    SetUser();
                    setState(() {
                      //Verificar que el nombre completo cumpla las características de la expresión regular
                      String? nombreError = validateUser(nombreController.text);
                      _validateU = nombreError != null;

                      //Verificar que el nombre completo cumpla las características de la expresión regular
                      String? appaternoError = validateUser(apellidoPController.text);
                      _validateApp = appaternoError != null;

                      //Verificar que el nombre completo cumpla las características de la expresión regular
                      String? apmaternoError = validateUser(apellidoMController.text);
                      _validateApm = apmaternoError != null;


                      if(!_validateU && (!_validateApp || !_validateApm)){
                        print(nombreController.text);
                        print(apellidoPController.text);
                        print(apellidoMController.text);
                        Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                              builder: (BuildContext context) => BirthDateRegister(user: user,),
                            ),
                                (route) => false);
                      }else if(_validateU){
                        muestraSnackBar(context, 0);
                      }
                      else if(_validateApp || _validateApm){
                        muestraSnackBar(context, 1);
                      }
                    });
                  },
                  style: AppStyles.botonPrincipal,
                  child: Text("Siguiente",
                    style: AppStyles.textoBoton
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  //Almacena los datos ingresados en esta pantalla en el objeto.
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

