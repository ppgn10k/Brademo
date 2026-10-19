import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const linguagens = ['Dart', 'JavaScript', 'PHP', 'C++', 'Python', 'Java', 'Kotlin', 'Swift'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 2 - Responsividade',
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery informa a orientação da tela (retrato/paisagem)
    final paisagem = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layouts', style: TextStyle(fontSize: 14)),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: paisagem
            // PAISAGEM: cabeçalho à esquerda, lista à direita
            ? Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: SingleChildScrollView(child: Cabecalho(vertical: true)),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  const Expanded(child: ListaLinguagens()),
                ],
              )
            // RETRATO: cabeçalho em cima, lista embaixo
            : const Column(
                children: [
                  Cabecalho(vertical: false),
                  Expanded(child: ListaLinguagens()),
                ],
              ),
      ),
    );
  }
}

class Cabecalho extends StatelessWidget {
  final bool vertical; // true => botões empilhados (paisagem)
  const Cabecalho({super.key, required this.vertical});

  Widget _botao(BuildContext context, String texto) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(),
        minimumSize: const Size(120, 36),
      ),
      onPressed: () => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$texto pressionado'))),
      child: Text(texto, style: const TextStyle(fontSize: 11)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final botoes = [_botao(context, 'BUTTON 1'), _botao(context, 'BUTTON 2')];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cheetah Coding', style: TextStyle(fontSize: 26)),
          const SizedBox(height: 16),
          vertical
              ? Column(children: [botoes[0], const SizedBox(height: 16), botoes[1]])
              : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: botoes),
        ],
      ),
    );
  }
}

class ListaLinguagens extends StatelessWidget {
  const ListaLinguagens({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: linguagens.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) => SizedBox(
        height: 56,
        child: Center(child: Text(linguagens[index], style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}
