import 'package:app_medicamentos/models/appointment_model.dart';
import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/utils/msgcall.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/pages/appointment_register/appointments.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class Button extends StatelessWidget {
  final int color;
  //final double ancho, alto;
  final String contenido;
  final int ruta;
  const Button({required this.color, required this.contenido, required this.ruta, super.key});

  @override
  Widget build(BuildContext context) {
    //int direction = 1;
    double ancho = AppStyles.anchoBoton, alto = AppStyles.altoBoton;

    /*
    if(currentMedicament.id_medicamento != null){
      ancho = 100;
      alto = 50;
    }
    */

    return Container(
      width: ancho,
      height: alto,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(color),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          fixedSize: Size(ancho, alto),
        ),
        //263, 71
      onPressed: () async {
        if(ruta == 0){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: MedicamentNameRegister(initMedicament: Medicament(),),
            ),
                (route) => false,
          );
        }
        else if (ruta == 1){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: AppointmentsPage(initAppointment: Appointment(),),
            ),
                (route) => false,
          );
        }
        else if (ruta == 2){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.topToBottom,
              child: const HomePage(),
            ),
                (route) => false,
          );
        }else if (ruta == 3){
          delete = false;
          update = false;
          deleting = false;
          currentMedicament = Medicament();
          currentAppointment = Appointment();
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.topToBottom,
              child: const RecordsPage(),
            ),
                (route) => false,
          );
        }else if (ruta == 4){
          delete = false;
          update = false;
          deleting = false;

          Database database = await openDatabase(
              Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

          print("Eliminando medicamento id: " + currentMedicament.id_medicamento.toString());

          final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
            "DELETE FROM Medicamento WHERE id_medicamento = " + currentMedicament.id_medicamento.toString(),
          );
          final List<Map<String, dynamic>> rMedicamentos = await database.rawQuery(
            "DELETE FROM Recordatorio WHERE id_medicamento = " + currentMedicament.id_medicamento.toString(),
          );

          currentMedicament = Medicament();

          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.topToBottom,
              child: const RecordsPage(),
            ),
                (route) => false,
          );
        }else if (ruta == 5){
          delete = false;
          update = false;
          deleting = false;

          Database database = await openDatabase(
              Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

          print("Eliminando cita id: " + currentAppointment.id_cita.toString());

          final List<Map<String, dynamic>> citas = await database.rawQuery(
            "DELETE FROM Cita WHERE id_cita = " + currentAppointment.id_cita.toString(),
          );
          final List<Map<String, dynamic>> rCitas = await database.rawQuery(
            "DELETE FROM Recordatorio WHERE id_cita = " + currentAppointment.id_cita.toString(),
          );

          currentAppointment = Appointment();

          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            PageTransition(
              type: PageTransitionType.topToBottom,
              child: const RecordsPage(),
            ),
                (route) => false,
          );
        }

          //Navegacion para agregar cita medica
          else if (ruta == 1){
            Navigator.pushAndRemoveUntil <dynamic>(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: AppointmentsPage(
                  initAppointment: Appointment(),
                ),
              ),
                  (route) => false,
            );
          }

          //Navegacion para regresar al HomePage
          else if (ruta == 2){
            Navigator.pushAndRemoveUntil <dynamic>(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: const HomePage(),
              ),
                  (route) => false,
            );
          }

          //Navgacion para regresar a la pagina de registros
          else if (ruta == 3){
            Navigator.pushAndRemoveUntil <dynamic>(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: const RecordsPage(),
              ),
                  (route) => false,
            );
          }

        },
        child: Text(contenido,
          style: AppStyles.textoBoton
        ),
      ),
    );
  }

}