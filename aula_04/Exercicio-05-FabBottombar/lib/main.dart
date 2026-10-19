import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 5 - BottomAppBar + FAB',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;
  bool _aberto = false; // FAB expandido?

  void _mensagem(String texto) {
    setState(() => _aberto = false);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Widget _itemBarra(int index, IconData icone, String rotulo) {
    final cor = _tab == index ? Colors.blue : Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _tab = index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: cor),
            Text(rotulo, style: TextStyle(fontSize: 11, color: cor)),
          ],
        ),
      ),
    );
  }

  Widget _miniFab(IconData icone, String texto) {
    return IgnorePointer(
      ignoring: !_aberto,
      child: AnimatedScale(
        scale: _aberto ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            onPressed: () => _mensagem(texto),
            child: Icon(icone),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomAppBar with FAB'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Center(child: Text('TAB: $_tab', style: const TextStyle(fontSize: 32))),
          // Opções que aparecem ao tocar no FAB
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _miniFab(Icons.chat, 'Mensagem'),
                  _miniFab(Icons.email, 'E-mail'),
                  _miniFab(Icons.phone, 'Ligação'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => setState(() => _aberto = !_aberto),
        child: AnimatedRotation(
          turns: _aberto ? 0.125 : 0, // gira o "+" para virar "x"
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _itemBarra(0, Icons.menu, 'This'),
              _itemBarra(1, Icons.layers, 'Is'),
              // espaço reservado para o FAB no centro
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('A', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ),
                ),
              ),
              _itemBarra(2, Icons.dashboard, 'Bottom'),
              _itemBarra(3, Icons.info, 'Bar'),
            ],
          ),
        ),
      ),
    );
  }
}
