import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 4 - Form',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _telefoneCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  Future<void> _escolherData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked == null || !mounted) return;
    final d = picked.day.toString().padLeft(2, '0');
    final m = picked.month.toString().padLeft(2, '0');
    setState(() => _dobCtrl.text = '$d/$m/${picked.year}');
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(
            'Nome: ${_nomeCtrl.text}\n'
            'Telefone: ${_telefoneCtrl.text}\n'
            'Dob: ${_dobCtrl.text}',
          ),
        ),
      );
    }
  }

  // Linha = ícone + campo (mescla Row dentro de Column)
  Widget _linha(IconData icone, Widget campo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icone, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(child: campo),
        ],
      ),
    );
  }

  String? _obrigatorio(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _linha(
                Icons.person,
                TextFormField(
                  controller: _nomeCtrl,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator: _obrigatorio,
                ),
              ),
              _linha(
                Icons.phone,
                TextFormField(
                  controller: _telefoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Phone'),
                  validator: _obrigatorio,
                ),
              ),
              _linha(
                Icons.calendar_today,
                TextFormField(
                  controller: _dobCtrl,
                  readOnly: true,
                  onTap: _escolherData,
                  decoration: const InputDecoration(hintText: 'Dob'),
                  validator: _obrigatorio,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _enviar, child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
