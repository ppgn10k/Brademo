import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 6 - Tarefas',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const TarefasPage(),
    );
  }
}

class Tarefa {
  final String titulo;
  bool concluida;
  Tarefa(this.titulo, {this.concluida = false});
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final List<Tarefa> _tarefas = List.generate(
    5,
    (i) => Tarefa('Task ${DateTime.now().add(Duration(seconds: i))}'),
  );
  bool _verConcluidas = false;

  void _mostrarAviso() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso'),
        content: const Text('Você está no App de Notas de Tarefas'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visiveis = _tarefas.where((t) => t.concluida == _verConcluidas).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: ElevatedButton(
              onPressed: () => setState(() => _verConcluidas = !_verConcluidas),
              child: Text(_verConcluidas ? 'View Uncompleted Tasks' : 'View Completed Tasks'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              _verConcluidas
                  ? 'You have ${visiveis.length} completed tasks'
                  : 'You have ${visiveis.length} uncompleted tasks',
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: visiveis.length,
              itemBuilder: (context, index) {
                final tarefa = visiveis[index];
                return Card(
                  color: Colors.amber.shade300,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(tarefa.titulo, style: const TextStyle(fontSize: 13)),
                    trailing: Checkbox(
                      value: tarefa.concluida,
                      onChanged: (valor) =>
                          setState(() => tarefa.concluida = valor ?? false),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAviso,
        child: const Icon(Icons.add),
      ),
    );
  }
}
