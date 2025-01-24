import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_intros/rome_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_lvl_intro_outro/rome_lvl_intro.dart';

class RomeQuiz1 extends StatefulWidget {
  @override
  _RomeQuiz1State createState() => _RomeQuiz1State();
}

class _RomeQuiz1State extends State<RomeQuiz1> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the name of the Roman amphitheater famous for gladiator fights?",
      "options": ["Pantheon", "Circus Maximus", "Colosseum", "Forum"],
      "correct": "Colosseum",
      "explanation":
          "The Colosseum, also known as the Flavian Amphitheater, was used for gladiatorial games and could hold up to 50,000 spectators.",
      "overlayImage": "assets/rome_lvl1_img.jpg"
    },
    {
      "question": "Who was the first emperor of Rome?",
      "options": ["Nero", "Julius Caesar", "Augustus", "Tiberius"],
      "correct": "Augustus",
      "explanation":
          "Augustus, also known as Octavian, was the first emperor of Rome and the adopted heir of Julius Caesar.",
      "overlayImage": "assets/rome_lvl1_img.jpg"
    },
    {
      "question": "Which river runs through the city of Rome?",
      "options": ["Tiber", "Danube", "Rhine", "Po"],
      "correct": "Tiber",
      "explanation":
          "The Tiber River was crucial to the founding and development of Rome and remains an important geographical feature of the city.",
      "overlayImage": "assets/rome_lvl1_img.jpg"
    },
    {
      "question":
          "What material did the Romans invent, allowing them to build lasting structures?",
      "options": ["Granite", "Marble", "Limestone", "Concrete"],
      "correct": "Concrete",
      "explanation":
          "Roman concrete, also known as opus caementicium, was durable and allowed for the construction of iconic buildings like the Colosseum and aqueducts.",
      "overlayImage": "assets/rome_lvl1_img.jpg"
    },
    {
      "question": "What were Roman aqueducts used for?",
      "options": [
        "Transporting water",
        "Military roads",
        "Defensive walls",
        "Storing grain"
      ],
      "correct": "Transporting water",
      "explanation":
          "Roman aqueducts were engineering marvels that brought fresh water to cities, enabling urban growth and public baths.",
      "overlayImage": "assets/rome_lvl1_img.jpg"
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
              MaterialPageRoute(builder: (context) => RomeTriviaPage()),
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
                image: AssetImage('assets/rome_lvl1_img.jpg'),
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
                    color: Colors.black,
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

class RomeQuiz2 extends StatefulWidget {
  @override
  _RomeQuiz2State createState() => _RomeQuiz2State();
}

class _RomeQuiz2State extends State<RomeQuiz2> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What was the Roman Forum primarily used for?",
      "options": [
        "Religious ceremonies only",
        "Military training",
        "Emperor's residence",
        "Markets and public gatherings"
      ],
      "correct": "Markets and public gatherings",
      "explanation":
          "The Roman Forum was the heart of ancient Rome, serving as a marketplace, public square, and center for civic activities.",
      "overlayImage": "assets/rome_lvl2_img.jpg"
    },
    {
      "question": "What was the Roman name for modern-day France?",
      "options": ["Hispania", "Gallia", "Britannia", "Germania"],
      "correct": "Gallia",
      "explanation":
          "Gallia (Gaul) was the Roman name for the region that roughly corresponds to modern-day France.",
      "overlayImage": "assets/rome_lvl2_img.jpg"
    },
    {
      "question":
          "Who was Rome's famous Carthaginian adversary during the Punic Wars?",
      "options": ["Cicero", "Scipio", "Marcus Aurelius", "Hannibal"],
      "correct": "Hannibal",
      "explanation":
          "Hannibal, a brilliant military commander from Carthage, famously crossed the Alps with war elephants to attack Rome.",
      "overlayImage": "assets/rome_lvl2_img.jpg"
    },
    {
      "question": "What were Roman public baths called?",
      "options": ["Thermae", "Aqueducts", "Cloacae", "Latrines"],
      "correct": "Thermae",
      "explanation":
          "Thermae were large public bathing complexes in Roman cities, offering hot, warm, and cold baths.",
      "overlayImage": "assets/rome_lvl2_img.jpg"
    },
    {
      "question":
          "What type of government did Rome have before becoming an empire?",
      "options": ["Monarchy", "Republic", "Democracy", "Oligarchy"],
      "correct": "Republic",
      "explanation":
          "Before transitioning to an empire, Rome was a republic where power was held by elected officials and a Senate.",
      "overlayImage": "assets/rome_lvl2_img.jpg"
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
              MaterialPageRoute(builder: (context) => RomeTriviaPage()),
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
                image: AssetImage('assets/rome_lvl2_img.jpg'),
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

class RomeQuiz3 extends StatefulWidget {
  @override
  _RomeQuiz3State createState() => _RomeQuiz3State();
}

class _RomeQuiz3State extends State<RomeQuiz3> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What was the purpose of the Roman instrument called a 'cornu'?",
      "options": [
        "Measuring time",
        "Religious ceremonies",
        "Military signaling",
        "Entertainment"
      ],
      "correct": "Military signaling",
      "explanation":
          "The cornu was a brass instrument used by Roman soldiers to signal commands during battles and marches.",
      "overlayImage": "assets/rome_lvl3_img.jpg"
    },
    {
      "question":
          "Which Roman emperor famously declared Christianity the official religion of the empire?",
      "options": ["Constantine I", "Nero", "Diocletian", "Hadrian"],
      "correct": "Constantine I",
      "explanation":
          "Constantine I, through the Edict of Milan and subsequent actions, established Christianity as a dominant religion in the empire.",
      "overlayImage": "assets/rome_lvl3_img.jpg"
    },
    {
      "question": "What was the purpose of the Cloaca Maxima in Rome?",
      "options": [
        "Drainage and sewage system",
        "Temple to the gods",
        "Marketplace",
        "Road construction"
      ],
      "correct": "Drainage and sewage system",
      "explanation":
          "The Cloaca Maxima was one of the world's earliest sewer systems, built to drain the marshlands of Rome.",
      "overlayImage": "assets/rome_lvl3_img.jpg"
    },
    {
      "question":
          "Which Roman goddess was the protector of the hearth and home?",
      "options": ["Minerva", "Juno", "Vesta", "Venus"],
      "correct": "Vesta",
      "explanation":
          "Vesta was the goddess of the hearth, and her temple in Rome contained the sacred fire tended by the Vestal Virgins.",
      "overlayImage": "assets/rome_lvl3_img.jpg"
    },
    {
      "question": "What was the main purpose of a Roman 'triumph'?",
      "options": [
        "To celebrate military victories",
        "To honor the gods",
        "To crown a new emperor",
        "To open a new Senate session"
      ],
      "correct": "To celebrate military victories",
      "explanation":
          "A triumph was a grand parade held in Rome to celebrate a military commander's victory and showcase spoils of war.",
      "overlayImage": "assets/rome_lvl3_img.jpg"
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
              MaterialPageRoute(builder: (context) => RomeTriviaPage()),
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
                image: AssetImage('assets/rome_lvl3_img.jpg'),
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

class RomeQuiz4 extends StatefulWidget {
  @override
  _RomeQuiz4State createState() => _RomeQuiz4State();
}

class _RomeQuiz4State extends State<RomeQuiz4> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What was the significance of the Roman milestone 'Milliarium Aureum'?",
      "options": [
        "It marked the center of the Roman road network.",
        "It was a symbol of Roman military victories.",
        "It marked the empire's borders.",
        "It was used for religious offerings."
      ],
      "correct": "It marked the center of the Roman road network.",
      "explanation":
          "The Milliarium Aureum (Golden Milestone) was placed in the Roman Forum and was considered the starting point of all Roman roads.",
      "overlayImage": "assets/rome_lvl4_img.jpg"
    },
    {
      "question": "What was the purpose of the Roman structure 'Hypocaust'?",
      "options": [
        "Underground storage",
        "Defensive walls",
        "Heating bathhouses",
        "Aqueduct support"
      ],
      "correct": "Heating bathhouses",
      "explanation":
          "The hypocaust was an innovative system used to heat Roman bathhouses and homes through a network of underfloor heating.",
      "overlayImage": "assets/rome_lvl4_img.jpg"
    },
    {
      "question": "What was unusual about the reign of Emperor Caligula?",
      "options": [
        "He removed the Senate entirely.",
        "He banned all public games.",
        "He declared war on Greece.",
        "He attempted to make his horse a consul."
      ],
      "correct": "He attempted to make his horse a consul.",
      "explanation":
          "Emperor Caligula was infamous for his eccentric and erratic behavior, including his reported intention to appoint his horse Incitatus as consul.",
      "overlayImage": "assets/rome_lvl4_img.jpg"
    },
    {
      "question": "What was the primary function of the Roman 'Tabularium'?",
      "options": [
        "To mint coins",
        "To house the Senate",
        "To store official records",
        "To act as a public library"
      ],
      "correct": "To store official records",
      "explanation":
          "The Tabularium, located in the Roman Forum, was the official records office of ancient Rome, preserving important legal and administrative documents.",
      "overlayImage": "assets/rome_lvl4_img.jpg"
    },
    {
      "question":
          "Which Roman emperor was responsible for building the Pantheon we see today?",
      "options": ["Hadrian", "Trajan", "Augustus", "Nero"],
      "correct": "Hadrian",
      "explanation":
          "Emperor Hadrian rebuilt the Pantheon in its current form around 126 AD, with its iconic domed roof and oculus.",
      "overlayImage": "assets/rome_lvl4_img.jpg"
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
              MaterialPageRoute(builder: (context) => RomeTriviaPage()),
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
                image: AssetImage('assets/rome_lvl4_img.jpg'),
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

