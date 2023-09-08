import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conection{
  Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'medicamentos.db')
    );
  }
}