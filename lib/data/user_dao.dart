import 'package:sqflite/sqflite.dart';
import 'package:sciencenotes/domain/users.dart';
import 'package:sciencenotes/data/DBhelper.dart';


class UserDao {

  Future<void> saveUser({required Users user}) async {
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();

    await db.insert('users', user.toJson());
  }

  Future<bool> authenticate({required String username, required String password}) async {
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();

    String sql = 'SELECT * '
                 'FROM users '
                 'WHERE username = ? AND password = ?;';

    final result = await db.rawQuery(sql, [username, password]);

    return result.isNotEmpty;
  }

  Future<bool> exclusivityUser({required String username}) async {
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();

    String sql = 'SELECT * '
                 'FROM users '
                 'WHERE username = ?;';
    final resposta = await db.rawQuery(sql,[username]);
    return resposta.isNotEmpty;
  }

  Future<bool> exclusivityEmail({required String email}) async {
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();

    String sql = 'SELECT * '
                 'FROM users '
                 'WHERE email = ?;';
    final resposta = await db.rawQuery(sql,[email]);
    return resposta.isNotEmpty;
  }

  listUsers() async {
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();

    String sql = 'SELECT * FROM users;';
    final result = await db.rawQuery(sql);

    List<Users> lista = <Users>[];
    for(var json in result){
      Users usuario = Users.fromJson(json);
      lista.add(usuario);
    }

    return lista;
  }

   Future<int> listIDs() async{
    int id=0;
    Helper dbHelper = Helper();
    Database db = await dbHelper.initDB();
    String sql = 'SELECT * FROM users WHERE id = (SELECT MAX(id) FROM users);';
    final result = await db.rawQuery(sql);

    for(var json in result){
      Users usuario = Users.fromJson(json);
      id = usuario.id;
    }
    return id;
  }

}