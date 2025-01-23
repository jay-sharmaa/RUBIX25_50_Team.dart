import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';
import 'package:rubix_time_machine/utils/timeline_data.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelinePage extends ConsumerStatefulWidget {
  final int themeNumber;
  const TimelinePage({required this.themeNumber, super.key});

  @override
  ConsumerState<TimelinePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<TimelinePage> {
  late List<dynamic> mylist = []; 
  late List<Uri> uriList = [];

  @override
  Widget build(BuildContext context) {
    final themenumber = ref.watch(themeNumber);
    if(themenumber == 1){
      mylist = ancientGreece;
      uriList = ancientGreeceUri;
    }
    else if(themenumber == 2){
      mylist = ancientEgypt;
      uriList = ancientEgyptUri;
    }
    else if(themenumber == 3){
      mylist = ancientIndia;
      uriList = ancientIndiaUri;
    }
    else if(themenumber == 4){
      mylist = ancientRome;
      uriList = ancientRomeUri;
    }

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: Appbar()),
        body: Stack(
          children: [

            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.22,
              child: SafeArea(
                child: TimelineTheme(
                  data: TimelineThemeData(
                    direction: Axis.vertical,
                    nodePosition: 1,
                  ),
                  child: Timeline.tileBuilder(
                    builder: TimelineTileBuilder.fromStyle(
                      itemExtent: 240,
                      contentsAlign: ContentsAlign.reverse,
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: GestureDetector(child: image_text(mylist[index].value, mylist[index].key),
                        onTap: () async{
                          lauchUri(uriList[index]);
                        }),
                      ),
                      itemCount: mylist.length,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

void lauchUri(Uri _uri) async{
  print(_uri);
  try{
  if (await canLaunchUrl(Uri.parse('https://flutter.dev'))) {
    await launchUrl(Uri.parse('https://flutter.dev'));
  }
  } catch(e){
    print(e);
  }
}

Widget image_text(String assets, String text){
  if(assets.length < 50){
  return Column(children: [
    Stack(children: [Image.asset('assets/$assets', height: 150,), const Icon(Icons.fullscreen)]),
    Text(text, style: const TextStyle(color: Color(0xA00000EE)))
  ],);
  }
  else{
    return Column(children: [
    Text(text, style: const TextStyle(color: Color(0xA00000EE))),
    Text(assets,)
  ],);
  }
}