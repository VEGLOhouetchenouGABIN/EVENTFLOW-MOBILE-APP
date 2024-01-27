// #sucessScreen.dart

import 'package:flutter/material.dart';

class SucessScreenPage extends StatelessWidget {
  late int amount;
  late String transactionId;
  SucessScreenPage(this.amount, this.transactionId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Montant : $amount XOF',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Transaction ID: $transactionId',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}