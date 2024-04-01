import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:app_medicamentos/constants.dart';

import '../models/user_model.dart';

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
      backgroundColor: AppStyles.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(55, 20, 55, 100),
            child: Container(
              child: Image(
                image: AssetImage('assets/images/logo_apesaam.png'),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 80, 16, 20),
              child: Container(
                width: double.infinity,
                height: AppStyles.altoBoton,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil <dynamic>(
                      context,
                      MaterialPageRoute <dynamic>(
                          builder: (BuildContext context) => NameRegister(user: new User(),)
                      ),
                          (route) => false,
                    );
                  },
                  style: AppStyles.botonPrincipal,
                  child: Text("Comenzar",
                    style: AppStyles.textoBoton,
                  ),
                ),
              )
            ),
          ),

        ],
      ),
    );
  }
}