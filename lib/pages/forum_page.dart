import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumPage extends ConsumerStatefulWidget {
  final int themeNumber;
  final int selected_page;
  const ForumPage({required this.selected_page, required this.themeNumber, super.key});

  @override
  ConsumerState<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends ConsumerState<ForumPage> {
  List<String> chats = ['loading...'];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        chats = prefs.getStringList('${widget.themeNumber}') ?? [''];
      });
    } catch (e) {
      print('Error loading chats: $e');
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themenumber = ref.watch(themeNumber);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50), 
        child: Appbar()
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return textBubble(chats[chats.length - 1 - index]);
              },
              itemCount: chats.length,
            ),
          ),
          textMessage()
        ],
      ),
    );
  }

  Widget textMessage() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 3), 
                    blurRadius: 5, 
                    color: Colors.grey
                  )
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.face,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {}
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.blueAccent, 
              shape: BoxShape.circle
            ),
            child: InkWell(
              onTap: () async {
                if (_textEditingController.text.isNotEmpty) {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    chats.add(_textEditingController.text);
                  });
                  await prefs.setStringList('${widget.themeNumber}', chats);
                  _textEditingController.clear();
                }
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textBubble(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12), 
        child: Text(
          text, 
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}