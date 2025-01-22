import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';
import 'package:rubix_time_machine/utils/timeline_data.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimelinePage extends ConsumerStatefulWidget {
  final int themeNumber;
  const TimelinePage({required this.themeNumber, super.key});

  @override
  ConsumerState<TimelinePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<TimelinePage> {
  late List<dynamic> mylist = []; // Initialize with empty list

  @override
  Widget build(BuildContext context) {
    final themenumber = ref.watch(themeNumber);
    if(themenumber == 1){
      mylist = ancientGreece;
    }
    else if(themenumber == 2){
      mylist = ancientEgypt;
    }
    else if(themenumber == 3){
      mylist = ancientIndia;
    }
    else if(themenumber == 4){
      mylist = ancientRome;
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
                      itemExtent: 180,
                      contentsAlign: ContentsAlign.reverse,
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(mylist[index].key, style: const TextStyle(overflow: TextOverflow.ellipsis),),
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
