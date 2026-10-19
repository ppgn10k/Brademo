/// Armazena usuário e senha digitados e sabe validar as credenciais.
class Login {
  final String _user;
  final String _password;

  const Login({required String user, required String password})
      : _user = user,
        _password = password;

  String get user => _user;
  String get password => _password;

  // Credenciais válidas definidas no enunciado.
  static const String _validUser = 'admin';
  static const String _validPassword = '1234';

  bool get isValid => _user == _validUser && _password == _validPassword;
}
