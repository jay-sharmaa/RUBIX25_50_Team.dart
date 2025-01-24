import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_intros/india_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_lvl_intro_outro/india_lvl_intro.dart';

class IndiaQuiz1 extends StatefulWidget {
  @override
  _IndiaQuiz1State createState() => _IndiaQuiz1State();
}

class _IndiaQuiz1State extends State<IndiaQuiz1> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the name of the ancient Indian river valley civilization?",
      "options": [
        "Indus Valley Civilization",
        "Mesopotamian Civilization",
        "Mayan Civilization",
        "Nile Valley Civilization"
      ],
      "correct": "Indus Valley Civilization",
      "explanation":
          "The Indus Valley Civilization was one of the world's earliest urban civilizations, flourishing around 2500 BCE in modern-day India and Pakistan.",
      "overlayImage": "assets/india_lvl1_img.jpg"
    },
    {
      "question": "Who is considered the founder of Buddhism?",
      "options": ["Ashoka", "Mahavira", "Gautama Buddha", "Vishnu"],
      "correct": "Gautama Buddha",
      "explanation":
          "Gautama Buddha, also known as Siddhartha Gautama, founded Buddhism in the 6th century BCE.",
      "overlayImage": "assets/india_lvl1_img.jpg"
    },
    {
      "question":
          "What is the ancient Indian text that discusses Philosophy and is also a conversation?",
      "options": ["Mahabharata", "Rigveda", "Upanishads", "Bhagavad Gita"],
      "correct": "Bhagavad Gita",
      "explanation":
          "The Bhagavad Gita, a part of the Mahabharata, contains teachings on yoga, meditation, and philosophy.",
      "overlayImage": "assets/india_lvl1_img.jpg"
    },
    {
      "question":
          "What is the name of the ancient Indian script used in the Indus Valley Civilization?",
      "options": ["Brahmi", "Devanagari", "Harappan Script", "Sanskrit"],
      "correct": "Harappan Script",
      "explanation":
          "The Harappan Script, used in the Indus Valley Civilization, remains undeciphered to this day.",
      "overlayImage": "assets/india_lvl1_img.jpg"
    },
    {
      "question":
          "Which emperor was responsible for spreading Buddhism across Asia?",
      "options": ["Ashoka", "Chandragupta Maurya", "Samudragupta", "Harsha"],
      "correct": "Ashoka",
      "explanation":
          "Emperor Ashoka embraced Buddhism after the Kalinga War and sent missionaries to spread its teachings across Asia.",
      "overlayImage": "assets/india_lvl1_img.jpg"
    }
  ];

  int currentQuestionIndex = 0;

  void _nextQuestion(BuildContext context, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuizResultOverlay1(
        isCorrect: isCorrect,
        explanation: questions[currentQuestionIndex]['explanation'],
        overlayImage: questions[currentQuestionIndex]['overlayImage'],
        onRestart: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;

            // Navigate to the next page when quiz ends
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IndiaTriviaPage()),
            );
          });
        },
        onNext: () {
          Navigator.pop(context);
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              // Navigate to the next page when quiz ends
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Level1End()),
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
                image: AssetImage('assets/india_lvl1_img.jpg'),
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
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

