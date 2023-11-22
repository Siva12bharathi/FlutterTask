// ignore_for_file: prefer_const_constructors, unnecessary_this
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'editor_page.dart';
import 'note_mini.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Your notes',
            style: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 30,
                ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [

            for (int key in _notesBox.keys)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          type: PageTransitionType.rightToLeftJoined,
                          child: EditorPage(
                              noteKey: key,
                              content: _notesBox.get(key)[1],
                              title: _notesBox.get(key)[0],
                          isDelete: true,),
                          childCurrent: this.widget));
                },
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  elevation: 2,
                  shadowColor: Colors.amberAccent,
                  child: NoteMini(
                      title: _notesBox.get(key)[0],
                      content: _notesBox.get(key)[1]),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 600),
                  reverseDuration: Duration(milliseconds: 600),
                  type: PageTransitionType.rightToLeftJoined,
                  child: EditorPage(noteKey: 0, content: '', title: '',isDelete: false,),
                  childCurrent: this.widget));
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),

    );
  }
}
