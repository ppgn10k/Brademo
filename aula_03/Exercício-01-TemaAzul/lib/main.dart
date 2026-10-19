import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

/// Exercício 1:
/// Define um ThemeData no MaterialApp com cor de background azul.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 1 - Tema azul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Cor de background padrão de todos os Scaffold do app.
        scaffoldBackgroundColor: Colors.blue.shade200,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercício 1')),
      body: const Center(child: ThemedBox()),
    );
  }
}

/// Widget que lê a cor de background diretamente do tema atual
/// (Theme.of(context)), em vez de ter a cor "fixa" no código.
class ThemedBox extends StatelessWidget {
  const ThemedBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      height: 140,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border.all(color: theme.colorScheme.primary, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Widget com o tema do app',
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}
