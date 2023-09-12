import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartPage();
  }
}

class _StartPage extends State <StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF2FA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(55, 0, 55, 100),
            child: Container(
              child: Image(
                image: AssetImage('assets/images/logo_apesaam.png'),
              ),
            ),
          ),

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
                          builder: (BuildContext context) => NameRegister()
                      ),
                      (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0063C9),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
                child: Text("Registrarse",
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