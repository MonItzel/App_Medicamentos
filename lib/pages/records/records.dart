import 'dart:async';

import 'package:app_medicamentos/models/appointment_model.dart';
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

import '../appointment_register/appointments.dart';


class RecordsPage extends StatefulWidget{
  const RecordsPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _RecordsPage();
  }
}

class _RecordsPage extends State <RecordsPage>{
  int _currentIndex = 3;
/*
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), CheckCurrent);
*/

  late Timer _timer;

  _RecordsPage() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      if (mounted) {
        CheckCurrent();
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el temporizador en dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    //scheduleTimeout(300);

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
                  child: CalendarPage(initialDate: DateTime.now(),),
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
                    leading: Icon(
                        Icons.medication_liquid,
                        size: 44,
                    ),
                    title: Text(
                      medicamentos[i]['nombre'].toString(), //Nombre del medicamento
                      style: AppStyles.tituloCard,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dosis: " + medicamentos[i]['dosis'].toString(),
                          style: AppStyles.dosisCard,
                        ),
                        Text(
                          'Cada ' + medicamentos[i]['frecuenciaToma'].toString() + ' ' + medicamentos[i]['frecuenciaTipo'].toString() + 's',
                          style: AppStyles.dosisCard,
                        ),
                        Text(
                          "Inicio de toma: " + medicamentos[i]['inicioToma'].toString().split(" ")[0],
                          style: AppStyles.dosisCard,
                        ), //Fecha de inicio
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                EditMedicament(medicamentos[i]['id_medicamento'].toString());
                              },
                              style: AppStyles.botonPrincipal,
                              child: Icon(
                                Icons.edit,
                                size: 30,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Expanded(
                          child: Container(
                            height: 60,
                            child: ElevatedButton(
                              onPressed:  () async {
                                await DeleteMedicament(medicamentos[i]['id_medicamento'].toString());
                              },
                              style: AppStyles.botonSecundario,
                              child: Icon(
                                Icons.delete,
                                size: 30,
                              ),
                            ),
                          ),
                        ),

                      ],
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
          "SELECT * FROM Cita",
        );

        if(citas.length > 0) {
          for(int i = 0; i < citas.length; i++){
            String date = citas[i]['fecha'].toString();
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
                        leading: Icon(
                            Icons.medical_services,
                            size: 44,
                        ),
                        title: const Text(
                          'Cita Médica',
                          style: AppStyles.tituloCard,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Medico: ' + citas[i]['nombre_medico'].toString(),
                              style: AppStyles.dosisCard,
                            ),
                            Text(
                              'Fecha: ' + citas[i]['fecha'].toString(),
                              style: AppStyles.dosisCard,
                            ),
                            Text(
                              "Ubicacion: " + citas[i]['ubicacion'].toString(),
                              style: AppStyles.dosisCard,
                            ),
                            Text(
                              "Telefono: " + citas[i]['telefono_medico'].toString(),
                              style: AppStyles.dosisCard,
                            ),
                          ],
                        ),
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Expanded(
                            child: Container(
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  EditAppointment(citas[i]['id_cita'].toString());
                                },
                                style: AppStyles.botonPrincipal,
                                child: Icon(
                                  Icons.edit,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),

                          Expanded(
                            child: Container(
                              height: 60,
                              child: ElevatedButton(
                                onPressed:  () async {
                                  await DeleteAppointment(citas[i]['id_cita'].toString());
                                },
                                style: AppStyles.botonSecundario,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ]
              )
            )
            );
          }
        }

        print("citas: " + citas.length.toString());
        print("cards: " + recordsPageCards.length.toString());

        if(recordsPageCards.length != medicamentos.length + citas.length){
          recordsPageCards = [];
        }

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
  Future<void> DeleteAppointment(String id) async {
      print("id_cita " + id);
      try{
        calendarPageCards.clear();
        Database database = await openDatabase(
            Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

        final List<Map<String, dynamic>> cita = await database.rawQuery(
          "SELECT * FROM Cita WHERE id_cita = " + id,
        );

        if(cita.length > 0) {
          currentAppointment = Appointment(
            id_cita: int.parse(cita[0]['id_cita'].toString()),
            nombre_medico: cita[0]['nombre_medico'].toString(),
            especialidad_medico: cita[0]['motivo'].toString(),
            ubicacion: cita[0]['ubicacion'].toString(),
            telefono_medico: cita[0]['telefono_medico'].toString(),
            fecha: cita[0]['fecha'].toString()
          );
        }

        /*
        final List<Map<String, dynamic>> citas = await database.rawQuery(
          "DELETE FROM Cita WHERE id_cita = " + id,
        );
        final List<Map<String, dynamic>> rCitas = await database.rawQuery(
          "DELETE FROM Recordatorio WHERE id_cita = " + id,
        );
        */

        homePageCards.clear();
        calendarPageCards.clear();
        recordsPageCards.clear();
        update = false;
        delete = true;
        deleteResult = 8;
      }catch(exception){
        print(exception);
        deleteResult = 9;
      }
  }

  //Intenta eliminar el medicamento y sus recordatorios con el id que recibe.
  Future<void> DeleteMedicament(String id) async {
    print("id_medicamento " + id);
    try{
      calendarPageCards.clear();
      Database database = await openDatabase(
          Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> medicamento = await database.rawQuery(
        "SELECT * FROM Medicamento WHERE id_medicamento = " + id,
      );

      if(medicamento.length > 0) {
        currentMedicament = Medicament(id_medicamento: int.parse(
            medicamento[0]['id_medicamento'].toString()),
            nombre: medicamento[0]['nombre'].toString(),
            dosis: medicamento[0]['dosis'].toString(),
            inicioToma: medicamento[0]['inicioToma'].toString(),
            frecuenciaTipo: medicamento[0]['frecuenciaTipo'].toString(),
            frecuenciaToma: int.parse(
                medicamento[0]['frecuenciaToma'].toString())
        );
      }

      /*final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
        "DELETE FROM Medicamento WHERE id_medicamento = " + id,
      );
      final List<Map<String, dynamic>> rMedicamentos = await database.rawQuery(
        "DELETE FROM Recordatorio WHERE id_medicamento = " + id,
      );*/

      homePageCards.clear();
      calendarPageCards.clear();
      recordsPageCards.clear();
      update = false;
      delete = true;
      deleteResult = 6;
    }catch(exception){
      print(exception);
      deleteResult = 7;
    }
  }

  //Selecciona el medicamento con el id que recibe para su actualización.
  //Aún no funciona.
  Future<void> EditMedicament(String id) async {
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

  Future<void> EditAppointment(String id) async {
    print("id_cita " + id);
    try{
      calendarPageCards.clear();
      Database database = await openDatabase(
          Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      final List<Map<String, dynamic>> cita = await database.rawQuery(
        "SELECT * FROM Cita WHERE id_cita = " + id,
      );

      if(cita.length > 0) {
        currentAppointment = Appointment(
            id_cita: int.parse(cita[0]['id_cita'].toString()),
            nombre_medico: cita[0]['nombre_medico'].toString(),
            motivo: cita[0]['motivo'].toString(),
            ubicacion: cita[0]['ubicacion'].toString(),
            telefono_medico: cita[0]['telefono_medico'].toString(),
            fecha: cita[0]['fecha'].toString()
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

  void CheckCurrent() {
    try {
      print('tick');
      if (currentMedicament.id_medicamento != null) {
        if (update) {
          print('Editando medicaneto');
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
                builder: (BuildContext context) =>
                    MedicamentNameRegister(initMedicament: currentMedicament,)
            ),
                (route) => false,
          );
        } else if (delete && !deleting) {
          //currentMedicament = Medicament();
          deleting = true;
          muestraButtonSheet(context, deleteResult);
        }
      }

      if (currentAppointment.id_cita != null) {
        if (update) {
          print('Editando medicaneto');
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
              builder: (BuildContext context) =>
                  AppointmentsPage(initAppointment: currentAppointment,),
            ),
                (route) => false,
          );
        } else if (delete && !deleting) {
          //currentAppointment = Appointment();
          deleting = true;
          muestraButtonSheet(context, deleteResult);
        }
      }

      if(!delete && !update){
        setState(() {});
      }
    } catch (ex) {
      if (!delete && !update) {
        setState(() {});
      }
    }
  }
}
Medicament currentMedicament = Medicament();
Appointment currentAppointment = Appointment();
List<Widget> recordsPageCards = [];
bool update = false;
bool delete = false;
bool deleting = false;
int deleteResult = 0;