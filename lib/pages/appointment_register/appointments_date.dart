import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentsDatePage extends StatefulWidget {
  const AppointmentsDatePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppointmentsDatePage();
  }
}

class _AppointmentsDatePage extends State <AppointmentsDatePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Agendar cita',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => HomePage()
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

              },
              todayHighlightColor: Color(0xFF09184D),
              selectionColor: Color(0xFF09184D),
            ),
            SizedBox(height: 20.0,),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                width: 193,
                height: 77,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => HomePage()
                      ),
                          (route) => false,
                    );
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
}