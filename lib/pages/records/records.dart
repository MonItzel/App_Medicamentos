import 'dart:async';
import 'dart:io';

import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:page_transition/page_transition.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:app_medicamentos/utils/buttonSheet.dart';


class RecordsPage extends StatefulWidget{
  const RecordsPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _RecordsPage();
  }
}

class _RecordsPage extends State <RecordsPage>{
  int _currentIndex = 3;

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), CheckMedicament);

  @override
  Widget build(BuildContext context){
    scheduleTimeout(300);

    //Al ingresar verifica si debe crear nuevas cartas.
    CreateCards(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registros',
            style: AppStyles.encabezado1,
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),

      body: Container(
          height: 720, // Establece la altura del Container a 200 píxeles
          child: new ListView(
            children: recordsPageCards,
          )
      ),

      bottomNavigationBar: Container(
        child: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const HomePage(),
                ),
                    (route) => false,
              );
            } else if (index == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CalendarPage(),
                ),
                    (route) => false,
              );
            } else if (index == 2) {
              //muestraButtonSheet(context);
            } else if (index == 3) {
              //Pagina actual, no necesita navegacion
            } else if (index == 4) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const ProfilePage(),
                ),
                    (route) => false,
              );
            }
          },
        ),
      ),
    );
  }


  //Si no hay cartas seleccioan la información y las crea.
  Future<void> CreateCards(BuildContext context) async {
    try{
      if(recordsPageCards.length < 1){
        Database database = await openDatabase(
            Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        //Selecciona todos los medicamentos registrados y genera sus cartas.
        final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
          "SELECT * FROM Medicamento",
        );

        if(medicamentos.length > 0){
          for(int i = 0; i < medicamentos.length; i++){
            recordsPageCards.add(Card(
              elevation: 3, // Elevación para dar profundidad al card
              margin: EdgeInsets.all(16), // Margen alrededor del card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Borde redondeado con radio de 15
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.medication_liquid, size: 40), // Icono de medicina a la izquierda
                    title: Text(
                      medicamentos[i]['nombre'].toString(), //Nombre del medicamento
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cada ' + medicamentos[i]['frecuenciaToma'].toString() + ' ' + medicamentos[i]['frecuenciaTipo'].toString() + 's'),
                        Text("Dosis: " + medicamentos[i]['dosis'].toString()), //Dosis del medicamento
                      ],
                    ),
                    trailing: Text(
                      "Inicio: " + medicamentos[i]['inicioToma'].toString().split(" ")[0], //Fecha de inicio
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Botón para eliminar este medicamento.
                  SizedBox(height: 1.0, width: 1.0,),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.small(
                        heroTag: "DeleteM" + medicamentos[i]['id_medicamento'].toString(),
                        onPressed: () async {
                          deleteResult = await DeleteMedicament(medicamentos[i]['id_medicamento'].toString());
                        },
                        backgroundColor: Color(0xFF09184D),
                        child: Icon(
                            Icons.delete
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.0, width: 1.0,),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.small(
                        heroTag: "EditM" + medicamentos[i]['id_medicamento'].toString(),
                        onPressed: () {
                          EditMedicament(medicamentos[i]['id_medicamento'].toString(), context);
                        },
                        backgroundColor: Color(0xFF09184D),
                        child: Icon(
                            Icons.edit
                        ),
                      ),
                    ),
                  ),
                ],
              )
            )
            );
          }
        }

        print("medicamentos: " + medicamentos.length.toString());
        print("cards: " + recordsPageCards.length.toString());


        //Selecciona todas las citas registradas y genera sus cartas.
        final List<Map<String, dynamic>> citas = await database.rawQuery(
          "SELECT * FROM Cita AS C INNER JOIN Recordatorio AS R ON C.id_cita = R.id_cita",
        );

        if(citas.length > 0) {
          for(int i = 0; i < citas.length; i++){
            recordsPageCards.add(Card(
              elevation: 3, // Elevación para dar profundidad al card
              margin: EdgeInsets.all(16), // Margen alrededor del card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    15), // Borde redondeado con radio de 15
              ),
              child: Column(
                children: <Widget>[
                      ListTile(
                    leading: Icon(Icons.medical_services, size: 40),
                    // Icono de medicina a la izquierda
                    title: const Text(
                      //citas[i]['motivo'].toString(),
                      'Cita Médica',
                      //Titulo
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hora: ' + citas[i]['fecha_hora']
                            .toString().split(" ")[1].split(".")[0]),
                        Text("Ubicacion: " +
                            citas[i]['ubicacion'].toString()),
                        //Dosis del medicamento
                      ],
                    ),
                    trailing: Text(
                      "Telefono: " +
                          citas[i]['telefono_medico'].toString(), //Fecha de inicio
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Botón para eliminar esta cita.
                  SizedBox(height: 1.0, width: 1.0,),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.small(
                        heroTag: "DeleteC" + medicamentos[i]['id_medicamento'].toString(),
                        onPressed: () async {
                          int result = await DeleteAppointment(citas[i]['id_cita'].toString());
                          print('res de delete med');
                          print(result);
                          muestraButtonSheet(context, result);
                          var duration = const Duration(seconds: 3);
                          print('Start sleeping');
                          sleep(duration);
                          print('5 seconds has passed');


                          Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                                builder: (BuildContext context) => const RecordsPage()
                            ),
                                (route) => false,
                          );
                        },
                        backgroundColor: Color(0xFF09184D),
                        child: Icon(
                            Icons.delete
                        ),
                      ),
                    ),
                  ),
                  /*SizedBox(height: 1.0, width: 1.0,),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.small(
                        heroTag: "EditC" + medicamentos[i]['id_medicamento'].toString(),
                        onPressed: () {
                          DeleteAppointment(citas[i]['id_cita'].toString());
                        },
                        backgroundColor: Color(0xFF09184D),
                        child: Icon(
                            Icons.edit
                        ),
                      ),
                    ),
                  ),*/
                ]
              )
            )
            );
          }
        }

        print("citas: " + citas.length.toString());
        print("cards: " + homePageCards.length.toString());

        //Cuando se crearon las cartas vuelve a generar la pantalla.
        if(medicamentos.length > 0 || citas.length > 0)
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
                builder: (BuildContext context) => const RecordsPage()
            ),
                (route) => false,
          );
      }
    }catch(exception){
      print(exception);
    }
  }

  //Intenta eliminar la cita y su recordatorio con el id que recibe.
  Future<int> DeleteAppointment(String id) async {
      print("id_cita " + id);
      try{
        calendarPageCards.clear();
        Database database = await openDatabase(
            Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

        final List<Map<String, dynamic>> citas = await database.rawQuery(
          "DELETE FROM Cita WHERE id_cita = " + id,
        );
        final List<Map<String, dynamic>> rCitas = await database.rawQuery(
          "DELETE FROM Recordatorio WHERE id_cita = " + id,
        );

        homePageCards.clear();
        calendarPageCards.clear();
        recordsPageCards.clear();
        return 8;
      }catch(exception){
        print(exception);
        return 9;
      }
  }

  //Intenta eliminar el medicamento y sus recordatorios con el id que recibe.
  Future<int> DeleteMedicament(String id) async {
    print("id_medicamento " + id);
    try{
      calendarPageCards.clear();
      Database database = await openDatabase(
          Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
        "DELETE FROM Medicamento WHERE id_medicamento = " + id,
      );
      final List<Map<String, dynamic>> rMedicamentos = await database.rawQuery(
        "DELETE FROM Recordatorio WHERE id_medicamento = " + id,
      );

      homePageCards.clear();
      calendarPageCards.clear();
      recordsPageCards.clear();
      update = true;
      delete = false;
      return 6;
    }catch(exception){
      print(exception);
      return 7;
    }
  }

  //Selecciona el medicamento con el id que recibe para su actualización.
  //Aún no funciona.
  Future<void> EditMedicament(String id, BuildContext context) async {
    print("id_medicamento " + id);
    try{
      calendarPageCards.clear();
      Database database = await openDatabase(
          Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> medicamento = await database.rawQuery(
        "SELECT * FROM Medicamento WHERE id_medicamento = " + id,
      );

      if(medicamento.length > 0){
        currentMedicament = Medicament(id_medicamento: int.parse(medicamento[0]['id_medicamento'].toString()),
            nombre: medicamento[0]['nombre'].toString(),
            dosis: medicamento[0]['dosis'].toString(),
            inicioToma: medicamento[0]['inicioToma'].toString(),
            frecuenciaTipo: medicamento[0]['frecuenciaTipo'].toString(),
            frecuenciaToma: int.parse(medicamento[0]['frecuenciaToma'].toString())
        );
      }

      homePageCards.clear();
      calendarPageCards.clear();
      recordsPageCards.clear();
      update = true;
      delete = false;
    }catch(exception){
      print(exception);
    }
  }

  bool update = false;
  bool delete = false;
  int deleteResult = 0;

  void CheckMedicament(){
     print('tick');
     if(currentMedicament.id_medicamento != null){
        update = false;
        print('Editando medicaneto');
        Navigator.pushAndRemoveUntil <dynamic>(
          context,
          MaterialPageRoute <dynamic>(
              builder: (BuildContext context) => MedicamentNameRegister(initMedicament: currentMedicament,)
          ),
              (route) => false,
        );
     }else{
       setState(() {});
     }
  }
}
Medicament currentMedicament = Medicament();
List<Widget> recordsPageCards = [];
