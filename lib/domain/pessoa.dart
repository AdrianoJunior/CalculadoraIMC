import 'dart:convert' as convert;

class Pessoa {
  String nome;
  double peso;
  double altura;

  Pessoa({required this.nome, required this.peso, required this.altura});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'peso': peso,
      'altura': altura,
    };
  }

  static Pessoa fromMap(Map<String, dynamic> pessoa) {
    return Pessoa(
      nome: pessoa['nome'],
      peso: pessoa['peso'],
      altura: pessoa['altura'],
    );
  }

  @override
  String toString() {
    return 'Pessoa(nome: $nome, peso: $peso, altura: $altura)';
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
