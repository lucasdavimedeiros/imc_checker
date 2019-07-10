import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _info = "Info";

  void _clearFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe os dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double imc = weight / (height * height);

      if (imc < 18.5) {
        _info = "Abaixo do peso (IMC = ${imc.toStringAsFixed(2)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _info = "Peso normal (IMC = ${imc.toStringAsFixed(2)})";
      } else if (imc >= 25 && imc <= 29.9) {
        _info = "Acima do peso (IMC = ${imc.toStringAsFixed(2)})";
      } else if (imc >= 30 && imc <= 34.9) {
        _info = "Obesidade grau 1 (IMC = ${imc.toStringAsFixed(2)})";
      } else if (imc >= 35 && imc <= 39.9) {
        _info = "Obesidade grau 2 (IMC = ${imc.toStringAsFixed(2)})";
      } else if (imc >= 40) {
        _info = "Obesidade grau 3 (IMC = ${imc.toStringAsFixed(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC Checker"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _clearFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, color: Colors.green, size: 130),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (KG)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 24),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso (KG)";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (M)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 24),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura (M)";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              )),
        ));
  }
}
