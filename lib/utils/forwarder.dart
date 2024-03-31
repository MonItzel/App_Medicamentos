//Clase creada para seleccionar al usuario antes de generar StartPage o HomePage.

import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/reminder_model.dart';
import '../pages/start_page.dart';

class Forwarder extends StatefulWidget {
  const Forwarder({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Forwarder();
  }
}

class _Forwarder extends State <Forwarder> {

  @override
  Widget build(BuildContext context) {
     select(context);

    return Scaffold();
  }

  //Selecciona la información del usuario y dependiendo del resultado lleva a otra pantalla.
  Future<void> select(BuildContext context) async {

    try {
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> map1 = await database.rawQuery(
        'SELECT * FROM Usuario LIMIT 1',
      );

      //Si ya hay un usuario registrado.
      if (map1.length > 0) {
        print(map1[0]['nombre'].toString());

        Reminder reminder = Reminder();
        //Crea los recordatorios de los próximos 30 días si es tiempo.
        await reminder.CreateMedicamentsReminders();
        //Crea las alarmas para el día actual.
        await reminder.SetAlarms();

        //Lleva a la pantalla principal.
        Navigator.pushAndRemoveUntil <dynamic>(
          context,
          MaterialPageRoute <dynamic>(
              builder: (BuildContext context) => const HomePage()
          ),
              (route) => false,
        );
      }
    }catch(exception){
      //Si se arroja una exepción, no se han creado las tablas y lleva al registro.
      print('estoy aqui');
      print(exception);
      Navigator.pushAndRemoveUntil <dynamic>(
        context,
        MaterialPageRoute <dynamic>(
            builder: (BuildContext context) => const StartPage()
        ),
            (route) => false,
      );
    }
  }
}