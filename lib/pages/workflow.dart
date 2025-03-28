import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/main.dart';
import 'package:rubix_time_machine/utils/appbar.dart';

enum ShapeType { square, circle, rhombus }

class Connection {
  final DraggableItem from;
  final DraggableItem to;
  final Color color;

  Connection({
    required this.from,
    required this.to,
    this.color = Colors.black,
  });
}

class DraggableItem {
  final int id;
  Offset offset;
  final Widget child;
  final ShapeType type;
  final Color color;

  DraggableItem({
    required this.id,
    required this.offset,
    required this.child,
    required this.type,
    required this.color,
  });

  factory DraggableItem.createShape({
    required int id,
    required Offset offset,
    required ShapeType type,
    required String label,
  }) {
    switch (type) {
      case ShapeType.square:
        return DraggableItem(
          id: id,
          offset: offset,
          type: type,
          color: Colors.yellow,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.yellow,
            child: Center(
              child: Image.asset(label),
            ),
          ),
        );

      case ShapeType.circle:
        return DraggableItem(
          id: id,
          offset: offset,
          type: type,
          color: Colors.yellow.shade300,
          child: ClipOval(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.yellow.shade300,
              child: Center(
                child: Image.asset(label),
              ),
            ),
          ),
        );

      case ShapeType.rhombus:
        return DraggableItem(
          id: id,
          offset: offset,
          type: type,
          color: Colors.yellow.shade500,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.yellow.shade500,
              child: Center(
                child: Transform.rotate(
                  angle: -math.pi / 4,
                  child: Image.asset(label),
                ),
              ),
            ),
          ),
        );
    }
  }

  Offset get centerOffset {
    return Offset(
      offset.dx + 50.0,
      offset.dy + 50.0,
    );
  }
}

class PlaceHolder extends ConsumerStatefulWidget {
  const PlaceHolder({super.key});
  @override
  ConsumerState<PlaceHolder> createState() => _PlaceHolderState();
}

class _PlaceHolderState extends ConsumerState<PlaceHolder> {
  final Map<ShapeType, List<DraggableItem>> items = {
    ShapeType.square: [],
    ShapeType.circle: [],
    ShapeType.rhombus: [],
  };

  final Map<ShapeType, int> counters = {
    ShapeType.square: 0,
    ShapeType.circle: 0,
    ShapeType.rhombus: 0,
  };

  final List<Connection> connections = [];
  DraggableItem? selectedNode;

  List<Offset> points = [];
  List<String> names = [];

