import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const EMICalculatorApp());
}

class EMICalculatorApp extends StatelessWidget {
  const EMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMI Calculator',
      home: EMICalculatorPage(),
    );
  }
}

class EMICalculatorPage extends StatefulWidget {
  const EMICalculatorPage({Key? key}) : super(key: key);

  @override
  _EMICalculatorPageState createState() => _EMICalculatorPageState();
}

final ValueNotifier<double> _emiResult = ValueNotifier<double>(0.0);

class _EMICalculatorPageState extends State<EMICalculatorPage> {
  double principalAmount = 0;
  double interestRate = 0;
  int tenureMonths = 0;
  double emi = 0;

  void calculateEMI() {
    double monthlyInterestRate = interestRate / 12 / 100;
    num powFactor = pow(1 + monthlyInterestRate, tenureMonths.toDouble());
    emi = (principalAmount * monthlyInterestRate * powFactor) / (powFactor - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 103, 133),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Color.fromARGB(255, 59, 71, 86),
                  Color.fromARGB(255, 32, 103, 133),
                ]),
          ),
        ),
        elevation: 15,
        title: const Text('EMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    Color.fromARGB(255, 90, 83, 83),
                    Color.fromARGB(255, 26, 95, 125),
                  ],
                ),
              ),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your loan emi is',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    emi.round().toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    'per month',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Color.fromARGB(255, 51, 50, 50),
                      Color.fromARGB(255, 32, 103, 133),
                    ]),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white70, fontSize: 25),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Principal Amount',
                      labelStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        principalAmount = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white70, fontSize: 25),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Interest Rate (%)',
                      labelStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          interestRate = double.tryParse(value) ?? 0;
                        },
                      );
                    },
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white70, fontSize: 25),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Loan Tenure (in months)',
                      labelStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        tenureMonths = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[
                              Color.fromARGB(255, 192, 183, 183),
                              Color.fromARGB(255, 32, 103, 133),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        child: TextButton(
                          child: const Text(
                            'Calculate',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                calculateEMI();
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[
                              Color.fromARGB(255, 192, 183, 183),
                              Color.fromARGB(255, 32, 103, 133),
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _emiResult.value = 0.0;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const EMICalculatorApp()),
                            );
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 90),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Developer name   ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w200,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'aj_labs',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
