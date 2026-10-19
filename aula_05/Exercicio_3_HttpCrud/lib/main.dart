import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ===================== MODELO =====================
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromMap(Map<String, dynamic> m) =>
      Post(userId: m['userId'], id: m['id'], title: m['title'], body: m['body']);

  Map<String, dynamic> toMap() =>
      {'userId': userId, 'id': id, 'title': title, 'body': body};
}

// ===================== SERVIÇO HTTP =====================
class PostService {
  static const _host = 'jsonplaceholder.typicode.com';
  static const _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  void _check(http.Response r, List<int> ok) {
    if (!ok.contains(r.statusCode)) {
      throw Exception('Servidor respondeu ${r.statusCode}');
    }
  }

  // GET (lista)
  Future<List<Post>> getPosts() async {
    final r = await http.get(Uri.https(_host, 'posts'), headers: _headers);
    _check(r, [200]);
    return (jsonDecode(r.body) as List).map((e) => Post.fromMap(e)).toList();
  }

  // GET (um item)
  Future<Post> getPost(int id) async {
    final r = await http.get(Uri.https(_host, 'posts/$id'), headers: _headers);
    _check(r, [200]);
    return Post.fromMap(jsonDecode(r.body));
  }

  // POST
  Future<Post> createPost(Post p) async {
    final r = await http.post(Uri.https(_host, 'posts'),
        headers: _headers, body: jsonEncode(p.toMap()));
    _check(r, [201]);
    return Post.fromMap(jsonDecode(r.body));
  }

  // PUT
  Future<Post> updatePost(Post p) async {
    final r = await http.put(Uri.https(_host, 'posts/${p.id}'),
        headers: _headers, body: jsonEncode(p.toMap()));
    _check(r, [200]);
    return Post.fromMap(jsonDecode(r.body));
  }

  // DELETE
  Future<void> deletePost(int id) async {
    final r = await http.delete(Uri.https(_host, 'posts/$id'), headers: _headers);
    _check(r, [200]);
  }
}

// ===================== INTERFACE =====================
void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = PostService();
  List<Post> _posts = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load(); // requisição feita uma única vez, nunca dentro do build()
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final posts = await _service.getPosts();
      if (!mounted) return;
      setState(() => _posts = posts);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _msg(String t) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));

  // Diálogo de formulário (criar/editar). Retorna [titulo, corpo] ou null.
  Future<List<String>?> _form({Post? post}) {
    final t = TextEditingController(text: post?.title);
    final b = TextEditingController(text: post?.body);
    return showDialog<List<String>>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(post == null ? 'Novo post (POST)' : 'Editar post #${post.id} (PUT)'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: t, decoration: const InputDecoration(labelText: 'Título')),
          TextField(controller: b, maxLines: 3, decoration: const InputDecoration(labelText: 'Corpo')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(context, [t.text, b.text]),
              child: const Text('Salvar')),
        ],
      ),
    );
  }

  Future<void> _create() async {
    final r = await _form();
    if (r == null) return;
    try {
      final novo = await _service.createPost(
          Post(userId: 1, id: 0, title: r[0], body: r[1]));
      setState(() => _posts.insert(0, novo)); // a API não persiste: atualizamos localmente
      _msg('Criado com id ${novo.id}');
    } catch (e) {
      _msg('Erro ao criar: $e');
    }
  }

  Future<void> _edit(Post p) async {
    final r = await _form(post: p);
    if (r == null) return;
    try {
      final atualizado = await _service.updatePost(
          Post(userId: p.userId, id: p.id, title: r[0], body: r[1]));
      setState(() => _posts[_posts.indexWhere((x) => x.id == p.id)] = atualizado);
      _msg('Post #${p.id} atualizado');
    } catch (e) {
      _msg('Erro ao atualizar: $e');
    }
  }

  Future<void> _delete(Post p) async {
    try {
      await _service.deletePost(p.id);
      setState(() => _posts.removeWhere((x) => x.id == p.id));
      _msg('Post #${p.id} removido');
    } catch (e) {
      _msg('Erro ao remover: $e');
    }
  }

  Future<void> _searchById() async {
    final c = TextEditingController();
    final id = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Buscar por ID (GET)'),
        content: TextField(
            controller: c,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'ID (1 a 100)')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(context, int.tryParse(c.text)),
              child: const Text('Buscar')),
        ],
      ),
    );
    if (id == null) return;
    try {
      final p = await _service.getPost(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('#${p.id} - ${p.title}'),
          content: Text(p.body),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
        ),
      );
    } catch (e) {
      _msg('Erro ao buscar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(child: Text('Erro: $_error'));
    } else {
      body = ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (_, i) {
          final p = _posts[i];
          return ListTile(
            leading: CircleAvatar(child: Text('${p.id}')),
            title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(p.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => _edit(p)),
              IconButton(icon: const Icon(Icons.delete), onPressed: () => _delete(p)),
            ]),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder - CRUD'),
        actions: [
          IconButton(icon: const Icon(Icons.search), tooltip: 'GET por ID', onPressed: _searchById),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'GET lista', onPressed: _load),
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton(onPressed: _create, child: const Icon(Icons.add)),
    );
  }
}
