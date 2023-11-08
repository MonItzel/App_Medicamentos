import 'package:app_medicamentos/database/conection.dart';
import 'package:app_medicamentos/models/user_model.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';


class Pathologies extends StatefulWidget {
  const Pathologies({super.key, required User this.user});

  final User user;


  @override
  State<StatefulWidget> createState() {
    return _Pathologies();
  }
}

class _Pathologies extends State <Pathologies> {
  var patologia;

  @override
  Widget build(BuildContext context) {
    List patologias = ['Diabetes Mellitus', 'Hipertensión arterial sistemática', 'Demencia o Alzheimer', 'Artritis', 'Osteoporosis', 'Cardiopatias', 'Parkinson', 'Depresión'];
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
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 29
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => Address(user: widget.user,)
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

      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 150),
        child: Form(
          //key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //padding: const EdgeInsets.all(20),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Padding(padding: EdgeInsets.only(top: 50)),

                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Patologías",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                Column(

                  children: [
                    DropDownTextField.multiSelection(


                      //controller: _cntMulti.dropDownValueList,
                      //Propiedades botón
                      submitButtonColor: Colors.indigoAccent,
                      submitButtonText: 'Aceptar',
                      submitButtonTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),



                      dropdownColor: Colors.white,

                      dropdownRadius: 0,
                      //displayCompleteItem: true, //Muestra los campos seleccionados
                      //initialValue: const ["name1", "name2", "name8", "name3"],
                      dropDownItemCount: 10, //La cantidad que te muestra al inicio, lo demás con el scroll
                      dropDownList: const [
                        DropDownValueModel(name: 'Artritis', value: "Artritis", /*toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values"*/),
                        DropDownValueModel(name: 'Artritis/Osteoartrosis', value: "Osteoartrosis"),
                        DropDownValueModel(name: 'Cardiopatías', value: "Cardiopatías"),
                        DropDownValueModel(name: 'Demencia o Alzheimer', value: "Demencia o Alzheimer"),
                        DropDownValueModel(name: 'Depresión', value: "Depresión"),
                        DropDownValueModel(name: 'Diabetes Mellitus', value: "Diabetes Mellitus"),
                        DropDownValueModel(name: 'Hipertensión arterial sistemática', value: "Hipertensión arterial sistemática", /* Muestra un dialog* toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values"*/),
                        DropDownValueModel(name: 'Osteoporosis', value: "Osteoporosis"),
                        DropDownValueModel(name: 'Parkinson', value: "Parkinson"),
                        /*
                        DropDownValueModel(name: 'name10', value: "value10"),
                        DropDownValueModel(name: 'name11', value: "value11"),

                        */
                      ],
                      onChanged: (val) {
                        setState(() {

                          for(int i=0; i<val.length; i++) {
                            print(val[i].name);
                          }

                        });
                      },
                    ),
                  ],

                ),
                const SizedBox(height: 180,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Container(
                    width: 193,
                    height: 77,
                    child: ElevatedButton(
                      onPressed: () {
                        register();
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
                ),

              ],


            ),


          ),
        ),

      ),
    );
  }

  void register() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    await database.transaction((txn) async {

      String sql=
          'CREATE TABLE Usuario (id_usuario INTEGER PRIMARY KEY, '
          'nombre TEXT, '
          'apellidoP TEXT,  '
          'apellidoM TEXT,  '
          'fechaNac REAL,  '
          'telefono TEXT, '
          'calle TEXT, '
          'club TEXT, '
          'numero_exterior TEXT, '
          'cuidador_activo INTEGER, '
          'cuidador_nombre TEXT, '
          'cuidador_telefono TEXT); ';
      txn.rawQuery(sql);

       sql=
          'CREATE TABLE Padecimiento (id_padecimiento INTEGER PRIMARY KEY, '
          'nombre_padecimiento TEXT); ';
      txn.rawQuery(sql);

      sql =  'CREATE TABLE Medicamento (id_medicamento INTEGER PRIMARY KEY, '
          'nombre TEXT, '
          'descripcion TEXT,  '
          'dosis TEXT,  '
          'inicioToma REAL,  '
          'finToma REAL, '
          'frecuenciaToma INTEGER); ';
      txn.rawQuery(sql);

      sql = 'CREATE TABLE Cita (id_cita INTEGER PRIMARY KEY, '
          'nombre_medico TEXT, '
          'especialidad_medico TEXT,  '
          'ubicacion TEXT,  '
          'telefono_medico TEXT,  '
          'fecha REAL); ';
      txn.rawQuery(sql);

      sql = 'CREATE TABLE Recordatorio (id_recordatorio INTEGER PRIMARY KEY, '
          'tipo TEXT, '
          'id_medicamento INTEGER,  '
          'id_cita);  ';
      txn.rawQuery(sql);

      sql = 'SELECT * FROM Usuario';
      txn.rawQuery(sql);

      var usuario = {
        'nombre': widget.user.nombre,
        'apellidoP': widget.user.apellidoP,
        'apellidoM': widget.user.apellidoM,
        'fechaNac': widget.user.fechaNac.toString(),
        'calle': widget.user.calle,
        'club': widget.user.club,
        'numero_exterior': widget.user.numExterior,
        'cuidador_activo': 0
      };

      var id1 = txn.insert('Usuario', usuario);

      var padecimiento = {
        'nombre_padecimiento': patologia,
      };

      var id2 = txn.insert('Padecimiento', padecimiento);

      print(id2.toString());
    });
  }
}



