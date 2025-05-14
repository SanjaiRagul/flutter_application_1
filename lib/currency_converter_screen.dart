import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  double result = 0.0;

  String fromCurrency = 'USD';
  String toCurrency = 'INR';

  final Map<String, double> rates = {
    'USD': 1.0,
    'INR': 83.2,
    'EUR': 0.92,
    'JPY': 155.7,
  };

  void convert() {
    double amount = double.tryParse(_controller.text) ?? 0.0;
    double fromRate = rates[fromCurrency]!;
    double toRate = rates[toCurrency]!;
    setState(() {
      result = (amount / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currency Converter")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Amount', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildDropdown(fromCurrency, (val) => setState(() => fromCurrency = val))),
                SizedBox(width: 10),
                Icon(Icons.swap_horiz),
                SizedBox(width: 10),
                Expanded(child: _buildDropdown(toCurrency, (val) => setState(() => toCurrency = val))),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: convert, child: Text("Convert")),
            SizedBox(height: 20),
            Text('Result: ${result.toStringAsFixed(2)} $toCurrency', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: rates.keys
          .map((currency) => DropdownMenuItem(value: currency, child: Text(currency)))
          .toList(),
      onChanged: (val) => onChanged(val!),
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}
