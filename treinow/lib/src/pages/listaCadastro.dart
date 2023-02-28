import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treinow/src/pages/home_page.dart';
import 'package:treinow/src/pages/userHelper.dart';

import '../models/models_user.dart';

class listaCadastros extends StatefulWidget {
  const listaCadastros({Key? key}) : super(key: key);

  @override
  State<listaCadastros> createState() => _listaCadastrosState();
}

class _listaCadastrosState extends State<listaCadastros> {

  // PersistenciaArquivoJson paj = PersistenciaArquivoJson();
  List<User> lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barraSuperior(),
      body: corpo(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Cidadãos Cadastrados"),
    );
  }

  corpo() {
    return Column(
      children: [listaUsers(), botaoRetorna()],
    );
  }
   botaoRetorna() {
    return Container(
      padding: const EdgeInsets.only(),
      child: ElevatedButton.icon(
        icon: Icon(Icons.login_rounded),
        label: Text(
          "Página Inicial",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: ()  {
          
          Navigator.pop(context);
          Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const pagInicial()));
        },
      ),
    );
  }

  listaUsers() {
    return Expanded(
        child: Card(
      margin: const EdgeInsets.all(15),
      child: FutureBuilder<List<User>>(
          future: carregarListaUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return montarListaUsers(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }

  montarListaUsers(List<User> Users) {
    return ListView.builder(
      itemCount: Users.length,
      itemBuilder: (context, index) {
        return itemDaLista(Users[index], index);
      },
    );
  }

  itemDaLista(User User, int indice) {
    return ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          User.nome,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Wrap(children: <Widget>[
          IconButton(
            icon: const Icon(Icons.restore_from_trash, color: Colors.red),
            onPressed: () {
              setState(() {
                userHelper().remover(lista[indice].id);
                print(indice);
              });
            },
          ),
        ]));
  }

  Future<List<User>> carregarListaUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    lista = await userHelper().consultarTodos();
    return lista;
  }
}