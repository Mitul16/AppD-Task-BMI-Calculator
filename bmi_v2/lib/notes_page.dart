import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'simple_button.dart';
import 'note.dart';

/*
            !!!BEWARE!!!
     bad code ahead, watch out!!!
*/

// wrong scrollbar position???

// will refactor this mess later

String userInput = '';
TextEditingController textEditingController = TextEditingController();
bool isDataRead = false;

final NoteModel noteModel = NoteModel();

class NotesPage extends StatefulWidget {
  NotesPage({Key key}) : super(key: key) {
    if (!isDataRead) {
      noteModel.readData();
      isDataRead = true;
    }
  }

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  void update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    noteModel.addListener(update);
  }

  @override
  void dispose() {
    noteModel.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Notes - ${noteModel.getNoteCount()}'),
            SimpleButton(
              icon: Icons.add,
              onTap: () {
                textEditingController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Add a note',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      ),
                      content: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 16,
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            child: TextField(
                              minLines: 1,
                              maxLines: 4,
                              maxLength: 256,
                              maxLengthEnforced: true,
                              controller: textEditingController,
                              onChanged: (current) {
                                userInput = current;
                              },
                              style: TextStyle(
                                fontFamily: 'Shadows Into Light Two',
                                fontSize: 24,
                              ),
                            ),
                          ),
                          FloatingActionButton.extended(
                            label: Text(
                              'Save',
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.light ?
                                Colors.black : Colors.white,
                              ),
                            ),
                            icon: Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (userInput.isNotEmpty) {
                                noteModel.addNote(Note(userInput, false));
                                userInput = '';
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        leading: ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: noteModel.isEmpty() ? Center(
        child: Text(
          'Add a note',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Shadows Into Light Two',
          ),
        ),
      ) : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemCount: noteModel.getNoteCount(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        textEditingController.value = TextEditingValue.fromJSON({'text': noteModel.getNote(index).value});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Viewing note',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Comfortaa',
                                  ),
                                ),
                              ),
                              content: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 8,
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(8),
                                    child: TextField(
                                      minLines: 1,
                                      maxLines: 4,
                                      readOnly: true,
                                      controller: textEditingController,
                                      style: TextStyle(
                                        decoration: noteModel.getNote(index).checked ? TextDecoration.lineThrough : TextDecoration.none,
                                        fontFamily: 'Shadows Into Light Two',
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        noteModel.getNote(index).value,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 24,
                          decoration: noteModel.getNote(index).checked ? TextDecoration.lineThrough : TextDecoration.none,
                          fontFamily: 'Shadows Into Light Two',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SimpleButton(
                          icon: Icons.edit,
                          onTap: () {
                            userInput = noteModel.getNote(index).value;
                            textEditingController.value = TextEditingValue.fromJSON({'text': noteModel.getNote(index).value});
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Editing note',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Comfortaa',
                                      ),
                                    ),
                                  ),
                                  content: Wrap(
                                    alignment: WrapAlignment.center,
                                    runSpacing: 8,
                                    children: <Widget>[
                                      Material(
                                        borderRadius: BorderRadius.circular(8),
                                        child: TextField(
                                          minLines: 1,
                                          maxLines: 4,
                                          maxLength: 256,
                                          maxLengthEnforced: true,
                                          controller: textEditingController,
                                          onChanged: (current) {
                                            userInput = current;
                                          },
                                          style: TextStyle(
                                            fontFamily: 'Shadows Into Light Two',
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                      FloatingActionButton.extended(
                                        label: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Theme.of(context).brightness == Brightness.light ?
                                            Colors.black : Colors.white,
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          if (userInput.isNotEmpty) {
                                            noteModel.editNote(index, userInput);
                                            userInput = '';
                                          }
                                          else {
                                            // ask for confirmation
                                            noteModel.removeNote(index);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SimpleButton(
                          icon: noteModel.getNote(index).checked ? Icons.check_circle : Icons.radio_button_unchecked,
                          onTap: () {
                            noteModel.toggleNoteCheckedMark(index);
                          },
                        ),
                        SimpleButton(
                          icon: Icons.delete,
                          onTap: () {
                            // ask for confirmation
                            noteModel.removeNote(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
