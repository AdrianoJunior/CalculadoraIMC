import 'package:calculadora_imc/domain/pessoa.dart';
import 'package:calculadora_imc/utils/simple_bloc.dart';

class IMCBloc {
  Future<String> calcularIMC(Pessoa pessoa) async {
    double imc = pessoa.peso / (pessoa.altura * pessoa.altura);
    String imcStatus;

    switch (imc) {
      case < 16:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza grave.";
        break;
      case >= 16 && < 17:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza moderada.";
        break;
      case >= 17 && < 18.5:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica magreza leve.";
        break;
      case >= 18.5 && < 25:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica que você está saudável.";
        break;
      case >= 25 && < 30:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica sobrepeso.";
        break;
      case >= 30 && < 35:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau I.";
        break;
      case >= 35 && < 40:
        // add(true);
        imcStatus = "${pessoa.nome} seu IMC é de ${imc.toStringAsFixed(2)}, o que indica obesidade grau II (severa).";
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
