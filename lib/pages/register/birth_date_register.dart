import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import '../../models/user_model.dart';
import 'package:app_medicamentos/constants.dart';

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
                    builder: (BuildContext context) => NameRegister()
                ),
                    (route) => false,
              );
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
                  fechaController.text = fechaNac;
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
                  controller: fechaController,
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
                    //Al presionar le botón llena el objeto y lo pasa a la siguiente pantalla.
                    SetUser();
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => Address(user: widget.user,)
                      ),
                          (route) => false,
                    );
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
    widget.user.fechaNac = fechaNac.toString();
  }
}

TextEditingController fechaController = TextEditingController();