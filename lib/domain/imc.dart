import 'dart:convert' as convert;

class IMC {
  int? id;
  String nome;
  double peso;
  double altura;
  double imc;
  String status;

  IMC({
    this.id,
    required this.nome,
    required this.peso,
    required this.altura,
    required this.imc,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'peso': peso,
      'altura': altura,
      'imc': imc,
      'status': status,
    };
  }

  static IMC fromMap(Map<String, dynamic> map) {
    return IMC(
      id: map['id'],
      nome: map['nome'],
      peso: map['peso'],
      altura: map['altura'],
      imc: map['imc'],
      status: map['status'],
    );
  }

  @override
  String toString() {
    return 'IMC(id: $id, nome: $nome, peso: $peso, altura: $altura, imc: $imc, status: $status)';
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
