import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_lvl_intro_outro/rome_lvl_intro.dart';

class RomeTriviaPage extends StatefulWidget {
  @override
  _RomeTriviaPageState createState() => _RomeTriviaPageState();
}

class _RomeTriviaPageState extends State<RomeTriviaPage> {
  bool _isPressed = false;

  void _startQuiz() {
    setState(() {
      _isPressed = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Level1Page(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ancient_rome_quiz_img.jpeg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Optional overlay
              ),
            ),
            // Page content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title Section
                  Text(
                    "TRIVIA",
                    style: GoogleFonts.cinzel(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_florist,
                          color: Colors.white, size: 30), // Half leaf crown
                      SizedBox(width: 10),
                      Text(
                        "ANCIENT",
                        style: GoogleFonts.cinzel(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.local_florist,
                          color: Colors.white, size: 30), // Half leaf crown
                    ],
                  ),

                  // SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ROME",
                        style: GoogleFonts.cinzel(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Text(
                    "Test your knowledge with the ANCIENT ROME trivia!\n\n"
                    "Can you conquer History like Julius Caesar?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Instructions Box
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), // Faded background
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instructions",
                          style: GoogleFonts.cinzel(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "- This trivia contains 5 levels of increasing difficulty.\n\n"
                          "- Passing each level earns you a Title.\n\n"
                          "- Rise from a humble learner to becoming the Master Scholar in the great halls of history!",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Quiz Button with animation and transition
                  GestureDetector(
                    onTap: _startQuiz,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isPressed
                            ? Color.fromARGB(255, 242, 206, 162)
                            : Colors.green,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: _isPressed
                            ? [
                                BoxShadow(
                                  color: Color.fromARGB(255, 242, 206, 162),
                                  blurRadius: 8.0,
                                  spreadRadius: 4.0,
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        "QUIZ",
                        style: GoogleFonts.cinzel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
