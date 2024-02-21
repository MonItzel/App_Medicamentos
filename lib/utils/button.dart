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

class Button extends StatelessWidget {
  final int color;
  //final double ancho, alto;
  final String contenido;
  final int ruta;
  const Button({required this.color, required this.contenido, required this.ruta, super.key});

  @override
  Widget build(BuildContext context) {
    //int direction = 1;
    return Container(
      width: AppStyles.anchoBoton,
      height: AppStyles.altoBoton,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(color),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
        ),
        onPressed: (){
          //Navegacion para agregar medicamento
          if(ruta == 0){
            Navigator.pushAndRemoveUntil <dynamic>(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: MedicamentNameRegister(
                  initMedicament: Medicament(),
                ),
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
                type: PageTransitionType.fade,
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
                type: PageTransitionType.fade,
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