import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_medicamentos/models/user_model.dart';
import 'package:app_medicamentos/utils/validaciones.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:app_medicamentos/utils/flashMessage.dart';
import 'package:path/path.dart';

class NameRegister extends StatefulWidget {
  const NameRegister({super.key, required User this.user});
  final User user;

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

  String buttonText = "Siguiente";
  @override
  Widget build(BuildContext context) {
    if(widget.user.id_usuario != null && nombreController.text == '' && apellidoPController.text == '' && apellidoMController.text == ''){
      buttonText = 'Guardar';
      nombreController.text = widget.user.nombre.toString();
      apellidoPController.text = widget.user.apellidoP.toString();
      apellidoMController.text = widget.user.apellidoM.toString();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text(
            widget.user.id_usuario != null ? 'Editar usuario' : 'Registro',
              style: AppStyles.encabezado1
          ),

          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
            ),
            onPressed: () {
              if(widget.user.id_usuario != null){
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => ProfilePage()
                  ),
                      (route) => false,
                );
              }
              else{
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => StartPage()
                  ),
                      (route) => false,
                );
              }
            },
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              //Informacion personal
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Información personal',
                    style: AppStyles.encabezado2,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nombre(s)',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
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
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Apellido paterno',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: apellidoPController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(
                        // errorText: _validateU ? '' : null,
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
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Apellido materno',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: apellidoMController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(
                        // errorText: _validateU ? '' : null,
                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertoUpperCase(text, apellidoMController, _validateApm);
                        });
                      },
                    ),
                  ),
                ),
              ),


              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    width: double.infinity,
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

                            if(widget.user.id_usuario != null){
                              //Si el user ya tiene un id, actualiza la información del usuario
                              update(context);
                            }else{
                              //Al presionar le botón llena el objeto y lo pasa a la siguiente pantalla.
                              SetUser();
                              Navigator.pushAndRemoveUntil <dynamic>(
                                  context,
                                  MaterialPageRoute <dynamic>(
                                    builder: (BuildContext context) => BirthDateRegister(user: user,),
                                  ),
                                      (route) => false);
                            }
                          }else if(_validateU){
                            muestraSnackBar(context, 0);
                          }
                          else if(_validateApp || _validateApm){
                            muestraSnackBar(context, 1);
                          }
                        });
                      },
                      style: AppStyles.botonPrincipal,
                      child: Text(buttonText,
                        style: AppStyles.textoBoton
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  void update(BuildContext context) async{
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    widget.user.nombre = nombreController.text;
    widget.user.apellidoP = apellidoPController.text;
    widget.user.apellidoM = apellidoMController.text;

    var usuario = {
      'id_usuario': widget.user.id_usuario,
      'nombre': widget.user.nombre,
      'apellidoP': widget.user.apellidoP,
      'apellidoM': widget.user.apellidoM
    };

    await database.transaction((txn) async {
      var id1 = txn.update('Usuario', usuario);
    });

    nombreController.text = widget.user.nombre.toString();
    apellidoPController.text = widget.user.apellidoP.toString();
    apellidoMController.text = widget.user.apellidoM.toString();

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => ProfilePage()
      ),
          (route) => false,
    );
  }
}

