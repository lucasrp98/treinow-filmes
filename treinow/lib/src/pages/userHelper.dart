import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/models_user.dart';

class userHelper {
  static final userHelper _instance = userHelper._interno();

  factory userHelper() => _instance;

  userHelper._interno();

  Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) {
      return _banco!;
    } else {
      _banco = await iniciarBanco();
      return _banco!;
    }
  }

  String tabelaUser = "user";

  Future<Database> iniciarBanco() async {
    final caminhoDoBanco = await getDatabasesPath();

    final caminho = join(caminhoDoBanco, "users.db");

    const versao = 3;

    String sqlCriarBanco = "CREATE TABLE $tabelaUser("
        "${UserPropriedades.id} INTEGER PRIMARY KEY ,"
        "${UserPropriedades.nome} TEXT,"
        "${UserPropriedades.senha} TEXT,"
        "${UserPropriedades.email} TEXT,"
        "${UserPropriedades.cpf} TEXT,"
        "${UserPropriedades.cep} TEXT,"
        "${UserPropriedades.endereco} TEXT,"
        "${UserPropriedades.bairro} TEXT,"
        "${UserPropriedades.num_casa} INTEGER"
        ")";

    String destruirBanco = "DROP TABLE $tabelaUser";

    return openDatabase(
      caminho,
      version: versao,
      onCreate: (banco, versaoNova) async {
        print("Criando banco com versao $versaoNova");
        await banco.execute(sqlCriarBanco);
      },
      onUpgrade: (banco, versaoAntiga, versaoNova) async {
        print("Atualizando banco da versão $versaoAntiga" "para a $versaoNova");
        await banco.execute(destruirBanco);
        await banco.execute(sqlCriarBanco);
      },
    );
  }

  Future<User> salvar(User user) async {
    Database bancoUser = await banco;
    user.id = await bancoUser.insert(tabelaUser, user.toMap());
    return user;
  }

  Future<User> consultar(int id) async {
    Database bancoUser = await banco;
    List<Map> retorno = await bancoUser.query(tabelaUser,
        columns: [
          UserPropriedades.id,
          UserPropriedades.nome,
          UserPropriedades.senha,
          UserPropriedades.email,
          UserPropriedades.cpf,
          UserPropriedades.endereco,
          UserPropriedades.bairro,
          UserPropriedades.num_casa,
        ],
        where: "${UserPropriedades.id} = ?",
        whereArgs: [id]);

    if (retorno.isNotEmpty) {
      return User.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  Future<List<User>> consultarTodos() async {
    Database bancoUser = await banco;
    List<Map> retorno = await bancoUser.rawQuery("SELECT * FROM $tabelaUser");
    List<User> users = [];
    for (Map user in retorno) {
      users.add(User.fromMap(user));
    }
    return users;
  }

  Future<int> atualizar(User user) async {
    Database bancoUser = await banco;
    return await bancoUser.update(tabelaUser, user.toMap(),
        where: "${UserPropriedades.id} = ?", whereArgs: [user.id]);
  }

  Future<int> remover(int id) async {
    Database bancoUser = await banco;
    return await bancoUser.delete(tabelaUser,
        where: "${UserPropriedades.id} = ?", whereArgs: [id]);
  }

  Future<int?> quantidade() async {
    Database bancoUser = await banco;
    return Sqflite.firstIntValue(
        await bancoUser.rawQuery("SELECT COUNT (*) FROM $tabelaUser"));
  }

  Future<User> login(String nome, String senha) async {
    Database bancoUser = await banco;
    List<Map> retorno = await bancoUser.query(tabelaUser,
        where: "${UserPropriedades.nome} = ?"
            " AND "
            "${UserPropriedades.senha} = ?",
        whereArgs: [nome, senha]);
    if (retorno.isNotEmpty) {
      return User.fromMap(retorno.first);
    } else {
      return User();
    }
  }
}
