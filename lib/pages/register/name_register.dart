//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';

import '../../models/user_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro de Paciente',
            style: TextStyle(
              color: Colors.black,
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
          backgroundColor: const Color(0xFFEDF2FA),
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
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: nombreController,
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
                hintText: 'Nombre(s)',
                errorText: _validateU ?
                'Debe ingresar el nombre de usuario' : null,
                errorStyle: TextStyle(fontSize: 20,),

                contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0,),
              ),
              style: const TextStyle(height: 1.5,),
              onChanged: (text){
                setState(() {
                  if(text.trim().isNotEmpty){
                    _validateU = false;
                  }
                });
              },
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
            TextFormField(
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
                hintText: 'Apellido paterno',
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
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
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
                hintText: 'Apellido materno',
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
                      nombreController.text.isEmpty ?
                      _validateU = true : _validateU = false;
                      if(!_validateU){
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
    user.nombre = nombreController.text;
    user.apellidoP = apellidoPController.text;
    user.apellidoM = apellidoMController.text;
  }
}

TextEditingController nombreController = TextEditingController();
TextEditingController apellidoPController = TextEditingController();
TextEditingController apellidoMController = TextEditingController();

