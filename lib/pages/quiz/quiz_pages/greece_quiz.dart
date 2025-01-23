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
      "question": "What is the ancient Greeceian writing system called?",
      "options": ["Cuneiform", "Hieroglyphs", "Runes", "Latin"],
      "correct": "Hieroglyphs",
      "explanation":
          "The ancient Greeceians used Hieroglyphs as their writing system, which consisted of pictorial symbols.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which river was essential to ancient Greeceian civilization?",
      "options": ["Tigris", "Nile", "Euphrates", "Amazon"],
      "correct": "Nile",
      "explanation":
          "The Nile River was essential for agriculture, transportation, and sustaining life in ancient Greece.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the purpose of mummification in ancient Greece?",
      "options": [
        "To preserve the body for an afterlife",
        "To prevent disease",
        "To honor the deceased",
        "To prepare the body for burial"
      ],
      "correct": "To preserve the body for an afterlife",
      "explanation":
          "Ancient Greeceians believed that the preservation of the body was essential for the soul to continue its journey in the afterlife.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What was the primary material used to make the ancient Greeceian writing tool, the reed pen?",
      "options": ["Wood", "Metal", "Papyrus", "Stone"],
      "correct": "Papyrus",
      "explanation":
          "Papyrus reeds were used to make a type of paper and also to create pens for writing.",
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
                Padding(
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
      "question": "What was the ancient Greeceian name for the underworld?",
      "options": ["Amenti", "Duat", "Osiris II", "Anubis"],
      "correct": "Duat",
      "explanation":
          "The Duat was the ancient Greeceian underworld, where the souls of the deceased were judged and either rewarded or punished.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which pharaoh attempted to reform Greeceian religion by introducing monotheism?",
      "options": ["Tutankhamun", "Akhenaten", "Ramses II", "Cleopatra"],
      "correct": "Akhenaten",
      "explanation":
          "Akhenaten, also known as Amenhotep IV, introduced the worship of the sun disk Aten as the one true god.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What was the name of the ancient Greeceian book of the dead?",
      "options": [
        "The Book of the Nile",
        "The Book of Coming Forth by Day",
        "The Book of the Pyramids",
        "The Book of Life"
      ],
      "correct": "The Book of Coming Forth by Day",
      "explanation":
          "The Book of Coming Forth by Day was a collection of spells and rituals and was believed to help the deceased navigate the afterlife.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What was the name of the ancient Greeceian capital city during the Old Kingdom?",
      "options": ["Thebes", "Memphis", "Alexandria", "Giza"],
      "correct": "Memphis",
      "explanation":
          "Memphis was the capital of ancient Greece during the Old Kingdom and a major religious and cultural center.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which pharaoh is known for his extensive building projects, including the Abu Simbel temples?",
      "options": ["Tutankhamun", "Akhenaten", "Ramses II", "Cleopatra"],
      "correct": "Ramses II",
      "explanation":
          "Ramses II was a powerful pharaoh who ruled for over 60 years and left behind numerous monuments and temples.",
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
                Padding(
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
      "question": "What was the purpose of the ancient Greeceian pyramids?",
      "options": [
        "To serve as temples",
        "To house royal tombs",
        "To be used as fortresses",
        "To store grain"
      ],
      "correct": "To house royal tombs",
      "explanation":
          "The pyramids were built as monumental tombs for pharaohs and their consorts.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What is the name of the ancient Greeceian instrument that resembles a flute?",
      "options": ["Sistra", "Ney", "Daf", "Oud"],
      "correct": "Ney",
      "explanation":
          "The ney is a double-reed woodwind instrument that was popular in ancient Greece.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which god was associated with wisdom and writing in ancient Greece?",
      "options": ["Thoth", "Horus", "Anubis", "Osiris"],
      "correct": "Thoth",
      "explanation":
          "Thoth was the god of wisdom, magic, and writing, often depicted with the head of an ibis or baboon.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "Which famous archaeologist discovered the tomb of Tutankhamun?",
      "options": [
        "Howard Carter",
        "Jean-François Champollion",
        "Flinders Petrie",
        "Arthur Evans"
      ],
      "correct": "Howard Carter",
      "explanation":
          "Howard Carter's discovery of Tutankhamun's intact tomb in 1922 was a major archaeological sensation.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What is the name of the ancient Greeceian symbol that represents eternal life?",
      "options": ["Ankh", "Scarab", "Eye of Horus", "Djed pillar "],
      "correct": "Ankh",
      "explanation":
          "The ankh, also known as the CRUX ANSATA, is a symbol of life and immortality.",
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
                Padding(
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
          "Which festival was celebrated in ancient Greece to honor the rising of the Nile?",
      "options": [
        "Sed Festival",
        "Feast of Opet",
        "Feast of Min",
        "Feast of Wadjet"
      ],
      "correct": "Feast of Opet",
      "explanation":
          "The Feast of Opet was a major religious festival that celebrated the annual flooding of the Nile.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the role of scribes in ancient Greeceian society?",
      "options": ["Warriors", "Farmers", "Priests", "Administrators"],
      "correct": "Administrators",
      "explanation":
          "Scribes were highly educated individuals who served as record-keepers, administrators, and advisors to the pharaoh.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the significance of the Rosetta Stone?",
      "options": [
        "It revealed the secrets of mummification.",
        "It helped decipher hieroglyphs.",
        "It was used as a cornerstone for the Great Pyramid.",
        "It was a map of ancient Greece."
      ],
      "correct": "It helped decipher hieroglyphs.",
      "explanation":
          "The Rosetta Stone is a large, broken stone tablet that was discovered in Greece in 1799. It is inscribed with the same text in three scripts: hieroglyphic, Demotic, and Greek. The stone is a key to understanding Greeceian hieroglyphs and is one of the most famous objects in the British Museum.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question":
          "What was the impact of the Hyksos invasion on ancient Greece?",
      "options": [
        "It led to a period of cultural decline.",
        "Introduced new technologies and weapons to Greece.",
        "It had little impact on Greeceian society.",
        "It resulted in the unification of Upper and Lower Greece."
      ],
      "correct": "Introduced new technologies and weapons to Greece.",
      "explanation":
          "The Hyksos, a group of foreign rulers, brought new technologies like horse-drawn chariots and bronze weaponry to Greece.",
      "overlayImage": "assets/greece_lvl2_img.jpg"
    },
    {
      "question": "What was the ancient Greeceian name for the city of Thebes?",
      "options": ["Iunu", "Waset", "Nekhen", "Per-Ramesses"],
      "correct": "Waset",
      "explanation":
          "The city we now call Thebes was known as Waset to the ancient Greeceians. It was a prominent city during the New Kingdom and served as the religious capital, housing the Karnak and Luxor temples dedicated to the god Amun.",
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
                    color: Colors.black,
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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

