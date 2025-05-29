import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseFavorite {
  static final DatabaseFavorite instance = DatabaseFavorite._initDB();

  Database? _database;

  DatabaseFavorite._initDB();
  
    // Nombre de la tabla
  final String tableFavorite = 'FAVORITE';
  // G asegurar la inicialización
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Inicializar la base de datos si no está inicializada
    _database = await _initDB();
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite_database.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Crear la tabla FAVORITE
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableFavorite (
        idProducto INTEGER PRIMARY KEY,
        nombre VARCHAR(45) NOT NULL,
        vendedor VARCHAR(45) NOT NULL,
        calificacion INTEGER NOT NULL,
        imagen VARCHAR(45) NOT NULL
      )
    ''');
  }


  Future<void> insertFavorite(Map<String, dynamic> row) async {
    final db = await database; 
    if(!(await isFavoriteExist(row['idProducto']))){
      await db.insert(tableFavorite, row);
    }else{
      return;
    }
    
  }

  Future<bool> isFavoriteExist(int idProducto) async{
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(tableFavorite, where: 'idProducto = ?', whereArgs: [idProducto]);
       return result.isNotEmpty;
    
    
  }

  Future<List<Map<String, dynamic>>> queryAllFavorites() async {
      final db = await instance.database;
      final List<Map<String, dynamic>> result = await db.query(tableFavorite);
      return result;
  
     
  
  }

  Future<bool> deleteFavorite(int idProducto) async {
    final db = await database;
    final int result = await db.delete(tableFavorite, where: 'idProducto = ?', whereArgs: [idProducto]);
    // Si se elmino algun registro, sale que al menos una fila fue afectada
    //Si el resultado no es igual a 0, se elimino un registro
    return result != 0;
  }

  Future<void> deleteDatabse() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite_database.db');
    await deleteDatabase(path);
    _database = null;


  }
 
  
}
