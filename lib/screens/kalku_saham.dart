import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/home.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<CalculatorScreen> {
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _lotController = TextEditingController();
  final TextEditingController _buyPriceController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  double _profitLoss = 0.0;
  double _buycount = 0.0;
  double _sellcount = 0.0;
  double _profitLossPercent = 0.0;


  void _calculateProfitLoss() {
    int lot = int.tryParse(_lotController.text) ?? 0;
    double buyPrice = double.tryParse(_buyPriceController.text) ?? 0.0;
    double sellPrice = double.tryParse(_sellPriceController.text) ?? 0.0;
    setState(() {
      _profitLoss = (sellPrice - buyPrice) * lot * 100;
      _buycount = (buyPrice * lot);
      _sellcount = (sellPrice * lot);
    });
  }

  void _calculateProfitLossPercent() {
    int lot = int.tryParse(_lotController.text) ?? 0;
    double buyPrice = double.tryParse(_buyPriceController.text) ?? 0.0;
    double sellPrice = double.tryParse(_sellPriceController.text) ?? 0.0;
    setState(() {
_profitLossPercent = ((sellPrice) / buyPrice) * 100;
    });
  }

  void _resetFields() {
    _stockController.clear();
    _lotController.clear();
    _buyPriceController.clear();
    _sellPriceController.clear();
    setState(() {
      _profitLoss = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 37, 113, 180),
              Color.fromARGB(255, 0, 0, 139)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Profit Calculator',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.teal[700],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                          _stockController, 'Saham', 'Contoh : PGAS'),
                      const SizedBox(height: 10),
                      _buildTextField(_lotController, 'Lot', 'Contoh : 10'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          _buyPriceController, 'Buy Price', 'Contoh : 2010'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          _sellPriceController, 'Sell Price', 'Contoh : 2250'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  color: Colors.grey[300],
                  child: const Text(
                    'Net Amount',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Text(
                              'Buy',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              CurrencyFormat.convertToIdr(_buycount, 2),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Text(
                              'Sell',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              CurrencyFormat.convertToIdr(_sellcount, 2),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  color: Colors.grey[300],
                  child: const Text(
                    'profit/Loss',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [

                            const SizedBox(height: 10),
                            Text(
                                '${CurrencyFormat.convertToIdr(_profitLoss, 2)}  ${_profitLossPercent.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),


                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _resetFields,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child:
                          const Text('Reset', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed: _calculateProfitLoss,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child:
                          const Text('Hasil', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 244, 57, 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child: const Text('back', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$label :',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.teal[600],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
