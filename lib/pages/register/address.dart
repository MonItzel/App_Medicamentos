import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';
import 'package:app_medicamentos/pages/register/pathologies.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/user_model.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:path/path.dart';

import '../profile/profile_page.dart';

class Address extends StatefulWidget {
  const Address({super.key, required User this.user});

  //Objeto usado para pasar la inforamción a la siguiente pantalla.
  final User user;

  @override
  State<StatefulWidget> createState() {
    return _Address();
  }
}

class _Address extends State <Address> {
  String buttonText = "Siguiente";

  @override
  Widget build(BuildContext context) {
    if(widget.user.id_usuario != null && calleController.text == '' && numExteriorController.text == '' && numInteriorController.text == '' && coloniaController.text == ''){
      buttonText = 'Guardar';
      calleController.text = widget.user.calle.toString();
      numExteriorController.text = widget.user.numExterior.toString();
      numInteriorController.text = widget.user.numInterior.toString();
      coloniaController.text = widget.user.club.toString();
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
                color: Colors.black),
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
                      builder: (BuildContext context) => BirthDateRegister(user: widget.user)
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
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Domicilio (opcional)',
                    style: AppStyles.encabezado2,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Calle',
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
                      controller: calleController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(
                        // errorText: _validateU ? '' : null,
                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertFirstWordUpperCase(text, calleController);
                        });
                      },
                    ),
                  ),
                ),
              ),


              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'No. Exterior',
                                  style: AppStyles.texto1,
                                ),
                              ),
                            ),

                            Container(
                              decoration: AppStyles.contenedorTextForm,
                              child: TextFormField(
                                controller: numExteriorController,
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: AppStyles.textFieldEstilo.copyWith(

                                ),
                                style: AppStyles.texto1,
                                onChanged: (text) {
                                  setState(() {
                                    convertFirstWordUpperCase(text, numExteriorController);
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(
                          width: 20
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'No. Interior',
                                  style: AppStyles.texto1,
                                ),
                              ),
                            ),

                            Container(
                              decoration: AppStyles.contenedorTextForm,
                              child: TextFormField(
                                controller: numInteriorController,
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: AppStyles.textFieldEstilo.copyWith(

                                ),
                                style: AppStyles.texto1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Colonia/Barrio',
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
                      controller: coloniaController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(
                        // errorText: _validateU ? '' : null,
                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertFirstWordUpperCase(text, coloniaController);
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
                        if(widget.user.id_usuario != null){
                          //Si el user ya tiene un id, actualiza la información del usuario
                          update(context);
                        }else{
                          //Al presionar le botón llena el objeto y lo pasa a la siguiente pantalla.
                          SetUser();
                          Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                                builder: (BuildContext context) => Pathologies(user: widget.user, pathologies: [],)
                            ),
                                (route) => false,
                          );
                        }
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
    widget.user.calle = calleController.text;
    widget.user.club = coloniaController.text;
    widget.user.numExterior = numExteriorController.text;
    widget.user.numInterior = numInteriorController.text;
  }

  void update(BuildContext context) async{
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    widget.user.calle = calleController.text;
    widget.user.numExterior = numExteriorController.text;
    widget.user.numInterior = numInteriorController.text;
    widget.user.club = coloniaController.text;

    var usuario = {
      'id_usuario': widget.user.id_usuario,
      'calle': widget.user.calle,
      'numero_exterior': widget.user.numExterior,
      'numero_interior' : widget.user.numInterior,
      'club': widget.user.club
    };

    await database.transaction((txn) async {
      var id1 = txn.update('Usuario', usuario);
    });

    //cuidadorController.text = widget.user.cuidador_nombre.toString();
    //numCuidadorController.text = widget.user.cuidador_telefono.toString();

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => ProfilePage()
      ),
          (route) => false,
    );
  }
}