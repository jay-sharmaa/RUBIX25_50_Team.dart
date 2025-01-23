import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';

class InfoReadPage extends ConsumerStatefulWidget {
  final String text;
  const InfoReadPage({required this.text, super.key});

  @override
  ConsumerState<InfoReadPage> createState() => _InfoReadPageState();
}

class _InfoReadPageState extends ConsumerState<InfoReadPage> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  int _visibleCharacters = 0;
  bool _isReading = false;
  Timer? _readingTimer;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initTTSSettings();
  }

  void _initTTSSettings() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  void _toggleReadingAndSpeech() {
    if (_isReading) {
      _pauseReading();
      _stop();
    } else {
      _startReadingAnimation();
      _speak();
    }
  }

  void _startReadingAnimation() {
    if (_isReading) return;
    _isReading = true;

    _readingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _visibleCharacters++;
        
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          );
        }

        if (_visibleCharacters >= widget.text.length) {
          timer.cancel();
          _isReading = false;
        }
      });
    });
  }

  void _pauseReading() {
    _readingTimer?.cancel();
    _isReading = false;
  }

  void _speak() async {
    print("Hello");
    await flutterTts.speak(widget.text);
  }

  void _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50), 
        child: Appbar()
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.text.substring(0, min(_visibleCharacters, widget.text.length)),
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: widget.text.substring(min(_visibleCharacters, widget.text.length)),
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {_toggleReadingAndSpeech(); setState(() {
          
        });},
        child: Icon(_isReading ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    _readingTimer?.cancel();
    _scrollController.dispose();
    flutterTts.stop();
    super.dispose();
  }
}