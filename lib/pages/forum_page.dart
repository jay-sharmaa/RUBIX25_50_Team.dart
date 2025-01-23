import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumPage extends ConsumerStatefulWidget {
  final int themeNumber;
  final int selected_page;
  const ForumPage(
      {required this.selected_page, required this.themeNumber, super.key});

  @override
  ConsumerState<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends ConsumerState<ForumPage> {
  List<String> chats = ['loading...'];
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  void _initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    chats = prefs.getStringList('${widget.themeNumber}') ?? [''];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themenumber = ref.watch(themeNumber);
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: Appbar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 640,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Text(chats[index]);
                  },
                  itemCount: chats.length,
                ),
              ),
              textMessage()
            ],
          ),
        ));
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
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.face,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {}),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Type Something...",
                            hintStyle: TextStyle(color: Colors.blueAccent),
                            border: InputBorder.none),
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
                  color: Colors.blueAccent, shape: BoxShape.circle),
              child: InkWell(
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onLongPress: () {},
              ),
            )
          ],
        ),
    );
  }
}
