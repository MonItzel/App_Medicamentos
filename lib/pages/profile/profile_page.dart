import 'package:app_medicamentos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/profile/edit_profile.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_medicamentos/utils/msgcall.dart';
import 'package:path/path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {

    // Al ingresar, verifica si debe seleccionar la información del usuario.
    select(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          // Título de la AppBar
          title: Text(
            'Perfil',
            style: AppStyles.encabezado1,
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),

      // Cuerpo de la página
      body: Padding(
        padding: EdgeInsets.all(30.0), // Define el padding deseado
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Muestra el nombre del usuario
            Text(
              'Nombre: ' + nombreController.text + ' ' + apellidoPController.text + ' ' + apellidoMController.text,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),

            // Muestra la fecha de nacimiento del usuario
            Text(
              'Fecha de nacimiento: ' + fechaNacController.text,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),

            // Muestra la dirección del usuario
            Text(
              'Dirección: ' + calleController.text + ' ' + numExteriorController.text + ', ' + coloniaController.text,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),

            // Muestra el cuidador del usuario
            Text(
              'Cuidador: ' + cuidadorController.text,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),

            // Botón para editar el perfil del usuario
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 50),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.small(
                  onPressed: () {
                    // Navega a la página de edición del perfil
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => const EditProfile()
                      ),
                          (route) => false,
                    );
                  },
                  backgroundColor: Color(0xFF09184D),
                  child: Icon(
                      Icons.edit
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),

            // Botón para enviar mensajes
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 50),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.small(
                  onPressed: () {
                    // Navega a la página de mensajes
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => const Message()
                      ),
                          (route) => false,
                    );
                  },
                  backgroundColor: Color(0xFF09184D),
                  child: Icon(
                      Icons.message
                  ),
                ),
              ),
            ),

            // Botón para crear una alarma
            Container(
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: const Text(
                  'Create alarm',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Crea una alarma usando FlutterAlarmClock
                  FlutterAlarmClock.createAlarm(
                      hour: 16,
                      minutes: 08,
                      title: 'Hora de tomar sus medicamentos'
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Barra de navegación inferior personalizada
      bottomNavigationBar: Container(
        child: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              // Navega a la página de inicio
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const HomePage(),
                ),
                    (route) => false,
              );
            } else if (index == 1) {
              // Navega a la página del calendario
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CalendarPage(),
                ),
                    (route) => false,
              );
            } else if (index == 2) {
              // Muestra algún contenido no especificado
            } else if (index == 3) {
              // Navega a la página de registros
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const RecordsPage(),
                ),
                    (route) => false,
              );
            } else if (index == 4) {
              // Página actual, no necesita navegación
            }
          },
        ),
      ),
    );
  }

  // Llena los campos de la pantalla con los datos del usuario
  Future<void> select(var context) async {

    // Si no hay información mostrándose en la pantalla, selecciona los datos del usuario
    if(nombreController.text == "" &&
        apellidoPController.text == "" &&
        apellidoMController.text == "" &&
        fechaNacController.text == "" &&
        calleController.text == "" &&
        coloniaController.text == "" &&
        numExteriorController.text == "" &&
        cuidadorController.text == ""){
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> map1 = await database.rawQuery(
        'SELECT * FROM Usuario LIMIT 1',
      );
      final List<Map<String, dynamic>> map2 = await database.rawQuery(
        'SELECT * FROM Padecimiento LIMIT 1',
      );

      print("map1: " + map1.length.toString());
      print("map2: " + map2.length.toString());
      print(map1[0]['nombre'].toString());

      // Llena los TextEditingController con los datos del usuario y vuelve a generar la pantalla
      nombreController.text = map1[0]['nombre'].toString();
      apellidoPController.text =  map1[0]['apellidoP'].toString();
      apellidoMController.text = map1[0]['apellidoM'].toString();
      fechaNacController.text = map1[0]['fechaNac'].toString();
      calleController.text = map1[0]['calle'].toString();
      coloniaController.text = map1[0]['club'].toString();
      numExteriorController.text = map1[0]['numero_exterior'].toString();
      cuidadorController.text = map1[0]['cuidador_nombre'].toString() + "\n" + map1[0]['cuidador_telefono'].toString();

      print(cuidadorController.text);

      Navigator.pushAndRemoveUntil <dynamic>(
        context,
        MaterialPageRoute <dynamic>(
            builder: (BuildContext context) => const ProfilePage()
        ),
            (route) => false,
      );
    }
  }
}

// Controladores para manejar la entrada de texto en los campos del formulario
TextEditingController nombreController = TextEditingController();
TextEditingController apellidoPController = TextEditingController();
TextEditingController apellidoMController = TextEditingController();
TextEditingController fechaNacController = TextEditingController();
TextEditingController calleController = TextEditingController();
TextEditingController coloniaController = TextEditingController();
TextEditingController numExteriorController = TextEditingController();
TextEditingController cuidadorController = TextEditingController();
