import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import '../../models/user_model.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../profile/profile_page.dart';

class BirthDateRegister extends StatefulWidget {
  const BirthDateRegister({required User this.user});

  //Objeto usado para pasar la inforamción a la siguiente pantalla.
  final  User user;

  @override
  State<StatefulWidget> createState() {
    return _BirthDateRegister();
  }
}

class _BirthDateRegister extends State <BirthDateRegister> {
  var fechaNac, dia, mes, anio;
  final List<String> meses = [
    'ENE', 'FEB', 'MAR', 'ABR',
    'MAY', 'JUN', 'JUL', 'AGO',
    'SEP', 'OCT', 'NOV', 'DIC'
  ];

  String buttonText = "Siguiente";
  DateTime lastDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    if(widget.user.id_usuario != null && fechaNacController.text == ''){
      try{
        buttonText = 'Guardar';
        fechaNacController.text = widget.user.fechaNac.toString();

        int day = int.parse(widget.user.fechaNac.toString().split('/')[0]);
        int year = int.parse(widget.user.fechaNac.toString().split('/')[2]);
        int month = 0;
        switch(widget.user.fechaNac.toString().split('/')[1]){
          case ' ENE ':
            month = 1;
            break;
          case ' FEB ':
            month = 2;
            break;
          case ' MAR ':
            month = 3;
            break;
          case ' ABR ':
            month = 4;
            break;
          case ' MAY ':
            month = 5;
            break;
          case ' JUN ':
            month = 6;
            break;
          case ' JUL ':
            month = 7;
            break;
          case ' AGO ':
            month = 8;
            break;
          case ' SEP ':
            month = 9;
            break;
          case ' OCT ':
            month = 10;
            break;
          case ' NOV ':
            month = 11;
            break;
          case ' DIC ':
            month = 12;
            break;
        }
        lastDate = DateTime(year, month, day);
        print(lastDate);
      }catch(ex){
      }
    }

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
              if(widget.user.id_usuario != null){
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => ProfilePage()
                  ),
                      (route) => false,
                );
              }else{
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => NameRegister(user: new User(),)
                  ),
                      (route) => false,
                );
              }
            },
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                    'Seleccione su fecha de nacimiento',
                    textAlign: TextAlign.left,
                    style: AppStyles.tituloCard
                ),
              ),
            ),
            SizedBox(height: 10),
            DatePickerWidget(
              locale: DateTimePickerLocale.es,
              firstDate: DateTime.utc(1954,01,01),
              initialDate: lastDate,
              lastDate: DateTime.now(),
              dateFormat: 'dd MMMM yyyy',
              pickerTheme: DateTimePickerTheme(
                backgroundColor: Colors.transparent,
                dividerColor: Color(0xFF0063C9),
                itemTextStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 25,
                    color: Colors.black
                ),
              ),
              onChange: (DateTime args, _) {
                setState(() {
                  dia = args.day.toString();
                  mes = meses[args.month - 1];
                  anio = args.year.toString();
                  fechaNac = dia + ' / ' + mes + ' / ' + anio;
                  fechaNacController.text = fechaNac;
                });
                },
            ),
            SizedBox(height: 80.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                    'Fecha seleccionada',
                    textAlign: TextAlign.left,
                    style: AppStyles.tituloCard
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 8.0, right: 14.0),
              child: Container(
                decoration: AppStyles.contenedorTextForm,
                child: TextFormField(
                  controller: fechaNacController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  decoration: AppStyles.textFieldEstilo,
                  style: AppStyles.texto1,
                  enabled: false,
                ),
              ),
            ),
            SizedBox(height: 80.0,),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Container(
                width: AppStyles.anchoBoton,
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
                            builder: (BuildContext context) => Address(user: widget.user,)
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
            )
          ],
        ),
      ),
    );
  }

  //Almacena los datos ingresados en esta pantalla en el objeto.
  void SetUser(){
    widget.user.fechaNac = fechaNac.toString();
  }

  void update(BuildContext context) async{
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    widget.user.fechaNac = fechaNacController.text;

    var usuario = {
      'id_usuario': widget.user.id_usuario,
      'fechaNac': widget.user.fechaNac,
    };

    await database.transaction((txn) async {
      var id1 = txn.update('Usuario', usuario);
    });

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => ProfilePage()
      ),
          (route) => false,
    );
  }
}
