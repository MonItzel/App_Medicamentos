import 'package:app_medicamentos/database/conection.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Pathologies extends StatefulWidget {
  const Pathologies({super.key, required this.nombre, required this.apellidoP, required this.apellidoM,
                                required this.fechaNac,
                                required this.calle, required this.colonia,  required this.numExterior});

  final nombre;
  final apellidoP;
  final apellidoM;
  final fechaNac;
  final calle;
  final colonia;
  final numExterior;


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
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => Address(nombre: widget.nombre, apellidoP: widget.apellidoP, apellidoM: widget.apellidoM,
                                                                fechaNac: widget.fechaNac)
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
              'Patologías',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: 'Patologías más comunes',
                filled: true,
                fillColor: Colors.white,
              ),
              iconEnabledColor: Color(0xFF09184D),
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              items: patologias.map((name){
                return DropdownMenuItem(
                  child: Text(name),
                  value: name,
                );
              }).toList(),
              onChanged: (value){
                patologia = value;
                print(value);
              },
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
              hintText: 'Otras patologías',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 180,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  register();
                  Navigator.pushAndRemoveUntil <dynamic>(
                    context,
                    MaterialPageRoute <dynamic>(
                        builder: (BuildContext context) => HomePage(nombre: widget.nombre, apellidoP: widget.apellidoP, apellidoM: widget.apellidoM, fechaNac: widget.fechaNac, calle: widget.calle, colonia: widget.colonia, numExterior: widget.numExterior, patologia: patologia,)
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
        'nombre': widget.nombre,
        'apellidoP': widget.apellidoP,
        'apellidoM': widget.apellidoM,
        'fechaNac': widget.fechaNac.toString(),
        'calle': widget.calle,
        'club': widget.colonia,
        'numero_exterior': widget.numExterior,
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



