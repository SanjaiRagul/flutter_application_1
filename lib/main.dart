import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'age_calculator_screen.dart';
import 'currency_converter_screen.dart';

void main() => runApp(MyUtilityApp());

class MyUtilityApp extends StatefulWidget {
  const MyUtilityApp({super.key});

  @override
  State<MyUtilityApp> createState() => _MyUtilityAppState();
}

class _MyUtilityAppState extends State<MyUtilityApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CalculatorScreen(),
    AgeCalculatorScreen(),
    CurrencyConverterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Utility App',
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
            BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Age'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Currency'),
          ],
        ),
      ),
    );
  }
}


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', 'ANS', '='
  ];

  void handleButtonClick(String button) {
    setState(() {
      if (button == 'C') {
        userInput = '';
        result = '0';
      } else if (button == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (button == '=') {
        try {
          // ignore: deprecated_member_use
          Parser p = Parser();
          Expression exp = p.parse(userInput.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = 'Error';
        }
      } else if (button == 'ANS') {
        userInput += result;
      } else {
        userInput += button;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(userInput, style: TextStyle(fontSize: 32, color: Colors.white)),
                  SizedBox(height: 10),
                  Text(result, style: TextStyle(fontSize: 48, color: Colors.greenAccent)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                final button = buttons[index];
                return CalculatorButton(
                  text: button,
                  onTap: () => handleButtonClick(button),
                  color: _getButtonColor(button),
                  textColor: _getTextColor(button),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == '=' || button == '+' || button == '-' || button == '*' || button == '/' || button == '%') {
      return Colors.orange;
    } else if (button == 'C' || button == 'DEL') {
      return Colors.red;
    }
    return Colors.grey[850]!;
  }

  Color _getTextColor(String button) {
    if (button == '=' || button == '+' || button == '-' || button == '*' || button == '/' || button == '%') {
      return Colors.white;
    } else if (button == 'C' || button == 'DEL') {
      return Colors.white;
    }
    return Colors.white;
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  const CalculatorButton({super.key, 
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
