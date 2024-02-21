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
    double ancho = 263, alto = 71;
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
          fixedSize: Size(ancho, alto),
        ),
        //263, 71
      onPressed: (){
        if(ruta == 0){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
              builder: (BuildContext context) =>MedicamentNameRegister(initMedicament: Medicament(),),
            ),
                (route) => false,
          );
        }
        else if (ruta == 1){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
              builder: (BuildContext context) =>AppointmentsPage(initAppointment: Appointment(),),
            ),
                (route) => false,
          );
        }
        else if (ruta == 2){
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
                builder: (BuildContext context) => HomePage()
            ),
                (route) => false,
          );
        }else if (ruta == 3){
          delete = false;
          update = false;
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
                builder: (BuildContext context) => RecordsPage()
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