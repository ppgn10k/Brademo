/// Atividade 4: Named Constructors na Classe Laptop

class Laptop {
  int id;
  String nome;
  int ram;
  double clockCpu;

  // Construtor padrão
  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  // Named Constructor: Navegação Web (4GB RAM, 1.6 GHz)
  Laptop.navegacao(this.id, this.nome)
      : ram = 4,
        clockCpu = 1.6;

  // Named Constructor: Escritório (8GB RAM, 2.2 GHz)
  Laptop.escritorio(this.id, this.nome)
      : ram = 8,
        clockCpu = 2.2;

  // Named Constructor: Programação (16GB RAM, 3.2 GHz)
  Laptop.programacao(this.id, this.nome)
      : ram = 16,
        clockCpu = 3.2;

  void exibirDetalhes() {
    print("ID: $id | Nome: $nome | RAM: ${ram}GB | CPU: ${clockCpu}GHz");
  }
}

void main() {
  var lapWeb = Laptop.navegacao(101, "Chromebook");
  var lapOffice = Laptop.escritorio(102, "Dell Vostro");
  var lapDev = Laptop.programacao(103, "Asus ROG");

  lapWeb.exibirDetalhes();
  lapOffice.exibirDetalhes();
  lapDev.exibirDetalhes();
}