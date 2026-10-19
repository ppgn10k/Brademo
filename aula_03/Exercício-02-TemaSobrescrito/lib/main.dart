import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

/// Exercício 2:
/// Continuação do exercício 1. O MaterialApp mantém o ThemeData azul e,
/// em uma parte da árvore de widgets, um novo Theme sobrescreve o inicial
/// com background amarelo.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 2 - Tema sobrescrito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      appBar: AppBar(title: const Text('Exercício 2')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Usa o tema do MaterialApp (azul).
            const ThemedBox(label: 'Tema do app\n(azul)'),

            // Theme sobrescreve o tema herdado só para esta subárvore.
            // copyWith mantém o restante do tema e troca apenas o que
            // foi informado.
            Theme(
              data: Theme.of(context).copyWith(
                scaffoldBackgroundColor: Colors.yellow.shade300,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.amber,
                ),
              ),
              child: const ThemedBox(label: 'Tema sobrescrito\n(amarelo)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lê as cores do tema mais próximo na árvore (Theme.of(context)).
class ThemedBox extends StatelessWidget {
  const ThemedBox({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 150,
      height: 140,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border.all(color: theme.colorScheme.primary, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}
