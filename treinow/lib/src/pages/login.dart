import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treinow/src/pages/atualiza.dart';
import 'package:treinow/src/pages/cadastro.dart';
import 'package:treinow/src/pages/sistema.dart';
import 'package:treinow/src/pages/userHelper.dart';

import '../models/models_user.dart';
import 'home_page.dart';

class telaLogin extends StatefulWidget {
  const telaLogin({Key? key}) : super(key: key);

  @override
  State<telaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final Map<String, String> _formData = {};

  // PersistenciaArquivoJson paj = PersistenciaArquivoJson();
  userHelper banco = userHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barraSuperior(),
      body: corpo(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Login"),
    );
  }

  corpo() {
    return Column(
      children: [cardFormulario(), listaUsers()],
    );
  }

  cardFormulario() {
    return Card(
      margin: EdgeInsets.all(15),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              campoDados(_usuarioController, "Usuário",
                  "Informe o nome de usuário", Icons.person_add, false),
              campoDados(_senhaController, "Senha", "Informe uma senha",
                  Icons.lock_rounded, true),
              botaoLogin(),
              botaoRegistro(),
            ],
          )),
    );
  }

  campoDados(TextEditingController controller, String label, String hint,
      IconData icone, bool isSenha) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        style: TextStyle(color: Colors.green[900]),
        controller: controller,
        obscureText: isSenha,
        decoration: InputDecoration(
          icon: Icon(
            icone,
            color: Colors.grey,
          ),
          hintText: hint,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
        ),
        validator: (String? value) {
          return (value == null || value.isEmpty) ? 'Campo obrigatório' : null;
        },
      ),
    );
  }

  botaoLogin() {
    return Container(
      padding: const EdgeInsets.only(),
      child: ElevatedButton.icon(
        icon: Icon(Icons.login_rounded),
        label: Text(
          "Login",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            sistema.userLogado = await userHelper()
                .login(_usuarioController.text, _senhaController.text);
            if (sistema.userLogado.id == 0) {
            } else {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const pagInicial()));
            }
          }
        },
      ),
    );
  }

  botaoRegistro() {
    return Container(
      padding: const EdgeInsets.only(),
      child: ElevatedButton.icon(
        icon: Icon(Icons.app_registration_rounded),
        label: Text(
          "Registra-se",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const telaCadastrado()));
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

  montarListaUsers(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return itemDaLista(users[index], index);
      },
    );
  }

  itemDaLista(User users, int indice) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        users.nome,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: Wrap(spacing: 12, children: <Widget>[
        IconButton(
          icon: const Icon(Icons.restore_from_trash, color: Colors.red),
          onPressed: () {
            setState(() {
              // paj.removerCidadao(indice);
              print(indice);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.red),
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => editaUser(
                            user: users,
                            index: indice,
                          )));
            });
          },
        ),
      ]),
    );
  }

  Future<List<User>> carregarListaUsers() async {
    List<User> lista = [];

    await Future.delayed(const Duration(seconds: 3));

    // lista = await paj.lerCidadaos();

    // lista = await banco.consultarTodos();

    return lista;
  }
}
