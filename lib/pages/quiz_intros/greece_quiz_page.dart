import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz_pages/greece_quiz.dart';

class GreeceTriviaPage extends StatefulWidget {
  @override
  _GreeceTriviaPageState createState() => _GreeceTriviaPageState();
}

class _GreeceTriviaPageState extends State<GreeceTriviaPage> {
  bool _isPressed = false;

  void _startQuiz() {
    setState(() {
      _isPressed = true; // Button is pressed,change colour
    });

    // Simulate the button colour change and flash
    Future.delayed(Duration(seconds: 1), () {
      // After animation completes, navigate to EgyptTrivia
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              GreeceTrivia(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right to left
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
            // Background image
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ancient_greece_quiz_img.jpg'),
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
                        "GREECE",
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
                    "Test your knowledge with the ANCIENT GREECE trivia!\n\n"
                    "Are you sharp enough to match the Great Philosophers of Ancient Greece?",
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
                          "- This quiz contains 10 questions.\n"
                          "- Earn 1 point for each correct answer.\n"
                          "- Enjoy!",
                          style: GoogleFonts.lato(
                            fontSize: 16,
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
                            ? Color.fromARGB(255, 64, 33, 26)
                            : Colors.green,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: _isPressed
                            ? [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 64, 33, 26),
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
