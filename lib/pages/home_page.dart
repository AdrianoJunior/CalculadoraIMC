import 'package:calculadora_imc/database/db_helper.dart';
import 'package:calculadora_imc/domain/imc.dart';
import 'package:calculadora_imc/domain/pessoa.dart';
import 'package:calculadora_imc/pages/imc_bloc.dart';
import 'package:calculadora_imc/widget/app_button.dart';
import 'package:calculadora_imc/widget/app_text.dart';
import 'package:calculadora_imc/widget/text_error.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _tNome = TextEditingController();
  TextEditingController _tPeso = TextEditingController();
  TextEditingController _tAltura = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _focusAltura = FocusNode();
  final _focusPeso = FocusNode();
  final _bloc = IMCBloc();
  final dbHelper = DatabaseHelper();
  Color? c = Colors.grey[200];

  @override
  void initState() {
    super.initState();
    dbHelper.initDb();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                "Nome",
                "Digite seu nome",
                controller: _tNome,
                nextFocus: _focusAltura,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (s) => _validateNome(s),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                "Altura",
                "Digite sua altura em metros",
                controller: _tAltura,
                focusNode: _focusAltura,
                nextFocus: _focusPeso,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (s) => _validateAltura(s),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                "Peso",
                "Digite seu peso em kg",
                controller: _tPeso,
                focusNode: _focusPeso,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (s) => _validatePeso(s),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: AppButton(
                "Calcular",
                onPressed: _calcularIMC,
                width: double.infinity,
              ),
            ),
            StreamBuilder(
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return TextError("Não foi possivel recuperar os dados.");
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<IMC>? _imcs = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _imcs?.length ?? 0,
                      itemBuilder: (context, index) {
                        IMC imc = _imcs![index];

                        _setColor(imc);
                        return Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: c ?? Colors.grey[200],
                          child: ListTile(
                            title: Text(imc.nome),
                            subtitle: Text(
                                "IMC: ${imc.imc.toStringAsFixed(2)}\nStatus: ${imc.status}", style: TextStyle(color: c = Colors.black),),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  _calcularIMC() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String nome = _tNome.text;
    double? peso = double.parse(_tPeso.text.replaceAll(",", "."));
    double? altura = double.parse(_tAltura.text.replaceAll(",", "."));

    Pessoa p = Pessoa(nome: nome, peso: peso, altura: altura);

    _bloc.calcularIMC(p);
  }

  _validateNome(String? s) {
    if (s == null) {
      return "Por favor, digite seu nome";
    } else {
      if (s.isEmpty) {
        return "Por favor, digite seu nome";
      }
      return null;
    }
  }

  _validateAltura(String? s) {
    if (s == null) {
      return "Por favor, digite sua altura";
    } else {
      if (s.isEmpty) {
        return "Por favor, digite sua altura";
      }
      return null;
    }
  }

  _validatePeso(String? s) {
    if (s == null) {
      return "Por favor, digite seu peso";
    } else {
      if (s.isEmpty) {
        return "Por favor, digite seu peso";
      }
      return null;
    }
  }

  void _setColor(IMC imc) {
    switch (imc.imc) {
      case < 16:
        c = Colors.red;
        break;
      case >= 16 && < 17:
        c = Colors.orange;
        break;
      case >= 17 && < 18.5:
        c = Colors.yellow;
        break;
      case >= 18.5 && < 25:
        c = Colors.green;
        break;
      case >= 25 && < 30:
        c = Colors.yellow;
        break;
      case >= 30 && < 35:
        c = Colors.orange;
        break;
      case >= 35 && < 40:
        c = Colors.orange[700];
        break;
      case >= 40:
        c = Colors.red;
        break;
      default:
        c = Colors.grey[200];
        break;
    }
  }
}
