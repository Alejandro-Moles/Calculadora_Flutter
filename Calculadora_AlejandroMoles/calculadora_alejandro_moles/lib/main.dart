import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Calculadora());
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double resultado = 0;
  String pantalla = "0";
  String pantallaOperacion = "";
  int oprRes = 0;

  PresionarBoton(String textoBoton) {
    setState(() {
      switch (textoBoton) {
        //hago un switch para las diferentes opciones al pulsar una tecla
        //esta opcion lo borra todo de la pantalla
        case "AC":
          pantallaOperacion = "";
          pantalla = "0";
          break;

        //esta opcion calcula los resultados de la operacion
        case "=":
          Parser p = new Parser();
          ContextModel cm = new ContextModel();
          try {
            pantallaOperacion = pantallaOperacion.replaceAll('x', '*');

            Expression expresion = p.parse(pantallaOperacion);
            setState(() {
              pantalla = expresion.evaluate(EvaluationType.REAL, cm).toString();
            });
            oprRes = 1;
          } catch (e) {
            pantalla = "ERROR";
            pantallaOperacion = "";
          }
          break;

        //esta opcion borra solo un dijito de la operacion
        case "⌫":
          if (pantalla == "" || pantalla == "ERROR") {
            if (pantallaOperacion == "") {
            } else {
              pantallaOperacion =
                  pantallaOperacion.substring(0, pantallaOperacion.length - 1);
            }
          } else {
            pantalla = pantalla.substring(0, pantalla.length - 1);
          }
          break;

        //esta opcion prepara la operacion de multiplicar
        case "x":
          if (ComprobarCondicion(pantalla)) {
            pantalla = "ERROR";
            pantallaOperacion = "";
          } else {
            pantalla = "x";
            pantallaOperacion = pantallaOperacion + "x";
          }
          break;

        //esta opcion prepara la operacion de dividir
        case "/":
          if (ComprobarCondicion(pantalla)) {
            pantalla = "ERROR";
            pantallaOperacion = "";
          } else {
            pantalla = "/";
            pantallaOperacion = pantallaOperacion + "/";
          }
          break;

        //esta opcion prepara la operacion de restar
        case "-":
          if (ComprobarCondicion(pantalla)) {
            pantalla = "ERROR";
            pantallaOperacion = "";
          } else {
            pantalla = "-";
            pantallaOperacion = pantallaOperacion + "-";
          }
          break;

        //esta opcion prepara la operacion de sumar
        case "+":
          if (ComprobarCondicion(pantalla)) {
            pantalla = "ERROR";
            pantallaOperacion = "";
          } else {
            pantalla = "+";
            pantallaOperacion = pantallaOperacion + "+";
          }
          break;

        //esta es la opcion que salta al pulsar una tecla normal
        default:
          if (ComprobarCondicion(pantalla)) {
            pantalla = "";
          }
          if (oprRes == 1) {
            pantalla = "";
            pantallaOperacion = "";
          }
          pantallaOperacion = pantallaOperacion + textoBoton;
          pantalla = pantalla + textoBoton;
          oprRes = 0;
          break;
      }
    });
  }

  //funcion que comprueba si despues de haber pulsado una tecla de operacion, se pulsa otra de operacion y en ese caso mostrar error
  bool ComprobarCondicion(String textoPantalla) {
    if (textoPantalla == "ERROR" ||
        textoPantalla == "x" ||
        textoPantalla == "/" ||
        textoPantalla == "-" ||
        textoPantalla == "+") {
      return true;
    } else {
      return false;
    }
  }

  //metodo que crea los botones con los valores que se le han pasado y hace que el onpresed tenga la funcion que maneja la logica del programa
  Widget calcularBotones(
    String textBoton,
    Color colorTexto,
    Color colorBoton,
  ) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          PresionarBoton(textBoton);
        },
        child: Text(
          textBoton,
          style: TextStyle(fontSize: 35, color: colorTexto),
        ),
        shape: StadiumBorder(),
        color: colorBoton,
        padding: EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Calculadora Decimal'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //esta fila contendra la "caja" en la que ira la operacion en si
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    pantallaOperacion,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Row(
              //esta fila contendra en resulado de la operacion que se resuelve al pulsar el boton =
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                  child: Text(
                    pantalla,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            //creo una fila la cual sera en la qure iran la fila de lso botones que apareceran primero
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcularBotones('AC', Colors.black, Colors.deepOrange),
                calcularBotones('⌫', Colors.black, Colors.deepOrange),
                calcularBotones('%', Colors.black, Colors.deepOrange),
                calcularBotones('/', Colors.black, Colors.deepOrange),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //esta fila tredra tambien botones pero en estos empezaran a aperecer los numeros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcularBotones('7', Colors.black, Colors.grey.shade700),
                calcularBotones('8', Colors.black, Colors.grey.shade700),
                calcularBotones('9', Colors.black, Colors.grey.shade700),
                calcularBotones('x', Colors.black, Colors.deepOrange),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //esta fila tienen la misma estructura que las anteriores, y es que contendran los metodos que construyen botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcularBotones('4', Colors.black, Colors.grey.shade700),
                calcularBotones('5', Colors.black, Colors.grey.shade700),
                calcularBotones('6', Colors.black, Colors.grey.shade700),
                calcularBotones('-', Colors.black, Colors.deepOrange),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcularBotones('1', Colors.black, Colors.grey.shade700),
                calcularBotones('2', Colors.black, Colors.grey.shade700),
                calcularBotones('3', Colors.black, Colors.grey.shade700),
                calcularBotones('+', Colors.black, Colors.deepOrange),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //esta fila tinen algo diferente, ya que aparte de tener el metodo que contruye los diferentes botones, tambien tiene
            //la creacio de un boton, el cual tiene un tamaño diferente a los demas, y por eso esta contruido aparte.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(23, 10, 133, 10),
                  onPressed: () {
                    PresionarBoton("0");
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  color: Colors.grey.shade700,
                ),
                calcularBotones('.', Colors.black, Colors.grey.shade700),
                calcularBotones('=', Colors.black, Colors.deepOrange),
              ],
            )
          ],
        ),
      ),
    );
  }
}
