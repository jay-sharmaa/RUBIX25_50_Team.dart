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
    if (themenumber == 1) {
      mylist = ancientGreece;
      uriList = ancientGreeceUri;
    } else if (themenumber == 2) {
      mylist = ancientEgypt;
      uriList = ancientEgyptUri;
    } else if (themenumber == 3) {
      mylist = ancientIndia;
      uriList = ancientIndiaUri;
    } else if (themenumber == 4) {
      mylist = ancientRome;
      uriList = ancientRomeUri;
    }

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: Appbar()),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                        child: GestureDetector(
                          child: image_text(
                              mylist[index].value, mylist[index].key),
                          onTap: () async {
                            lauchUri(uriList[index]);
                          },
                          onLongPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Image_Map(assets: (mylist[index].value));
                            }));
                          },
                        ),
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

void lauchUri(Uri _uri) async {
  print(_uri);
  try {
    if (await canLaunchUrl(_uri)) {
      await launchUrl(_uri);
    }
  } catch (e) {
    print(e);
  }
}

Widget image_text(String assets, String text) {
  if (assets.length < 50) {
    return Column(
      children: [
        Stack(children: [
          Hero(
              tag: assets,
              child: Image.asset(
                'assets/$assets',
                height: 150,
              )),
          const Icon(Icons.fullscreen)
        ]),
        Text(text, style: const TextStyle(color: Color(0xA00000EE)))
      ],
    );
  } else {
    return Column(
      children: [
        Text(text, style: const TextStyle(color: Color(0xA00000EE))),
        Text(
          assets,
        )
      ],
    );
  }
}

class Image_Map extends StatefulWidget {
  final String assets;
  const Image_Map({required this.assets, super.key});

  @override
  State<Image_Map> createState() => _Image_MapState();
}

class _Image_MapState extends State<Image_Map> {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.assets,
      child: GestureDetector(
          onDoubleTapDown: (d) {
            _doubleTapDetails = d;
          },
          onDoubleTap: () {
            _handleDoubleTap();
          },
          child: Stack(children: [
            InteractiveViewer(
                transformationController: _transformationController,
                child: Center(
                  child: Image.asset('assets/${widget.assets}'),
                )),
            Positioned(top: 800, left: 130, child: AnimatedGradientContainer())
          ])),
    );
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }
}

class AnimatedGradientContainer extends StatefulWidget {
  @override
  _AnimatedGradientContainerState createState() =>
      _AnimatedGradientContainerState();
}

class _AnimatedGradientContainerState extends State<AnimatedGradientContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Color> colorList = [
    Colors.purple.shade200,
    Colors.purple.shade400,
    Colors.purple.shade600,
    Colors.purple.shade400,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 160,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colorList,
                stops: [
                  0,
                  _controller.value,
                  _controller.value + 0.3,
                  1,
                ],
              ),
            ),
            child: const Material(
              type: MaterialType.transparency,
              child: Center(child: Text("Project AR", style: TextStyle(color: Colors.white, fontSize: 18),)),
            ),
          );
        },
      ),
    );
  }
}
