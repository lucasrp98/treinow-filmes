import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/models_user.dart';

class PersistenciaArquivoJson2{
  Future<File> _getFile() async {
      final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/politiza.json");
  }

  Future gravarUsers(List<User> users) async {
    List mapUsers = [];
    for (User user in users) {
      mapUsers.add(user.toMap());
    }

    String listaComoString = json.encode(mapUsers);
    final arquivo = await _getFile();

    await arquivo.writeAsString(listaComoString);
  }

  Future <List<User>> lerUsers() async {

    List<User> listaUserNoArquivo = [];

    String listaComoString = " ";
    try{
        final arquivo = await _getFile();
        listaComoString = await arquivo.readAsString();
    } catch (e){
        // ignore: avoid_print
        print("Erro na leitura do arquivo $e");
    }
    List mapUsers = [];
    if (listaComoString.isNotEmpty){
        mapUsers = json.decode(listaComoString);
    }
    
    for (Map userMap in mapUsers){
        listaUserNoArquivo.add(User.fromMap(userMap));
    }
      return listaUserNoArquivo;
  }


    Future removerUser(int indice) async {
    List<User> listaUsers = await lerUsers();

    listaUsers.removeAt(indice);

    await gravarUsers(listaUsers);
  }


    Future editaUser(int indice, User user) async {
      
    List<User> listaUsers = await lerUsers();

    listaUsers [indice] = user;
    
    await gravarUsers(listaUsers);
  }
  
}

