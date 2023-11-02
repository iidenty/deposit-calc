import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Депозитный калькулятор'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? totalAmount;
  double? income;

  final _amountTextController = TextEditingController();
  final _termTextController = TextEditingController();
  final _percentTextController = TextEditingController();

  void _calcDeposit() {
    setState(() {
      if (
        _amountTextController.text.isNotEmpty
        && _termTextController.text.isNotEmpty
        && _percentTextController.text.isNotEmpty
      ) {
        
          double depositAmount = double.parse(_amountTextController.text);
          double amountPerYear = depositAmount / 100 * double.parse(_percentTextController.text);
          income = amountPerYear * int.parse(_termTextController.text);
          totalAmount = depositAmount + income!;
          print(totalAmount);
      } else {
        totalAmount = null;
        income = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _amountTextController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Сумма вклада, руб.',
                      ),
                      onChanged: (String val) {
                        _calcDeposit();
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _termTextController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Срок вклада, лет',
                      ),
                      onChanged: (String val) {
                        _calcDeposit();
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _percentTextController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Процентная ставка, % годовых',
                      ),
                      onChanged: (String val) {
                        _calcDeposit();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0), 
                child: ListView(
                  children: [
                    const Text("Сумма в конце срока, руб.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(totalAmount == null ? "" : totalAmount.toString())
                  ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0), 
                  child: ListView(
                    children: [
                      const Text("Доход, руб.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(income == null ? "" : income.toString())
                    ],
                    )
                )
            ],
          )  
        ],
      )
    );
  }
}
