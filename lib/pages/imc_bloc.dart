import 'package:calculadora_imc/database/db_helper.dart';
import 'package:calculadora_imc/domain/imc.dart';
import 'package:calculadora_imc/domain/pessoa.dart';
import 'package:calculadora_imc/utils/simple_bloc.dart';

class IMCBloc extends SimpleBloc<List<IMC>> {
  List<IMC> _imcs = [];

  void addIMC(IMC imc) {
    _imcs.add(imc);
    _saveIMC(imc); // Salva o IMC no banco de dados (SQLite, Hive, etc.)
    add(_imcs);
    fetch();
  }

  void _saveIMC(IMC imc) async {
    DatabaseHelper db = DatabaseHelper();

    await db.saveResultadoIMC(imc);
  }

  void calcularIMC(Pessoa pessoa) {
    double imc = pessoa.peso / (pessoa.altura * pessoa.altura);

    String imcStatus;

    switch (imc) {
      case < 16:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza grave.";
        break;
      case >= 16 && < 17:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza moderada.";
        break;
      case >= 17 && < 18.5:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza leve.";
        break;
      case >= 18.5 && < 25:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica que você está saudável.";
        break;
      case >= 25 && < 30:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica sobrepeso.";
        break;
      case >= 30 && < 35:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau I.";
        break;
      case >= 35 && < 40:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau II (severa).";
        break;
      case >= 40:
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau III (mórbida).";
        break;
      default:
        imcStatus = "Não foi possível calcular seu IMC.";
        break;
    }

    IMC novoImc = IMC(
      peso: pessoa.peso,
      altura: pessoa.altura,
      nome: pessoa.nome,
      imc: imc,
      status: imcStatus,
    );

    addIMC(novoImc);
  }

  Future<List<IMC>?> fetch() async {
    try {
      final dbHelper = DatabaseHelper();
      final List<IMC> imcs = await dbHelper.getResultadosIMC();
      add(imcs);
      return imcs;
    } catch (e) {
      addError(e);
    }
    return null;
  }

  Future<String> calcular(Pessoa pessoa) async {
    double imc = pessoa.peso / (pessoa.altura * pessoa.altura);
    String imcStatus;

    switch (imc) {
      case < 16:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza grave.";
        break;
      case >= 16 && < 17:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza moderada.";
        break;
      case >= 17 && < 18.5:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza leve.";
        break;
      case >= 18.5 && < 25:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica que você está saudável.";
        break;
      case >= 25 && < 30:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica sobrepeso.";
        break;
      case >= 30 && < 35:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau I.";
        break;
      case >= 35 && < 40:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau II (severa).";
        break;
      case >= 40:
        // add(true);
        imcStatus =
            "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau III (mórbida).";
        break;
      default:
        // add(true);
        imcStatus = "Nã foi possível calcular seu IMC.";
        break;
    }
    return imcStatus;
  }
}
