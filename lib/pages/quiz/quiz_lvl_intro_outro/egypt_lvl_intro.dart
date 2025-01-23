import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_pages/egypt_quiz.dart';
import 'package:rubix_time_machine/pages/quiz/quiz_intros/egypt_quiz_page.dart';

class Level1Page extends StatefulWidget {
  @override
  _Level1PageState createState() => _Level1PageState();
}

class _Level1PageState extends State<Level1Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Wait 1 second for the level text
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/egypt_lvl1_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level text
                Container(
                  color: Colors.white.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Level 1",
                    style: GoogleFonts.eagleLake(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 117, 3, 3),
                    ),
                  ),
                ),

                // Animated content
                SlideTransition(
                  position: _contentAnimation,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Level title
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "THE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "HOUSE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Of",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "LIFE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Level image
                        Image.asset(
                          'assets/egypt_lvl1_img.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 30),

                        // Play button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EgyptQuiz1(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "PLAY",
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 151, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} //LEVEL 1 INTRO

class Level1End extends StatelessWidget {
  const Level1End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/egypt_lvl1_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.3),
                padding: EdgeInsets.all(10),
                child: Text(
                  "YOU PASS!",
                  style: GoogleFonts.eagleLake(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 117, 3, 3),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'YOUR TITLE:',
                style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'THE SCRIBE',
                style: GoogleFonts.cinzel(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/scribe.jpg',
                height: 200,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Level2Page()),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.cinzel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //LEVEL 1 OUTRO

class Level2Page extends StatefulWidget {
  @override
  _Level2PageState createState() => _Level2PageState();
}

class _Level2PageState extends State<Level2Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Wait 1 second for the level text
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/egypt_lvl2_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level text
                Container(
                  color: Colors.white.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Level 2",
                    style: GoogleFonts.eagleLake(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 117, 3, 3),
                    ),
                  ),
                ),

                // Animated content
                SlideTransition(
                  position: _contentAnimation,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Level title
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "THE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "TEMPLE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Of",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "KARNAK",
                                style: GoogleFonts.cinzel(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Level image
                        Image.asset(
                          'assets/egypt_lvl2_img.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 30),

                        // Play button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EgyptQuiz2(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "PLAY",
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 151, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} //LEVEL 2 INTRO

class Level2End extends StatelessWidget {
  const Level2End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/egypt_lvl2_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.3),
                padding: EdgeInsets.all(10),
                child: Text(
                  "YOU PASS!",
                  style: GoogleFonts.eagleLake(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 117, 3, 3),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'YOUR TITLE:',
                style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'KEEPER',
                style: GoogleFonts.cinzel(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'OF',
                style: GoogleFonts.cinzel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'SCROLLS',
                style: GoogleFonts.cinzel(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/keeper.jpg',
                height: 200,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Level3Page()),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.cinzel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //LEVEL 2 OUTRO

class Level3Page extends StatefulWidget {
  @override
  _Level3PageState createState() => _Level3PageState();
}

class _Level3PageState extends State<Level3Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Wait 1 second for the level text
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/egypt_lvl3_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level text
                Container(
                  color: Colors.white.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Level 3",
                    style: GoogleFonts.eagleLake(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 117, 3, 3),
                    ),
                  ),
                ),

                // Animated content
                SlideTransition(
                  position: _contentAnimation,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Level title
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "LIBRARY",
                                style: GoogleFonts.cinzel(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Of",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "ALEXANDRIA",
                                style: GoogleFonts.cinzel(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Level image
                        Image.asset(
                          'assets/egypt_lvl3_img.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 30),

                        // Play button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EgyptQuiz3(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "PLAY",
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 151, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} //LEVEL 3 INTRO

class Level3End extends StatelessWidget {
  const Level3End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/egypt_lvl3_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.3),
                padding: EdgeInsets.all(10),
                child: Text(
                  "YOU PASS!",
                  style: GoogleFonts.eagleLake(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 117, 3, 3),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'YOUR TITLE:',
                style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'THE',
                style: GoogleFonts.cinzel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'ARCHIVIST',
                style: GoogleFonts.cinzel(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'OF',
                style: GoogleFonts.cinzel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Center(
                child: Text(
                  'ALEXANDRIA',
                  style: GoogleFonts.cinzel(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/archivist.jpg',
                height: 200,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Level4Page()),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.cinzel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //LEVEL 3 OUTRO

class Level4Page extends StatefulWidget {
  @override
  _Level4PageState createState() => _Level4PageState();
}

class _Level4PageState extends State<Level4Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Wait 1 second for the level text
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/egypt_lvl4_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level text
                Container(
                  color: Colors.white.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Level 4",
                    style: GoogleFonts.eagleLake(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 117, 3, 3),
                    ),
                  ),
                ),

                // Animated content
                SlideTransition(
                  position: _contentAnimation,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Level title
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "THE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "TEMPLE",
                                style: GoogleFonts.cinzel(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Of",
                                style: GoogleFonts.cinzel(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "RA",
                                style: GoogleFonts.cinzel(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Level image
                        Image.asset(
                          'assets/egypt_lvl4_img.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 30),

                        // Play button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EgyptQuiz4(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "PLAY",
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 151, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} //LEVEL 4 INTRO

class Level4End extends StatelessWidget {
  const Level4End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/egypt_lvl4_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.3),
                padding: EdgeInsets.all(10),
                child: Text(
                  "YOU HAVE COMPLETED THE ANCIENT EGYPT TRIVIA!",
                  style: GoogleFonts.eagleLake(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 117, 3, 3),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'YOUR TITLE:',
                style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                'THE VIZIER',
                style: GoogleFonts.cinzel(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'OF',
                style: GoogleFonts.cinzel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'RA',
                style: GoogleFonts.cinzel(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/vizier.jpg',
                height: 200,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EgyptTriviaPage()),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.cinzel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //LEVEL 4 OUTRO