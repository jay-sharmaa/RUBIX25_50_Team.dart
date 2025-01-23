import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndiaTrivia extends StatefulWidget {
  const IndiaTrivia({super.key});

  @override
  State<IndiaTrivia> createState() => _IndiaTriviaState();
}

class _IndiaTriviaState extends State<IndiaTrivia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("India Trivia Page"),
      ),
    );
  }
}