  @override
  void initState() {
    super.initState();

    items[ShapeType.square]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(15, 10),
      type: ShapeType.square,
      label: '',
    ));

    items[ShapeType.circle]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(130, 10),
      type: ShapeType.circle,
      label: '',
    ));

    items[ShapeType.rhombus]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(250, 28.37),
      type: ShapeType.rhombus,
      label: '',
    ));

  }

  void _initializeImages(){

    items[ShapeType.square]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(15, 10),
      type: ShapeType.square,
      label: names[2],
    ));

    items[ShapeType.circle]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(130, 10),
      type: ShapeType.circle,
      label: names[1],
    ));

    items[ShapeType.rhombus]!.add(DraggableItem.createShape(
      id: 0,
      offset: const Offset(250, 28.37),
      type: ShapeType.rhombus,
      label: names[0],
    ));

    setState(() {
      
    });
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 270,
            child: GridView(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ),
              children: [
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/plato.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white,child: SizedBox.square(dimension: 245, child: Image.asset('assets/plato.png')))
                ),
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/socrates.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white,child: SizedBox.square(dimension: 245 ,child: Image.asset('assets/socrates.png')))
                ),
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/alexander.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white, child: SizedBox.square(dimension: 245, child: Image.asset('assets/alexander.png')))
                ),
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/archemedes.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white,child: SizedBox.square(dimension: 245, child: Image.asset('assets/archemedes.png')))
                ),
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/pythagoras.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white,child: SizedBox.square(dimension: 245, child: Image.asset('assets/pythagoras.png')))
                ),
                GestureDetector(
                  onTap: (){
                    if(names.length > 2){
                      Navigator.pop(context);
                    }
                    names.add('assets/herodotus.png');
                    _initializeImages();
                  },
                  child: Container(height: 250, width: 250, color: Colors.white,child: SizedBox.square(dimension: 245, child: Image.asset('assets/herodotus.png')))
                ),
              ],
            ),
          );
        },
      );
  }

  void _handleDragEnd(DraggableItem item, Offset offset) {
    setState(() {
      final finalOffset = renderPosition(context, offset);

      if (item.id == 0) {
        String label = "";
        counters[item.type] = counters[item.type]! + 1;
        if(item.type == ShapeType.circle){
          label = names[0];
        }
        if(item.type == ShapeType.circle){
          label = names[1];
        }
        if(item.type == ShapeType.circle){
          label = names[2];
        }
        items[item.type]!.add(DraggableItem.createShape(
          id: counters[item.type]!,
          offset: finalOffset,
          type: item.type,
          label: label,
        ));
      } else {
        final index = items[item.type]!.indexWhere((i) => i.id == item.id);
        String label = "";
        if(item.type == ShapeType.rhombus){
          label = names[0];
        }
        if(item.type == ShapeType.circle){
          label = names[1];
        }
        if(item.type == ShapeType.square){
          label = names[2];
        }
        if (index != -1) {
          items[item.type]![index] = DraggableItem.createShape(
            id: item.id,
            offset: finalOffset,
            type: item.type,
            label: label,
          );

          for (var connection in connections) {
            if (connection.from.id == item.id) {
              connection.from.offset = finalOffset;
            }
            if (connection.to.id == item.id) {
              connection.to.offset = finalOffset;
            }
          }
        }
      }
    });
  }

  void _handleNodeTap(DraggableItem item) {
    setState(() {
      if (selectedNode == null) {
        selectedNode = item;
      } else if (selectedNode != item) {
        connections.add(Connection(
          from: selectedNode!,
          to: item,
        ));
        selectedNode = null;
      } else {
        selectedNode = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: Appbar()),
      body: SizedBox(
        height: 780,
        width: 450,
        child: Stack(
          children: [
            CustomPaint(
              painter: ConnectionPainter(
                connections: connections,
                selectedNode: selectedNode,
              ),
            ),
            ...items.entries.expand((entry) => entry.value.map(
                  (item) => Positioned(
                    left: item.offset.dx,
                    top: item.offset.dy,
                    child: GestureDetector(
                      onTap: () => _handleNodeTap(item),
                      child: Draggable<DraggableItem>(
                        data: item,
                        feedback: Opacity(
                          opacity: 0.7,
                          child: Material(child: item.child),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: Material(child: item.child),
                        ),
                        onDraggableCanceled: (velocity, offset) =>
                            _handleDragEnd(item, offset),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedNode?.id == item.id
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: item.child,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Offset renderPosition(BuildContext context, Offset offset) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset finalOffset = renderBox.globalToLocal(offset);
    if (finalOffset.dy <= 50) {
      return Offset(finalOffset.dx, 100);
    }
    return finalOffset - const Offset(0, 50);
  }
}

class ConnectionPainter extends CustomPainter {
  final List<Connection> connections;
  final DraggableItem? selectedNode;

  ConnectionPainter({
    required this.connections,
    this.selectedNode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final connection in connections) {
      final start = connection.from.centerOffset;
      final end = connection.to.centerOffset;

      canvas.drawLine(start, end, paint);

      _drawArrow(canvas, start, end, paint);
    }

    if (selectedNode != null) {
      paint.color = Colors.blue;
      paint.strokeWidth = 1;
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    const arrowSize = 15.0;
    final delta = end - start;
    final angle = math.atan2(delta.dy, delta.dx);

    final arrowPath = Path()
      ..moveTo(end.dx - arrowSize * math.cos(angle - math.pi / 6),
          end.dy - arrowSize * math.sin(angle - math.pi / 6))
      ..lineTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowSize * math.cos(angle + math.pi / 6),
          end.dy - arrowSize * math.sin(angle + math.pi / 6))
      ..close();

    canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
