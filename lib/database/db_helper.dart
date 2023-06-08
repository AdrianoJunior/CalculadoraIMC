import 'package:calculadora_imc/domain/imc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'imc_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE resultados_imc (id INTEGER PRIMARY KEY, nome TEXT, peso REAL, altura REAL, imc REAL, status TEXT)',
    );
  }

  Future<int> saveResultadoIMC(IMC imc) async {
    final dbClient = await db;
    return await dbClient!.insert('resultados_imc', imc.toMap());
  }

  Future<List<IMC>> getResultadosIMC() async {
    final dbClient = await db;
    final list = await dbClient!.query('resultados_imc');
    return list.map((json) => IMC.fromMap(json)).toList();
  }
}
