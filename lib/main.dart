import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    _controllerPeso.text = "";
    _controllerAltura.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(_controllerPeso.text);
      double altura = double.parse(_controllerAltura.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.5) {
        _infoText = "Abaixo do peso! IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoText = "Peso normal! IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25 && imc <= 29.9) {
        _infoText = "Sobrepeso! IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30 && imc <= 34.9) {
        _infoText = "Obesidade grau 1! IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 35 && imc <= 39.9) {
        _infoText = "Obesidade grau 2! IMC = ${imc.toStringAsPrecision(3)}";
      } else {
        _infoText = "Obesidade grau 3! IMC = ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  CircleAvatar(
                    child: Icon(Icons.person, size: 50),
                    radius: 50,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _controllerPeso,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerAltura,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Altura!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                      if(_formkey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
