import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EgyptQuiz extends StatefulWidget {
  @override
  _EgyptQuizState createState() => _EgyptQuizState();
}

class _EgyptQuizState extends State<EgyptQuiz> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the name of the pharaoh who built the Great Pyramid of Giza?",
      "options": ["Khufu", "Tutankhamun", "Ramesses II", "Akhenaten"],
      "correct": "Khufu",
      "explanation":
          "The Great Pyramid of Giza was built for Pharaoh Khufu. It is one of the Seven Wonders of the Ancient World.",
      "overlayImage": "assets/egypt_lvl2_img.jpg"
    },
    {
      "question": "What is the ancient Egyptian writing system called?",
      "options": ["Cuneiform", "Hieroglyphs", "Runes", "Latin"],
      "correct": "Hieroglyphs",
      "explanation":
          "The ancient Egyptians used Hieroglyphs as their writing system, which consisted of pictorial symbols.",
      "overlayImage": "assets/egypt_lvl2_img.jpg"
    },
    {
      "question": "Which river was essential to ancient Egyptian civilization?",
      "options": ["Tigris", "Nile", "Euphrates", "Amazon"],
      "correct": "Nile",
      "explanation":
          "The Nile River was essential for agriculture, transportation, and sustaining life in ancient Egypt.",
      "overlayImage": "assets/egypt_lvl2_img.jpg"
    },
  ];

  int currentQuestionIndex = 0;

  void _nextQuestion(BuildContext context, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuizResultOverlay(
        isCorrect: isCorrect,
        explanation: questions[currentQuestionIndex]['explanation'],
        overlayImage: questions[currentQuestionIndex]['overlayImage'],
        onNext: () {
          Navigator.pop(context);
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              // Navigate to the next page when quiz ends
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SamplePage()),
              );
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/egypt_lvl1_img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Question Number
                Text(
                  "QUESTION ${currentQuestionIndex + 1}",
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Main Question
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    currentQuestion['question'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // Option Buttons
                ...currentQuestion['options'].map<Widget>((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => _nextQuestion(
                          context, option == currentQuestion['correct']),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            option,
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizResultOverlay extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String overlayImage;
  final VoidCallback onNext;

  QuizResultOverlay({
    required this.isCorrect,
    required this.explanation,
    required this.overlayImage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Result Text
            Text(
              isCorrect ? "CORRECT!" : "WRONG!",
              style: GoogleFonts.cinzel(
                fontSize: 24,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 16),
            // Image
            Image.asset(
              overlayImage,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Explanation Text
            Text(
              explanation,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            // Next Button
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                "Next",
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Page"),
      ),
      body: Center(
        child: Text(
          "You have completed the quiz!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
