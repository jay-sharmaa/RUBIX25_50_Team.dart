import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/pages/info_read_page.dart';
import 'package:rubix_time_machine/pages/quiz_intros/egypt_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz_intros/greece_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz_intros/india_quiz_page.dart';
import 'package:rubix_time_machine/pages/quiz_intros/rome_quiz_page.dart';
import 'package:rubix_time_machine/pages/timeline_page.dart';
import 'package:rubix_time_machine/pages/workflow.dart';
import 'package:rubix_time_machine/utils/colors.dart';
import 'package:rubix_time_machine/utils/timeline_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/appbar.dart';

const String themeKey = 'theme';

class Home extends ConsumerStatefulWidget {
  final int themeNumber;
  final int selectedPage;

  const Home(this.themeNumber, {required this.selectedPage, super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final ImagePicker picker = ImagePicker();

  late File _file;
  String resultText = "";
  Future<void> _processImage(File files) async {
    final inputImage = InputImage.fromFile(files);
    final textRecongnizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecongnizer.processImage(inputImage);
    List<TextBlock> extractedText = recognizedText.blocks;
    for (TextBlock block in extractedText) {
      String textIndex = "";
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          textIndex += element.text;
          textIndex += ' ';
        }
        textIndex += '\n';
      }
      resultText += textIndex;
    }
    if (resultText.isEmpty) {
      resultText = "No Text Found For conversion";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    PageController _pageController = PageController();
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: Appbar()),
      body: CustomScrollView(
        slivers: [
          _buildQuotesSliverAppBar(context, _pageController),
          _buildContinueReadingSection(themeMode),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var temp = await picker.pickImage(source: ImageSource.gallery);
            _file = File(temp!.path);
            _processImage(_file);
            Future.delayed(Duration(seconds: 3));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return InfoReadPage(text: resultText);
            }));
          },
          backgroundColor: themeMode.colorScheme.primary,
          child: const Icon(Icons.add)),
    );
  }

  SliverAppBar _buildQuotesSliverAppBar(
      BuildContext context, PageController _pageController) {
    return SliverAppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      expandedHeight: MediaQuery.of(context).size.height / 3.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: Colors.black26),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: quotes.length,
                itemBuilder: (context, index) => Container(
                  child: Row(
                    children: [
                      Image.asset(quotes[index].key, fit: BoxFit.contain),
                      const SizedBox(width: 20),
                      SizedBox.square(
                        dimension: 100,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/ancient.jpg'),
                                  fit: BoxFit.fitHeight),
                            ),
                            child: SizedBox(
                              width: 180,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  quotes[index].value,
                                  style: const TextStyle(color: Colors.black),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverList _buildContinueReadingSection(ThemeData theme) {
    return SliverList.list(children: [
      Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Jump where you left", style: TextStyle(fontSize: 20)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ],
        ),
      ),
      const Divider(height: 5),
      SizedBox(
        height: 200,
        width: 400,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
                child: thumbnail('assets/greece.png'),
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://youtu.be/46ZXl-V4qwY?si=SNTzIfSA-i2bKWtE'));
                }),
            const SizedBox(
              width: 25,
            ),
            GestureDetector(
              child: thumbnail('assets/egypt_thumbnail.png'),
              onTap: () {
                launchUrl(Uri.parse(
                    'https://youtu.be/xIXr4WNqRdM?si=p21KP4BrIW68RNmy'));
              },
            ),
            const SizedBox(
              width: 25,
            ),
            GestureDetector(
                child: thumbnail('assets/fall_of_rome.png'),
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://youtu.be/gFRxmi4uCGo?si=79jos1_Xc3NQS9ty'));
                })
          ],
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      SizedBox(
        height: 200,
        width: 400,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            quizPage('assets/ancient_egypt_quiz_img.jpg', theme),
            const SizedBox(
              width: 25,
            ),
            quizPage('assets/ancient_greece_quiz_img.jpg', theme),
            const SizedBox(
              width: 25,
            ),
            quizPage('assets/ancient_india_quiz_img.jpg', theme),
            const SizedBox(
              width: 25,
            ),
            quizPage('assets/ancient_rome_quiz_img.jpeg', theme),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black.withOpacity(.15)),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings,
                    size: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.refresh, size: 35),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PlaceHolder();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: 160,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Practice",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: 32,
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Saved File",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Icon(
                          Icons.play_arrow,
                          size: 32,
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 25,
      ),
    ]);
  }

  void lauchUri(Uri _uri) async {
    try {
      if (await canLaunchUrl(_uri)) {
        await launchUrl(_uri);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget quizPage(String name, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Image.asset(name),
          ),
          Positioned(
            top: 140,
            left: 100,
            child: GestureDetector(
              onTap: (){
                print(name);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  print(name);
                  if(name == 'assets/ancient_greece_quiz_img.jpg'){
                    return GreeceTriviaPage();
                  }
                  if(name == 'assets/ancient_india_quiz_img.jpg'){
                    return IndiaTriviaPage();
                  }
                  if(name == 'assets/ancient_rome_quiz_img.jpeg'){
                    return RomeTriviaPage();
                  }
                  if(name == 'assets/ancient_egypt_quiz_img.jpg'){
                    return EgyptTriviaPage();
                  }
                  return PlaceHolder();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.primary.withOpacity(.75),
                ),
                child: const Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: const Text(
                    "Take Quiz",
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageTextCard(
      {required String imagePath, required String cardText}) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error_outline),
                ),
              ),
            ),
            Expanded(
              child: Text(
                cardText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thumbnail(String name) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 350,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(name),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 40,
          ),
        ),
      ],
    );
  }
}
