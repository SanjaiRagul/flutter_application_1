import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgeCalculatorScreenState createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? selectedDate;
  String age = '';

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _calculateAge();
      });
    }
  }

  void _calculateAge() {
    final today = DateTime.now();
    final birthDate = selectedDate!;
    int years = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      years--;
    }
    setState(() {
      age = '$years years old';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Age Calculator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectedDate == null
                ? "Select your Date of Birth"
                : "DOB: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _pickDate, child: Text("Pick Date")),
            SizedBox(height: 20),
            Text(age, style: TextStyle(fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
