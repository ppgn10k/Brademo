/// Atividade 3: Classe Laptop Básica

class Laptop {
  int id;
  String nome;
  int ram; // em GB
  double clockCpu; // em GHz

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  void exibirDetalhes() {
    print("ID: $id | Nome: $nome | RAM: ${ram}GB | CPU: ${clockCpu}GHz");
  }
}

void main() {
  var laptop1 = Laptop(1, "Dell Inspiron", 8, 2.4);
  var laptop2 = Laptop(2, "Lenovo ThinkPad", 16, 3.2);
  var laptop3 = Laptop(3, "MacBook Pro", 32, 3.5);

  laptop1.exibirDetalhes();
  laptop2.exibirDetalhes();
  laptop3.exibirDetalhes();
}