import 'package:flutter/material.dart';
import 'package:signup/Notes.dart';
import 'package:signup/main.dart';

// ignore: must_be_immutable
class AddScreen extends StatefulWidget {
  String text;
  AddScreen({this.text});
  @override
  _AddScreenState createState() => _AddScreenState(text);
}

class _AddScreenState extends State<AddScreen> {
  String text;
  _AddScreenState(this.text) {
    if (text == "") {
      text = "No Name";
    }
  }
  List<Offset> _points = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text,
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
                  object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        tooltip: "Save",
        onPressed: () {
          noteHeadingController.text = text;
          noteHeading.add(noteHeadingController.text);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              tooltip: "Clear",
              onPressed: () => _points.clear(),
            ),
            IconButton(
                icon: Icon(Icons.note_add),
                tooltip: "Rename",
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;
  Signature({this.points});

  // ignore: empty_constructor_bodies
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
