import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreeceTrivia extends StatefulWidget {
  const GreeceTrivia({super.key});

  @override
  State<GreeceTrivia> createState() => _GreeceTriviaState();
}

class _GreeceTriviaState extends State<GreeceTrivia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Greece Trivia Page"),
      ),
    );
  }
}
