// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notes_page.dart';

class EditorPage extends StatefulWidget {
  const EditorPage(
      {Key? key,
      required this.title,
      required this.content,
      required this.noteKey, required this.isDelete})
      : super(key: key);
  final int noteKey;
  final String title;
  final String content;
  final bool isDelete;
  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final _notesBox = Hive.box('notes');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _titleController.text = widget.title;
      _contentController.text = widget.content;
    });
    super.initState;
  }

  void deleteNote() {
    if (widget.noteKey != 0) {
      _notesBox.delete(widget.noteKey);
    }
  }

  void writeNote() {
    String title = _titleController.text.trim();
    String content = _contentController.text;
    if (title == '') {
      title = 'New Note';
    }
    if (widget.noteKey != 0) {
      _notesBox.put(widget.noteKey, [title, content]);
    } else {
      _notesBox.put(_notesBox.length + 1, [title, content]);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _contentController,
              style: GoogleFonts.aBeeZee(fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: 'Write your note here!'),
              expands: true,
              maxLines: null,
              minLines: null,
              maxLength: 1000,
              keyboardType: TextInputType.multiline,
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                writeNote();
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(milliseconds: 600),
                        type: PageTransitionType.leftToRightJoined,
                        child: NotesPage(),
                        childCurrent: this.widget));
              },
              child: Icon(
                Icons.check,
                shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
              )),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Visibility(
                visible: widget.isDelete,
                child: FloatingActionButton(

                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Center(
                            child: Text(
                              'Are you sure?',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    deleteNote();
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            alignment: Alignment.bottomCenter,
                                            curve: Curves.easeInOut,
                                            duration:
                                            Duration(milliseconds: 600),
                                            reverseDuration:
                                            Duration(milliseconds: 600),
                                            type: PageTransitionType
                                                .leftToRightJoined,
                                            child: NotesPage(),
                                            childCurrent: this.widget));
                                  },
                                ),
                                SizedBox(width: 80),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white
                                  ),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 30,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1))
                    ],
                  ),
                ),
              )
            ],
            title: TextField(
              controller: _titleController,
              style: GoogleFonts.pacifico(
                  fontSize: 25,
                  color: Colors.black,
                  ),
              decoration: InputDecoration(
                  hintStyle: GoogleFonts.pacifico(
                    fontSize: 25,
                  ),
                  hintText: 'Enter Title'),
            ),
          )),
    );
  }
}
