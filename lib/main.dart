import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BasicCalculator(),
  ));
}

class BasicCalculator extends StatefulWidget {
  @override
  _BasicCalculatorState createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {

  String equation = "0";
  String result = " ";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  String answer = "";

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        answer = result;
        equation = "0";
        result = " ";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.VECTOR, cm)}';
          answer = result;
        }catch(e){
          result = "Error";
        }

      }

      else if(buttonText == "Ans"){
        equation = answer;

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }



  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    SafeArea(
      top: true,
    );
    return Container(
      color: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
                side: BorderSide(
                    color: Colors.black,
                    width: 5,
                    style: BorderStyle.solid
                )
            ),
            padding: EdgeInsets.all(10.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black
              ),
            )
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          SizedBox(height: 20),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.grey),),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .60,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.white),
                          buildButton("8", 1, Colors.white),
                          buildButton("9", 1, Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.white),
                          buildButton("5", 1, Colors.white),
                          buildButton("6", 1, Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.white),
                          buildButton("2", 1, Colors.white),
                          buildButton("3", 1, Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                         buildButton("0", 1, Colors.white),
                          buildButton(".", 1, Colors.white),
                          buildButton("00", 1, Colors.white),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("⌫", 1, Colors.blue[500]),
                          buildButton("C", 1, Colors.blue[500]),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.white),
                          buildButton("÷", 1, Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.white),
                          buildButton("-", 1, Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("Ans", 1, Colors.white),
                          buildButton("=", 1, Colors.white),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}

