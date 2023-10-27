import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MedicamentDateRegister extends StatefulWidget {
  const MedicamentDateRegister({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicamentDateRegister();
  }
}

class _MedicamentDateRegister extends State <MedicamentDateRegister> {
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
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => StartPage()
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

      body: Column(
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
                        builder: (BuildContext context) => StartPage()
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
    );
  }
}
