import 'package:app_medicamentos/pages/records/records.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/appointment_register/appointments_date.dart';
import 'package:app_medicamentos/models/appointment_model.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_medicamentos/constants.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key, required this.initAppointment});

  final Appointment initAppointment;

  @override
  State<StatefulWidget> createState() {
    return _AppointmentsPage();
  }
}

class _AppointmentsPage extends State <AppointmentsPage> {
  // Definición del formateador de máscara para el número de teléfono
  var maskFormatter = MaskTextInputFormatter(mask: '### ### ####', filter: {"#": RegExp(r'[0-9]')});

  // Objeto que se usará para pasar la información de la cita a la próxima pantalla.
  Appointment appointment = Appointment();

  @override
  Widget build(BuildContext context) {
    if(currentAppointment.id_cita != null)
      appointment = currentAppointment;
    else
      appointment = widget.initAppointment;

    if(appointment.id_cita != null && nombreMedicoController.text == '' && motivoController.text == '' && lugarController.text == ''&& telefonoMedicoController.text == ''){
      nombreMedicoController.text = appointment.nombre_medico.toString();
      motivoController.text = appointment.motivo.toString();
      lugarController.text = appointment.ubicacion.toString();
      telefonoMedicoController.text = appointment.telefono_medico.toString();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            appointment.id_cita != null ? 'Editar cita' : 'Registrar cita',
            style: AppStyles.encabezado1,
          ),
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black
            ),
            onPressed: () {
              if(appointment.id_cita != null){
                update = false;
                currentAppointment = Appointment();
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => RecordsPage()
                  ),
                      (route) => false,
                );
              }
              else{
                // Navegar de regreso a la página de inicio
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => HomePage()
                  ),
                      (route) => false,
                );
              }
            },
          ),

          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nombre del médico',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: nombreMedicoController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo,
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertoUpperCase(text, nombreMedicoController, 0);
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Motivo de la cita',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: motivoController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo,
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        // Convertir a mayúsculas el primer carácter de la primera palabra
                        setState(() {
                          convertFirstWordUpperCase(text, motivoController);
                        });
                      },
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Lugar de la cita',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: lugarController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo,
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        // Convertir a mayúsculas el primer carácter de la primera palabra
                        setState(() {
                          convertFirstWordUpperCase(text, lugarController);
                        });
                      },
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Teléfono del médico',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: telefonoMedicoController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatter],
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo,
                      style: AppStyles.texto1,

                    ),
                  ),
                ),
              ),


              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
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
                      style: AppStyles.botonPrincipal,
                      child: const Text(
                        "Siguiente",
                        style: AppStyles.textoBoton,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
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

  // Controladores de texto para los campos de entrada
  TextEditingController nombreMedicoController = TextEditingController();
  TextEditingController motivoController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController telefonoMedicoController = TextEditingController();
}
