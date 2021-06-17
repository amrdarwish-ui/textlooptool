import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:textlooptool/Models/Item.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database _db;

  creatDatabase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), 'tool.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "create table items(id integer primary key autoincrement,number integer,word varchar(50) )");
      },
    );
    return _db;
  }

  Future<int> createItem(Item item) async {
    Database db = await creatDatabase();
    return db.insert('items', item.toMap());
  }

  Future<List> allItems() async {
    Database db = await creatDatabase();
    return db.query('items');
  }

  Future<int> delete(int id) async {
    Database db = await creatDatabase();
    return db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clear() async {
    Database db = await creatDatabase();
    return db.delete('items');
  }
}
