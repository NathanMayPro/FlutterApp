import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/service/local_database_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataseServices {
  static final LocalDataseServices instance = LocalDataseServices._init();

  static Database? _database;

  static const String dbName = "newsCopy.db";

  LocalDataseServices._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen == true) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<String> get databasePath async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, dbName);
  }

  Future<Database> _initDB() async {
    String path = await LocalDataseServices.instance.databasePath;
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""
        CREATE 
          TABLE Save 
            (id INTEGER PRIMARY KEY, 
            domain TEXT,
            author TEXT,
            title TEXT, 
            description TEXT,
            content TEXT,
            url TEXT,
            image BLOB,
            publishedAt TEXT);
        """);
  }

  Future<void> create(ArticleLocal article) async {
    Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO Save(domain, author, title, description, content, url, image, publishedAt) VALUES(?,?,?,?,?,?,?,?)",
          [
            article.domain,
            article.author,
            article.title,
            article.description,
            article.content,
            article.url,
            article.image,
            article.publishedAt
          ]);
    });
  }

  Future<List<Article>> readAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> listRecords =
        await db.rawQuery("SELECT * FROM Save");
    return listRecords.map((e) => ArticleLocal.fromMap(e).toEntitie()).toList();
  }

  Future delete(String url) async {
    Database db = await instance.database;
    await db.rawDelete("DELETE FROM Save WHERE url = ? ", [url]);
  }

  Future<bool> checkIfSave(String url) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> listOfResult = await db
        .rawQuery('SELECT COUNT(id) as length FROM Save Where url = ?', [url]);
    if (listOfResult[0]["length"] != 0) return true;
    return false;
  }
}
