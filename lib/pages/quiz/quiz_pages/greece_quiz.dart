import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_intros/greece_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_lvl_intro_outro/greece_lvl_intro.dart';

class GreeceQuiz1 extends StatefulWidget {
  @override
  _GreeceQuiz1State createState() => _GreeceQuiz1State();
}

class _GreeceQuiz1State extends State<GreeceQuiz1> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the name of the epic poem that tells the story of the Trojan War?",
      "options": ["The Odyssey", "The Iliad", "The Aeneid", "Metamorphoses"],
      "correct": "The Iliad",
      "explanation":
          "The Iliad is an epic poem, written by Homer, that covers the quarrels and fighting near the end of the Trojan War. The story opens nine years into the war, which started because Paris, son of King Priam of Troy, kidnapped Helen from Menelaus, a Greek and brother of Agamemnon, King of Mycenae.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "Who is considered the king of the Greek gods?",
      "options": ["Poseidon", "Hades", "Zeus", "Apollo"],
      "correct": "Zeus",
      "explanation":
          "Zeus was the ruler of Mount Olympus and the God of the Sky, Thunder, and Justice.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What was the primary purpose of the Olympic Games in Ancient Greece?",
      "options": [
        "Entertainment",
        "Honoring Zeus",
        "Training soldiers",
        "Celebrating Harvest"
      ],
      "correct": "Honoring Zeus",
      "explanation":
          "The ancient Greeks believed that competitions of physical strength and agility pleased the Gods, so they held the Olympic Games every 4 years to honor Zeus",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What form of government did Athens develop around the 5th century BCE?",
      "options": ["Monarchy", "Oligarchy", "Democracy", "Republic"],
      "correct": "Democracy",
      "explanation":
          "Athens is credited with developing one of the earliest forms of democracy.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which city-state is famous for its military training and discipline?",
      "options": ["Athens", "Sparta", "Corinth", "Thebes"],
      "correct": "Sparta",
      "explanation":
          "Sparta was known for its warrior society and rigorous military education.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
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
              MaterialPageRoute(builder: (context) => GreeceTriviaPage()),
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
                image: AssetImage('assets/greece_lvl1_img.jpg'),
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

class GreeceQuiz2 extends StatefulWidget {
  @override
  _GreeceQuiz2State createState() => _GreeceQuiz2State();
}

class _GreeceQuiz2State extends State<GreeceQuiz2> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What was the central marketplace in Athens called?",
      "options": ["Forum", "Agora", "Acropolis", "Stoa"],
      "correct": "Agora",
      "explanation":
          "The Agora was a hub for social, political, and economic activities in Athens.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which Greek philosopher was the teacher of Alexander the Great?",
      "options": ["Plato", "Socrates", "Aristotle", "Pythagoras"],
      "correct": "Aristotle",
      "explanation":
          "Aristotle tutored Alexander and had a profound influence on his thinking.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What is the name of the famous temple dedicated to Athena in Athens?",
      "options": ["Parthenon", "Pantheon", "Erechtheions", "Temple of Apollo"],
      "correct": "Parthenon",
      "explanation":
          "The Parthenon was built during the 5th century BCE to honor Athena, the city’s patron goddess. Not to be confused with the Pantheon, the Roman Temple of Gods.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "Who was the Greek god of wine and revelry?",
      "options": ["Dionysus", "Apollo", "Hermes", "Hephaestus"],
      "correct": "Dionysus",
      "explanation":
          "Dionysus was associated with wine, theater, and ecstatic celebrations.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "Which Greek historian is known as the Father of History?",
      "options": ["Thucydides", "Herodotus", "Xenophon", "Polybius"],
      "correct": "Herodotus",
      "explanation":
          "Herodotus was the first to record historical events systematically in his work - HISTORIES.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
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
              MaterialPageRoute(builder: (context) => GreeceTriviaPage()),
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
                image: AssetImage('assets/greece_lvl2_img.jpg'),
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

class GreeceQuiz3 extends StatefulWidget {
  @override
  _GreeceQuiz3State createState() => _GreeceQuiz3State();
}

