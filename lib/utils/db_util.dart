import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DbUtil {
  //antes de inserir os dados preciso definir uma tabela rodando um comando
  // por ser bando de dados, fazendo requisicao é async
  static Future<sql.Database> database() async {
    //pegando o caminho onde vai armazenar os arquivos de bd
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'), //cria um arquivo em dbpath e um nome
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)'); //image é text pq só salva o caminho do arquivo
      }, //onCreate sempre q execturar um db pela primeira vz
      version: 1,
    );
  }

  //leitura de todos os registros da tabela locais
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
