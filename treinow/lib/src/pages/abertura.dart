import 'package:flutter/material.dart';

import 'login.dart';


class telaAbertura extends StatefulWidget {
  const telaAbertura({Key? key}) : super(key: key);

  @override
  State<telaAbertura> createState() => _telaAberturaState();
}

class _telaAberturaState extends State<telaAbertura> {
  @override
  Widget build(BuildContext context) {
    trocaTela();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Treinow"),
      ),
      body: Column(
        children: [
          const Center(
            heightFactor: 13,
            child: Text(
              "Bem-Vindo ao Treinow Filmes",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void trocaTela() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const telaLogin()));
    });
  }
}
