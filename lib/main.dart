import 'package:flutter/material.dart';
import 'screens/price_screen.dart';

void main() => runApp(const Bitcoin());

class Bitcoin extends StatelessWidget {
  const Bitcoin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}