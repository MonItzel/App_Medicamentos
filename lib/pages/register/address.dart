import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/birth_date_register.dart';
import 'package:app_medicamentos/pages/register/pathologies.dart';

import '../../models/user_model.dart';

class Address extends StatefulWidget {
  const Address({super.key, required User this.user});

  final User user;


  @override
  State<StatefulWidget> createState() {
    return _Address();
  }
}

class _Address extends State <Address> {
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
                    builder: (BuildContext context) => BirthDateRegister(user: widget.user)
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Domicilio',
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
            controller: calleController,
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
              hintText: 'Calle',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            controller: coloniaController,
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
              hintText: 'Colonia',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            controller: numExteriorController,
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
              hintText: 'Número exterior',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 180,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  SetUser();
                  Navigator.pushAndRemoveUntil <dynamic>(
                    context,
                    MaterialPageRoute <dynamic>(
                        builder: (BuildContext context) => Pathologies(user: widget.user,)
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

  void SetUser(){
    widget.user.calle = calleController.text;
    widget.user.club = coloniaController.text;
    widget.user.numExterior = numExteriorController.text;
  }
}

TextEditingController calleController = TextEditingController();
TextEditingController coloniaController = TextEditingController();
TextEditingController numExteriorController = TextEditingController();