class QuizResultOverlay1 extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String overlayImage;
  final VoidCallback onNext;
  final VoidCallback onRestart;

  QuizResultOverlay1({
    required this.isCorrect,
    required this.explanation,
    required this.overlayImage,
    required this.onNext,
    required this.onRestart,
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
              onPressed: isCorrect ? onNext : onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                isCorrect ? "Next" : "Restart",
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
} //LEVEL 1 END

class IndiaQuiz2 extends StatefulWidget {
  @override
  _IndiaQuiz2State createState() => _IndiaQuiz2State();
}

class _IndiaQuiz2State extends State<IndiaQuiz2> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which ancient Indian city is known for its Great Bath?",
      "options": ["Harappa", "Mohenjo-Daro", "Lothal", "Dholavira"],
      "correct": "Mohenjo-Daro",
      "explanation":
          "The Great Bath of Mohenjo-Daro is a large public bathing structure, highlighting the advanced urban planning of the Indus Valley Civilization.",
      "overlayImage": "assets/india_lvl2_img.jpg"
    },
    {
      "question": "What was the main purpose of the Ashokan Pillars?",
      "options": [
        "To spread Buddhist teachings",
        "To mark territorial boundaries",
        "To honor Hindu gods",
        "To commemorate wars"
      ],
      "correct": "To spread Buddhist teachings",
      "explanation":
          "The Ashokan Pillars were erected by Emperor Ashoka to spread Buddhist teachings and edicts across his empire.",
      "overlayImage": "assets/india_lvl2_img.jpg"
    },
    {
      "question":
          "Which ancient Indian language is known as the 'language of the gods'?",
      "options": ["Tamil", "Pali", "Prakrit", "Sanskrit"],
      "correct": "Sanskrit",
      "explanation":
          "Sanskrit, considered the 'language of the gods,' was used for ancient Indian scriptures and texts such as the Vedas.",
      "overlayImage": "assets/india_lvl2_img.jpg"
    },
    {
      "question": "What is the Rigveda primarily composed of?",
      "options": ["Laws", "Epics", "Hymns", "Stories"],
      "correct": "Hymns",
      "explanation":
          "The Rigveda, one of the oldest Indian texts, is primarily a collection of hymns dedicated to various deities.",
      "overlayImage": "assets/india_lvl2_img.jpg"
    },
    {
      "question":
          "What ancient Indian university was renowned for its advanced learning?",
      "options": ["Takshashila", "Nalanda", "Varanasi", "Kanchipuram"],
      "correct": "Nalanda",
      "explanation":
          "Nalanda University was a famous center for learning in ancient India, attracting students from all over Asia.",
      "overlayImage": "assets/india_lvl2_img.jpg"
    }
  ];

  int currentQuestionIndex = 0;

  void _nextQuestion(BuildContext context, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuizResultOverlay2(
        isCorrect: isCorrect,
        explanation: questions[currentQuestionIndex]['explanation'],
        overlayImage: questions[currentQuestionIndex]['overlayImage'],
        onRestart: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;

            // Navigate to the next page when quiz ends
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IndiaTriviaPage()),
            );
          });
        },
        onNext: () {
          Navigator.pop(context);
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              // Navigate to the next page when quiz ends
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Level2End()),
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
                image: AssetImage('assets/india_lvl2_img.jpg'),
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
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

class QuizResultOverlay2 extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String overlayImage;
  final VoidCallback onNext;
  final VoidCallback onRestart;

  QuizResultOverlay2({
    required this.isCorrect,
    required this.explanation,
    required this.overlayImage,
    required this.onNext,
    required this.onRestart,
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
              onPressed: isCorrect ? onNext : onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                isCorrect ? "Next" : "Restart",
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
} //LEVEL 2 END

class IndiaQuiz3 extends StatefulWidget {
  @override
  _IndiaQuiz3State createState() => _IndiaQuiz3State();
}

class _IndiaQuiz3State extends State<IndiaQuiz3> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which Mauryan ruler authored the book 'Arthashastra'?",
      "options": ["Bindusara", "Ashoka", "Chandragupta Maurya", "Chanakya"],
      "correct": "Chanakya",
      "explanation":
          "Chanakya, also known as Kautilya, was the advisor to Chandragupta Maurya and authored the 'Arthashastra,' a treatise on governance.",
      "overlayImage": "assets/india_lvl3_img.jpg"
    },
    {
      "question":
          "What was the primary export of the Indus Valley Civilization?",
      "options": ["Cotton textiles", "Spices", "Gold", "Horses"],
      "correct": "Cotton textiles",
      "explanation":
          "The Indus Valley Civilization was known for its high-quality cotton textiles, which were exported to Mesopotamia.",
      "overlayImage": "assets/india_lvl3_img.jpg"
    },
    {
      "question":
          "Which Gupta dynasty innovation is considered the precursor to modern mathematics?",
      "options": ["Geometry", "Decimal system", "Binary code", "Logarithms"],
      "correct": "Decimal system",
      "explanation":
          "The Gupta dynasty mathematicians developed the decimal system and the concept of zero, which revolutionized mathematics.",
      "overlayImage": "assets/india_lvl3_img.jpg"
    },
    {
      "question": "Who was the author of the ancient Indian play 'Shakuntala'?",
      "options": ["Bhasa", "Valmiki", "Vyasa", "Kalidasa"],
      "correct": "Kalidasa",
      "explanation":
          "Kalidasa, one of ancient India's greatest poets and playwrights, wrote 'Shakuntala,' a classic Sanskrit play.",
      "overlayImage": "assets/india_lvl3_img.jpg"
    },
    {
      "question": "What was the primary purpose of the Great Stupa at Sanchi?",
      "options": [
        "To serve as a palace",
        "To mark territorial boundaries",
        "To house Buddhist relics",
        "To act as a temple"
      ],
      "correct": "To house Buddhist relics",
      "explanation":
          "The Great Stupa at Sanchi was built to house Buddhist relics and serve as a site for meditation and worship.",
      "overlayImage": "assets/india_lvl3_img.jpg"
    }
  ];

  int currentQuestionIndex = 0;

  void _nextQuestion(BuildContext context, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuizResultOverlay3(
        isCorrect: isCorrect,
        explanation: questions[currentQuestionIndex]['explanation'],
        overlayImage: questions[currentQuestionIndex]['overlayImage'],
        onRestart: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;

            // Navigate to the next page when quiz ends
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IndiaTriviaPage()),
            );
          });
        },
        onNext: () {
          Navigator.pop(context);
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              // Navigate to the next page when quiz ends
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Level3End()),
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
                image: AssetImage('assets/india_lvl3_img.jpg'),
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
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

