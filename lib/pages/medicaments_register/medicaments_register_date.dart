import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/utils/buttonSheet.dart';


import '../../models/reminder_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Agregar medicamento',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => MedicamentNameRegister()
                ),
                    (route) => false,
              );
            },
          ),
          actions: const [],
          backgroundColor: const Color(0xFFEDF2FA),
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                medicamentDate = args.value;
              },
              todayHighlightColor: Color(0xFF09184D),
              selectionColor: Color(0xFF09184D),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                width: 193,
                height: 77,
                child: ElevatedButton(
                  onPressed: () async {
                    int result = await RegisterMedicament();
                    muestraButtonSheet(context, result);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0063C9),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  child: Text("Siguiente",
                    style: TextStyle(
                        fontSize: 26
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<int> RegisterMedicament() async {
    try {
      widget.medicament.inicioToma =
          medicamentDate.toString().split(" ")[0] + " 12:00:00";

      Database database = await openDatabase(
          join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

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

      final List<Map<String, dynamic>> maxID = await database.rawQuery(
        'SELECT MAX(id_medicamento) AS MaxID FROM Medicamento',
      );

      print(maxID[0]['MaxID'].toString());

      widget.medicament.id_medicamento =
          int.parse(maxID[0]['MaxID'].toString());
      Reminder reminder = Reminder(tipo: "M",
          id_medicamento: widget.medicament.id_medicamento,
          fecha_hora: widget.medicament.inicioToma);
      reminder.InsertReminder();
      reminder.CreateMedicamentReminders(widget.medicament);

      homePageCards.clear();
      recordsPageCards.clear();
      calendarPageCards.clear();
      return 1;
    } catch (e) {
      print("Error en RegisterAppointment: $e");
      return 2;
    }
  }
}
