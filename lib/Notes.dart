import 'package:flutter/material.dart';
import 'package:signup/addscreen.dart';

final List<String> noteHeading = [];
TextEditingController noteHeadingController = new TextEditingController();
String deletedNoteHeading = "";

class NotesPage extends StatefulWidget {
  NotesPage({Key key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  var text = "";
  void changetext(String text) {
    this.setState(() {
      this.text = text;
    });
  }

  final controller = TextEditingController();

  @override
  void dispose() {
    noteHeadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signature",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: noteHeading.length > 0
          ? buildNotes()
          : Center(child: Text("Add Drawings...")),
      floatingActionButton: FloatingActionButton(
        mini: false,
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          createAlertDialog(context);
        },
        child: Icon(Icons.create),
      ),
    );
  }

  Widget buildNotes() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: new ListView.builder(
        itemCount: noteHeading.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.5),
            child: new Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  deletedNoteHeading = noteHeading[index];
                  noteHeading.removeAt(index);
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    new SnackBar(
                      backgroundColor: Colors.purple,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            "Note Deleted",
                            style: TextStyle(),
                          ),
                          deletedNoteHeading != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (deletedNoteHeading != "") {
                                        noteHeading.add(deletedNoteHeading);
                                      }
                                      deletedNoteHeading = "";
                                    });
                                  },
                                  child: new Text(
                                    "Undo",
                                    style: TextStyle(),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  );
                });
              },
              background: ClipRRect(
                borderRadius: BorderRadius.circular(5.5),
                child: Container(
                  color: Colors.green,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
              ),
              secondaryBackground: ClipRRect(
                borderRadius: BorderRadius.circular(5.5),
                child: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),
                  ),
                ),
              ),
              child: noteList(index),
            ),
          );
        },
      ),
    );
  }

  Widget noteList(int index) {
    return TextButton(
      onPressed: () {},
      child: Text(
        noteHeading[index],
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Name"),
            content: TextField(
              controller: this.controller,
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text("Next"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddScreen(text: text)));
                  this.changetext(controller.text);
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
