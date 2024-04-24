import 'package:app_medicamentos/pages/appointment_register/appointments.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:app_medicamentos/utils/flashMessage.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/utils/buttonSheet.dart';
import '../../models/reminder_model.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:page_transition/page_transition.dart';

class MedicamentDateRegister extends StatefulWidget {
  const MedicamentDateRegister({super.key, required this.medicament});

  final Medicament medicament;

  @override
  State<StatefulWidget> createState() {
    return _MedicamentDateRegister();
  }
}

class _MedicamentDateRegister extends State <MedicamentDateRegister> {
  var medicamentDate;
  late bool _validateF = false;


  @override
  Widget build(BuildContext context) {
    String buttonText = 'Siguiente';
    DateTime initialDate = DateTime.now();
    if(widget.medicament.id_medicamento != null && timeinput.text == ''){
      buttonText = 'Guardar';
      print(widget.medicament.inicioToma.toString());
      initialDate = DateTime(int.parse(widget.medicament.inicioToma.toString().split('-')[0]), int.parse(widget.medicament.inicioToma.toString().split('-')[1]), int.parse(widget.medicament.inicioToma.toString().split('-')[2].split(' ')[0]));
      medicamentDate = initialDate;
      print(initialDate.toString());
      timeinput.text = widget.medicament.inicioToma.toString().split(' ')[1].split(':')[0] + ':' + widget.medicament.inicioToma.toString().split(' ')[1].split(':')[1];
    }else{
      initialDate = DateTime.now();
      medicamentDate = initialDate;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            'Agregar medicamento',
            style: AppStyles.encabezado1
          ),

          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: MedicamentNameRegister(initMedicament: widget.medicament,)
                ),
                    (route) => false,
              );
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
                    'Fecha de inicio de toma',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Selecciona la fecha en que iniciará a tomar su medicamento',
                    style: AppStyles.texto3,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SfDateRangePicker(
                    initialDisplayDate: initialDate,
                    initialSelectedDate: initialDate,
                    selectionMode: DateRangePickerSelectionMode.single,
                    showNavigationArrow: true,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      medicamentDate = args.value;
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
                    'Hora de inicio de toma',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Selecciona la hora en que iniciará a tomar su medicamento',
                    style: AppStyles.texto3,
                  ),
                ),
              ),

              TextField(
                controller: timeinput, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText: "Hora" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay? pickedTime =  await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if(pickedTime != null ){
                    print(pickedTime.format(context));   //output 10:51 PM

                    String time = pickedTime.toString().split("(")[1];
                    time = time.split(")")[0];
                    setState(() {
                      timeinput.text = time; //set the value of text field.
                      _validateF = true;
                    });
                  }else{
                    print("Time is not selected");
                    _validateF = false;
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
                        if (_validateF == false) {
                          muestraSnackBar(context, 2);
                          return;
                        }

                        if(widget.medicament.id_medicamento != null){
                          //Si el user ya tiene un id, actualiza la información del usuario
                          update(context);
                        }else{
                          //Al presionar le botón intenta insertar el medicamento y recordatorios.
                          int result = await RegisterMedicament();
                          muestraButtonSheet(context, result);
                        }

                      },
                      style: AppStyles.botonPrincipal,
                      child: Text(buttonText,
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

  //Completa la información del medicamento y lo inserta en la base de datos.
  Future<int> RegisterMedicament() async {
    try {
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      //Si el objeto tiene un id intentará actualizar el medicamento con la información nueva.
      if(widget.medicament.id_medicamento != null){
        return 5;
      }else{
        //Si el objeto no tiene un id, intentará insertar el medicamento y sus recordatorios.
        widget.medicament.inicioToma =
            medicamentDate.toString().split(" ")[0] + " " + timeinput.text + ":00";

        print(widget.medicament.inicioToma);

        await database.transaction((txn) async {
          var medicamento = widget.medicament.toMap();

          var id1 = txn.insert('Medicamento', medicamento);
        });

        final List<Map<String, dynamic>> map1 = await database.rawQuery(
          'SELECT * FROM Medicamento',
        );

        for (int i = 0; i < map1.length; i++) {
          print(map1[i]["id_medicamento"].toString() + " - " +
              map1[i]["nombre"].toString());
        }

        //Selecciona el id del medicamento registrado y generará los recordatorios con el modelo completo.
        final List<Map<String, dynamic>> maxID = await database.rawQuery(
          'SELECT MAX(id_medicamento) AS MaxID FROM Medicamento',
        );

        print(maxID[0]['MaxID'].toString());

        widget.medicament.id_medicamento = int.parse(maxID[0]['MaxID'].toString());
        Reminder reminder = Reminder(
            tipo: "M",
            id_medicamento: widget.medicament.id_medicamento,
            fecha_hora: widget.medicament.inicioToma);
        reminder.InsertReminder();
        reminder.CreateMedicamentReminders(widget.medicament);

        homePageCards.clear();
        recordsPageCards.clear();
        calendarPageCards.clear();

        reminder.SetAlarms();

        //Si el medicamento fue insertado retorna 1.
        return 1;
      }
      } catch (e) {
        print("Error en RegisterAppointment: $e");

        //Si fallo al insertar o actualizar el medicamento retorna 2.
        return 2;
    }
  }

  void update(BuildContext context) async{
    try{
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      widget.medicament.inicioToma =
          medicamentDate.toString().split(" ")[0] + " " + timeinput.text + ":00";

      await database.transaction((txn) async {
        var medicamento = widget.medicament.toMap();

        //var id1 = txn.update('Medicamento', medicamento);
        String query = 'UPDATE Medicamento SET '
            'nombre = \'' + widget.medicament.nombre.toString() +
            '\', dosis = \'' + widget.medicament.dosis.toString() +
            '\', inicioToma = \'' + widget.medicament.inicioToma.toString() +
            '\', frecuenciaTipo = \'' + widget.medicament.frecuenciaTipo.toString() +
            '\', frecuenciaToma = \'' + widget.medicament.frecuenciaToma.toString() +
            '\' WHERE id_medicamento = ' + widget.medicament.id_medicamento.toString();
        var id1 = txn.rawQuery(query);

        print(query);
      });

      print('maxID');
      final List<Map<String, dynamic>> maxID = await database.rawQuery(
        'DELETE FROM Recordatorio WHERE id_medicamento = ' + widget.medicament.id_medicamento.toString(),
      );


      Reminder reminder = Reminder(
          tipo: "M",
          id_medicamento: widget.medicament.id_medicamento,
          fecha_hora: widget.medicament.inicioToma);
      reminder.InsertReminder();
      reminder.CreateMedicamentReminders(widget.medicament);

      currentMedicament = Medicament();
      homePageCards.clear();
      calendarPageCards.clear();
      recordsPageCards.clear();

      reminder.SetAlarms();

      //Si el medicamento fue actualizado retorna 5.
      muestraButtonSheet(context, 5);
    }catch(ex){
      currentMedicament = Medicament();
      muestraButtonSheet(context, 12);
    }
  }

  TextEditingController timeinput = new TextEditingController();
}
