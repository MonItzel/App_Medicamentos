import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BirthDateRegister extends StatefulWidget {
  const BirthDateRegister({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BirthDateRegister();
  }
}

class _BirthDateRegister extends State <BirthDateRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro de Paciente',
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
                    builder: (BuildContext context) => NameRegister()
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
              print(args.value);
            },
            todayHighlightColor: Color(0xFF09184D),
            selectionColor: Color(0xFF09184D),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fecha de nacimiento',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid

                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Seleccione año de nacimiento',
            ),
          ),
          SizedBox(height: 20.0,),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 180,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil <dynamic>(
                    context,
                    MaterialPageRoute <dynamic>(
                        builder: (BuildContext context) => Address()
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