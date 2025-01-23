import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/pages/info_read_page.dart';
import 'package:rubix_time_machine/utils/colors.dart';
import 'package:rubix_time_machine/utils/timeline_data.dart';
import '../utils/appbar.dart';

const String themeKey = 'theme';

class Home extends ConsumerStatefulWidget {
  final int themeNumber;
  final int selectedPage;

  const Home(this.themeNumber, {required this.selectedPage, super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>{
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
      if(resultText.isEmpty){
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
          _buildContinueReadingSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var temp = await picker.pickImage(source: ImageSource.gallery);
            _file = File(temp!.path);
            _processImage(_file);
            Future.delayed(Duration(seconds: 3));
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return InfoReadPage(text: resultText);
            }));
          },
          backgroundColor: themeMode.colorScheme.primary,
          child: const Icon(Icons.add)
      ),
    );
  }

  SliverAppBar _buildQuotesSliverAppBar(BuildContext context, PageController _pageController) {
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
                                          style: const TextStyle(
                                              color: Colors.black),
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

  SliverList _buildContinueReadingSection() {
    return SliverList.list(children: [
      Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Jump where you left", style: TextStyle(fontSize: 20)),
            IconButton(
                onPressed: _handleMenuAction, icon: const Icon(Icons.menu)),
          ],
        ),
      ),
      const Divider(height: 5),
    
    ]);
  }

  void _handleMenuAction() {
    print('Menu button pressed');
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
}