class _GreeceQuiz3State extends State<GreeceQuiz3> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What was the main focus of the Delian League, led by Athens?",
      "options": [
        "Trade",
        "Military alliance against Persia",
        "Expansion of democracy",
        "Cultural exchange"
      ],
      "correct": "Military alliance against Persia",
      "explanation":
          "The Delian League was a military alliance of Greek city-states formed in 478 BCE to protect themselves from the Persian Empire. The league was led by Athens and was based on the island of Delos.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What is the name of the female poet from Ancient Greece, known for her lyric poetry?",
      "options": ["Sappho", "Aspasia", "Diotima", "Pindar"],
      "correct": "Sappho",
      "explanation":
          "Sappho, from the island of Lesbos, wrote emotional poetry, much of which survives in fragments.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which early Greek civilization built the palace of Knossos on Crete?",
      "options": ["Mycenaeans", "Minoans", "Dorians", "Trojans"],
      "correct": "Minoans",
      "explanation":
          "Knossos is the name of an ancient city center-palace, built by the Minoan people on the island of Crete, which is in the Mediterranean Sea.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the significance of the Pythian Games in Greece?",
      "options": [
        "Celebrated military victories",
        "Honored Apollo",
        "Promoted trade among city-states",
        "Commemorated the founding of Athens"
      ],
      "correct": "Honored Apollo",
      "explanation":
          "The Pythian Games, held at Delphi, celebrated Apollo with music, poetry, and athletic contests.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What battle ended the Persian invasion of Greece in 479 BCE?",
      "options": [
        "Battle of Marathon",
        "Battle of Thermopylae",
        "Battle of Salamis",
        "Battle of Plataea"
      ],
      "correct": "Battle of Plataea",
      "explanation":
          "The Battle of Plataea was a decisive land battle in 479 BC between the Greek city-states and the Persian Empire. It was the final land battle of the second Persian invasion of Greece. It was won by the Greeks.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
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
              MaterialPageRoute(builder: (context) => GreeceTriviaPage()),
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
                image: AssetImage('assets/greece_lvl3_img.jpg'),
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

class GreeceQuiz4 extends StatefulWidget {
  @override
  _GreeceQuiz4State createState() => _GreeceQuiz4State();
}

class _GreeceQuiz4State extends State<GreeceQuiz4> {
  // Questions, Options, and Overlay Assets
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Who was the sculptor behind the statue of Zeus at Olympia, one of the Seven Wonders of the Ancient World?",
      "options": ["Phidias", "Polykleitos", "Praxiteles", "Lysippos"],
      "correct": "Phidias",
      "explanation":
          "Phidias was an Ancient Greek sculptor, painter, and architect, active in the 5th century BC. His Statue of Zeus at Olympia was one of the Seven Wonders of the Ancient World. He also created the statue of Athena in the Parthenon.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the significance of the SACRED BAND OF THEBES?",
      "options": [
        "A group of philosophers",
        "An elite military unit",
        "A cult of Apollo",
        "A theatrical troupe"
      ],
      "correct": "An elite military unit",
      "explanation":
          "The Sacred Band was a Theban elite force of 150 pairs of male lovers, believed to fight with unparalleled courage.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What innovation in naval warfare did the Greeks develop during the Battle of Salamis?",
      "options": [
        "Use of iron weapons",
        "Trireme ships",
        "Flaming arrows",
        "Catapults"
      ],
      "correct": "Trireme ships",
      "explanation":
          "The trireme, a fast and maneuverable warship, was key to the Greek victory against the Persians.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which Greek city-state established the first known public theater?",
      "options": ["Athens", "Delphi", "Corinth", "Thebes"],
      "correct": "Athens",
      "explanation":
          "The Theater of Dionysus in Athens hosted the first dramatic performances.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which Greek city-state used iron bars as currency instead of coins?",
      "options": ["Sparta", "Athens", "Corinth", "Delos"],
      "correct": "Sparta",
      "explanation":
          "The Spartans used iron bars, called pelanoi, as currency to make it difficult to accumulate wealth. They were prohibited by law from owning gold and silver coins. This was to discourage citizens from hoarding wealth and trading.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
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
              MaterialPageRoute(builder: (context) => GreeceTriviaPage()),
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
                image: AssetImage('assets/greece_lvl4_img.jpg'),
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

