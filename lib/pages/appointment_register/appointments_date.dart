import 'package:app_medicamentos/models/appointment_model.dart';
import 'package:app_medicamentos/models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../calendar/calendar.dart';
import '../records/records.dart';
import 'package:app_medicamentos/utils/buttonSheet.dart';
import 'package:app_medicamentos/constants.dart';


class AppointmentsDatePage extends StatefulWidget {
  const AppointmentsDatePage({super.key, required this.appointment});

  // Objeto que se usa para recibir la información de la cita, agregar datos y registrarla en esta pantalla.
  final Appointment appointment;

  @override
  State<StatefulWidget> createState() {
    return _AppointmentsDatePage();
  }
}

class _AppointmentsDatePage extends State <AppointmentsDatePage> {
  var appointmentDate;

  @override
  Widget build(BuildContext context) {
    String buttonText = 'Agendar cita';
    if(widget.appointment.id_cita != null && timeinput.text == ''){
      buttonText = 'Guardar';
      appointmentDate = DateTime(int.parse(widget.appointment.fecha.toString().split('-')[0]), int.parse(widget.appointment.fecha.toString().split('-')[1]), int.parse(widget.appointment.fecha.toString().split('-')[2].split(' ')[0]));
      timeinput.text = widget.appointment.fecha.toString().split(' ')[1].split(':')[0] + ':' + widget.appointment.fecha.toString().split(' ')[1].split(':')[1];
    }else{
      appointmentDate = DateTime.now();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            buttonText,
            style: AppStyles.encabezado1
          ),
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
            ),
            onPressed: () {
              if(widget.appointment.id_cita != null){
                // Navegar de regreso a la página de inicio
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => RecordsPage()
                  ),
                      (route) => false,
                );
              }else{
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
                    'Fecha de la cita médica',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Selecciona la fecha en que asistiras a tu cita médica',
                    style: AppStyles.texto3,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialSelectedDate: appointmentDate,
                    initialDisplayDate: appointmentDate,
                    showNavigationArrow: true,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      appointmentDate = args.value;
                    },
                    todayHighlightColor: AppStyles.secondaryBlue,
                    selectionColor: AppStyles.primaryBlue,
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Hora de la cita',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Selecciona la hora en la que se llevara a cabo su cita médica',
                    style: AppStyles.texto3,
                  ),
                ),
              ),

              TextField(
                controller: timeinput,
                decoration: InputDecoration(
                    icon: Icon(Icons.timer),
                    labelText: "Hora"
                ),
                readOnly: true,
                onTap: () async {
                  // Mostrar el selector de tiempo
                  TimeOfDay? pickedTime =  await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if(pickedTime != null ){
                    print(pickedTime.format(context));

                    // Formatear y establecer la hora seleccionada
                    String time = pickedTime.toString().split("(")[1];
                    time = time.split(")")[0];
                    setState(() {
                      timeinput.text = time;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),


              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(widget.appointment.id_cita != null){
                          update(context);
                        }else{
                          // Al presionar el botón intentará insertar la cita y mostrará un resultado en un modal de hoja.
                          int result = await RegisterAppointment();
                          muestraButtonSheet(context, result);
                        }
                      },
                      style: AppStyles.botonPrincipal,
                      child: Text(
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

  // Intenta insertar la cita y devuelve un resultado.
  Future<int> RegisterAppointment() async {
    try {
      // Asigna la fecha y hora seleccionadas al objeto de cita
      widget.appointment.fecha  = appointmentDate.toString().split(" ")[0] + " " + timeinput.text + ":00";

      // Abre la base de datos
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      // Se utiliza una transacción para garantizar la consistencia de la base de datos
      await database.transaction((txn) async {
        var cita = widget.appointment.toMap();
        var id1 = txn.insert('Cita', cita);
        print(cita.toString());
      });

      // Selecciona el ID de la cita recién registrada y con el modelo completo registra el recordatorio.
      final List<Map<String, dynamic>> maxID = await database.rawQuery(
        'SELECT MAX(id_cita) AS MaxID FROM Cita',
      );

      // Asigna el ID de la cita y crea el recordatorio
      widget.appointment.id_cita = int.parse(maxID[0]['MaxID'].toString());
      Reminder reminder = Reminder();
      reminder.CreateAppointmentReminders(widget.appointment);

      currentAppointment = Appointment();
      // Limpia las listas de tarjetas en las páginas principales
      homePageCards.clear();
      recordsPageCards.clear();
      calendarPageCards.clear();

      reminder.SetAlarms();

      // Si tiene éxito en los registros, retorna 3.
      return 3;
    } catch (e) {
      print("Error en RegisterAppointment: $e");
      // Si se arroja alguna excepción, retorna 4.
      return 4;
    }
  }

  void update(BuildContext context) async{
    try{
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      widget.appointment.fecha =
          appointmentDate.toString().split(" ")[0] + " " + timeinput.text + ":00";

      await database.transaction((txn) async {

        String query = 'UPDATE Cita SET '
            'nombre_medico = \'' + widget.appointment.nombre_medico.toString() +
            '\', motivo = \'' + widget.appointment.motivo.toString() +
            '\', especialidad_medico = \'' + widget.appointment.especialidad_medico.toString() +
            '\', ubicacion = \'' + widget.appointment.ubicacion.toString() +
            '\', telefono_medico = \'' + widget.appointment.telefono_medico.toString() +
            '\', fecha = \'' + widget.appointment.fecha.toString() +
            '\' WHERE id_cita = ' + widget.appointment.id_cita.toString();
        var id1 = txn.rawQuery(query);

        print(query);
      });

      String s = 'DELETE FROM Recordatorio WHERE id_cita = ' + widget.appointment.id_cita.toString();
      final List<Map<String, dynamic>> maxID = await database.rawQuery(
        'DELETE FROM Recordatorio WHERE id_cita = ' + widget.appointment.id_cita.toString(),
      );

      final List<Map<String, dynamic>> maxID1 = await database.rawQuery(
        'SELECT * FROM Recordatorio WHERE id_cita = ' + widget.appointment.id_cita.toString(),
      );

      Reminder reminder = Reminder(
          tipo: "C",
          id_cita: widget.appointment.id_cita,
          fecha_hora: widget.appointment.fecha);
      reminder.InsertReminder();

      currentAppointment = Appointment();
      homePageCards.clear();
      calendarPageCards.clear();
      recordsPageCards.clear();

      reminder.SetAlarms();

      //Si la cita fue actualizada retorna 10.
      muestraButtonSheet(context, 10);
    }catch(ex){
      currentAppointment = Appointment();
      muestraButtonSheet(context, 11);
    }
  }

  TextEditingController timeinput = new TextEditingController();
}
