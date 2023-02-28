import 'package:path_provider/path_provider.dart';


class UserPropriedades {
  static String id = "id";
  static String nome = "nome";
  static String senha = "senha";
  static String email = "email";
  static String cpf = "cpf";
  static String cep = "cep";
  static String endereco = "endereco";
  static String bairro = "bairro";
  static String num_casa = "numero";
}

class User {
  int id = 0;
  String nome = " ";
  String senha = " ";
  String email= " ";
  String cpf = " ";
  String cep = " ";
  String endereco = " ";
  String bairro = " ";
  int num_casa = 0;

   User() {
   }

  User.fromMap(Map map) {
    id = map[UserPropriedades.id] ?? 0;
    nome = map[UserPropriedades.nome];
    senha = map[UserPropriedades.senha];
    email = map[UserPropriedades.email];
    cpf = map[UserPropriedades.cpf];
    cep = map[UserPropriedades.cep];
    endereco = map[UserPropriedades.endereco];
    bairro = map[UserPropriedades.bairro];
    num_casa = map[UserPropriedades.num_casa];
  }

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      UserPropriedades.nome: nome,
      UserPropriedades.senha: senha,
      UserPropriedades.cpf: cpf,
      UserPropriedades.email: email,
      UserPropriedades.cep: cep,
      UserPropriedades.endereco: endereco,
      UserPropriedades.bairro: bairro,
      UserPropriedades.num_casa: num_casa,
    };

    if(id > 0){
      map[UserPropriedades.id] = id;
    }
    return map;
  }
}