class QuizResultOverlay3 extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String overlayImage;
  final VoidCallback onNext;
  final VoidCallback onRestart;

  QuizResultOverlay3({
    required this.isCorrect,
    required this.explanation,
    required this.overlayImage,
    required this.onNext,
    required this.onRestart,
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
              onPressed: isCorrect ? onNext : onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                isCorrect ? "Next" : "Restart",
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
} //LEVEL 3 END

class IndiaQuiz4 extends StatefulWidget {
  @override
  _IndiaQuiz4State createState() => _IndiaQuiz4State();
}

class _IndiaQuiz4State extends State<IndiaQuiz4> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the name of the ancient Indian board game that inspired chess?",
      "options": ["Ashtapada", "Pachisi", "Snakes and Ladders", "Chaturanga"],
      "correct": "Chaturanga",
      "explanation":
          "Chaturanga, an ancient Indian strategy game, is considered the precursor to modern chess.",
      "overlayImage": "assets/india_lvl4_img.jpg"
    },
    {
      "question":
          "Which ancient Indian medical text is considered foundational in Ayurveda?",
      "options": [
        "Rigveda",
        "Sushruta Samhita",
        "Charaka Samhita",
        "Atharvaveda"
      ],
      "correct": "Charaka Samhita",
      "explanation":
          "The 'Charaka Samhita' is one of the foundational texts of Ayurveda, detailing principles of medicine and healing.",
      "overlayImage": "assets/india_lvl4_img.jpg"
    },
    {
      "question":
          "Which empire built the Iron Pillar of Delhi that does not rust?",
      "options": [
        "Chola Dynasty",
        "Maurya Empire",
        "Gupta Empire",
        "Mughal Empire"
      ],
      "correct": "Gupta Empire",
      "explanation":
          "The Iron Pillar of Delhi, built during the Gupta Empire, is a metallurgical marvel that resists rusting.",
      "overlayImage": "assets/india_lvl4_img.jpg"
    },
    {
      "question":
          "What is the significance of the Ashvamedha ritual in ancient India?",
      "options": [
        "It was a horse sacrifice to assert a king's supremacy.",
        "It was a prayer for rainfall.",
        "It marked the coronation of a new ruler.",
        "It was a fertility ceremony."
      ],
      "correct": "It was a horse sacrifice to assert a king's supremacy.",
      "explanation":
          "The Ashvamedha was an elaborate horse sacrifice ritual performed by ancient Indian kings to assert their dominance over neighboring territories.",
      "overlayImage": "assets/india_lvl4_img.jpg"
    },
    {
      "question": "Who composed the ancient Indian epic 'Ramayana'?",
      "options": ["Vyasa", "Valmiki", "Kalidasa", "Bhasa"],
      "correct": "Valmiki",
      "explanation":
          "Valmiki, regarded as the 'Adi Kavi' or first poet, composed the Ramayana, one of the two great Indian epics.",
      "overlayImage": "assets/india_lvl4_img.jpg"
    }
  ];

  int currentQuestionIndex = 0;

  void _nextQuestion(BuildContext context, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuizResultOverlay4(
        isCorrect: isCorrect,
        explanation: questions[currentQuestionIndex]['explanation'],
        overlayImage: questions[currentQuestionIndex]['overlayImage'],
        onRestart: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;

            // Navigate to the next page when quiz ends
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IndiaTriviaPage()),
            );
          });
        },
        onNext: () {
          Navigator.pop(context);
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              // Navigate to the next page when quiz ends
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Level4End()),
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
                image: AssetImage('assets/india_lvl4_img.jpg'),
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
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

class QuizResultOverlay4 extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String overlayImage;
  final VoidCallback onNext;
  final VoidCallback onRestart;

  QuizResultOverlay4({
    required this.isCorrect,
    required this.explanation,
    required this.overlayImage,
    required this.onNext,
    required this.onRestart,
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
              onPressed: isCorrect ? onNext : onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                isCorrect ? "Next" : "Restart",
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
} //LEVEL 4 END

