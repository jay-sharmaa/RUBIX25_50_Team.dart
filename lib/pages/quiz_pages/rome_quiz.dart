import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RomeTrivia extends StatefulWidget {
  const RomeTrivia({super.key});

  @override
  State<RomeTrivia> createState() => _RomeTriviaState();
}

class _RomeTriviaState extends State<RomeTrivia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Rome Trivia Page"),
      ),
    );
  }
}
