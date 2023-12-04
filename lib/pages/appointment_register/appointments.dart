import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/appointment_register/appointments_date.dart';
import 'package:app_medicamentos/models/appointment_model.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppointmentsPage();
  }
}

class _AppointmentsPage extends State <AppointmentsPage> {
  // Definición del formateador de máscara para el número de teléfono
  var maskFormatter = MaskTextInputFormatter(mask: '### ### ####', filter: {"#": RegExp(r'[0-9]')});

  // Objeto que se usará para pasar la información de la cita a la próxima pantalla.
  final  Appointment appointment = Appointment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Agendar cita',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              // Navegar de regreso a la página de inicio
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => HomePage()
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Sección para el nombre del médico
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Nombre del médico',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Campo de entrada para el nombre del médico
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
                controller: nombreMedicoController,
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
                onChanged: (text) {
                  // Convertir a mayúsculas el primer carácter de cada palabra
                  setState(() {
                    convertoUpperCase(text, nombreMedicoController, 0);
                  });
                },
              ),
            ),
            SizedBox(height: 20.0,),
            // Sección para el motivo de la cita médica
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Motivo de cita médica',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Campo de entrada para el motivo de la cita médica
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
                controller: motivoController,
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
                onChanged: (text) {
                  // Convertir a mayúsculas el primer carácter de la primera palabra
                  setState(() {
                    convertFirstWordUpperCase(text, motivoController);
                  });
                },
              ),
            ),
            SizedBox(height: 20.0,),
            // Sección para el lugar de la cita médica
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Lugar de cita médica',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Campo de entrada para el lugar de la cita médica
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
                controller: lugarController,
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
                onChanged: (text) {
                  // Convertir a mayúsculas el primer carácter de la primera palabra
                  setState(() {
                    convertFirstWordUpperCase(text, lugarController);
                  });
                },
              ),
            ),
            SizedBox(height: 20.0,),
            // Sección para el teléfono del médico
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Teléfono del médico',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Campo de entrada para el teléfono del médico con máscara
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
                controller: telefonoMedicoController,
                keyboardType: TextInputType.phone,
                inputFormatters: [maskFormatter],
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
              ),
            ),
            // Botón para avanzar a la siguiente pantalla
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Container(
                width: 193,
                height: 77,
                child: ElevatedButton(
                  onPressed: () {
                    // Al presionar el botón se llena el modelo de la cita y se pasa a la siguiente pantalla.
                    SetAppointment();
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => AppointmentsDatePage(appointment: appointment,)
                      ),
                          (route) => false,
                    );
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

  // Llena el modelo con la información ingresada en esta pantalla.
  void SetAppointment(){
    appointment.nombre_medico = nombreMedicoController.text;
    appointment.motivo = motivoController.text;
    appointment.ubicacion = lugarController.text;
    appointment.telefono_medico = telefonoMedicoController.text.replaceAll(' ', '');
  }
}

// Controladores de texto para los campos de entrada
TextEditingController nombreMedicoController = TextEditingController();
TextEditingController motivoController = TextEditingController();
TextEditingController lugarController = TextEditingController();
TextEditingController telefonoMedicoController = TextEditingController();
