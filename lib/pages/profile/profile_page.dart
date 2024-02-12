import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:app_medicamentos/pages/register/carer.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/profile/edit_profile.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_medicamentos/utils/msgcall.dart';
import 'package:path/path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app_medicamentos/constants.dart';

import '../../models/user_model.dart';
import '../register/birth_date_register.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 0), // Define el padding deseado
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Icono de perfil
              Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Container(
                      child: Image.asset('assets/images/icon_profile2.png'),
                    ),
                  ),
                ),
              ),


              //Informacion personal
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Información personal',
                          style: AppStyles.encabezado2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          UpdateInfoPersonal(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Nombre(s)',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    nombreController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Apellido(s)',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    apellidoPController.text + ' ' + apellidoMController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: AppStyles.divider,
              ),


              //Fecha de nacimiento
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Fecha de nacimiento',
                          style: AppStyles.encabezado2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          UpdateBirthdate(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    fechaNacController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: AppStyles.divider,
              ),


              //Domicilio
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Domicilio',
                          style: AppStyles.encabezado2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          UpdateAddress(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Calle',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    calleController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Número exterior',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    numExteriorController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Colonia/Barrio',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    coloniaController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: AppStyles.divider,
              ),


              //Cuidador
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Cuidador',
                          style: AppStyles.encabezado2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          UpdateCarer(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Nombre',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    cuidadorController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text(
                    'Número de teléfono',
                    style: AppStyles.texto2,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    numCuidadorController.text,
                    style:AppStyles.texto3,
                  ),
                ),
              ),

            ],
          ),
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
        cuidadorController.text == "" &&
        numCuidadorController.text == ""){
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
      cuidadorController.text = map1[0]['cuidador_nombre'].toString().split(',')[0] + map1[0]['cuidador_nombre'].toString().split(',')[1];
      numCuidadorController.text = map1[0]['cuidador_telefono'].toString();

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

  Future<void> UpdateCarer(BuildContext context) async{

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    final user = User(
      id_usuario: int.parse(map1[0]['id_usuario'].toString()),
      cuidador_nombre: map1[0]['cuidador_nombre'].toString(),
      cuidador_telefono: map1[0]['cuidador_telefono'].toString()
    );

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => CarerPage(user: user)
      ),
          (route) => false,
    );
  }

  Future<void> UpdateAddress(BuildContext context) async{

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    final user = User(
        id_usuario: int.parse(map1[0]['id_usuario'].toString()),
        calle: map1[0]['calle'].toString(),
        numExterior: map1[0]['numero_exterior'].toString(),
        club: map1[0]['club'].toString()
    );

    calleController.text = '';
    numExteriorController.text = '';
    coloniaController.text = '';

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => Address(user: user)
      ),
          (route) => false,
    );
  }

  Future<void> UpdateBirthdate(BuildContext context) async{

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    final user = User(
        id_usuario: int.parse(map1[0]['id_usuario'].toString()),
        fechaNac: map1[0]['fechaNac'].toString(),
    );

    fechaNacController.text = '';

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => BirthDateRegister(user: user)
      ),
          (route) => false,
    );
  }

  Future<void> UpdateInfoPersonal(BuildContext context) async{

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    final user = User(
      id_usuario: int.parse(map1[0]['id_usuario'].toString()),
      nombre: map1[0]['nombre'].toString(),
      apellidoP: map1[0]['apellidoP'].toString(),
      apellidoM: map1[0]['apellidoM'].toString(),
    );

    nombreController.text = '';
    apellidoPController.text = '';
    apellidoMController.text = '';

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => NameRegister(user: user)
      ),
          (route) => false,
    );
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
TextEditingController numCuidadorController = TextEditingController();
