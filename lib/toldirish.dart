import 'package:flutter/material.dart';

class Toldirish extends StatefulWidget {
  const Toldirish({super.key});

  @override
  State<Toldirish> createState() => _ToldirishState();
}

class _ToldirishState extends State<Toldirish> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Press"),
          ),
          backgroundColor: Color(0xFFd6cdbc),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Toldrish"),
          ),
        ),
      ),
    );
  }
}
