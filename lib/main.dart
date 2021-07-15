import 'package:flutter/material.dart';

void main() {
  runApp(KnapSack());
}

class KnapSack extends StatelessWidget {
  const KnapSack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("KnapSack Illustration"),
        ),
      ),
    );
  }
}
